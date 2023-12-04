const functions = require("firebase-functions");
const admin = require("firebase-admin");
require("datejs");

admin.initializeApp();

exports.addUserToDB = functions.auth.user().onCreate( async (user) => {
  const {uid, displayName, email, photoURL, providerData} = user;
  return await admin.firestore().collection("users")
      .doc(uid).set({userID: uid,
        displayName: providerData[0].providerId == "password" ?
        "" : displayName,
        email, photoURL: photoURL == null ? "" : photoURL,
        provider: providerData[0].providerId});
});

exports.addAdminRole = functions.https.onCall( async (data, context) => {
  // only admin made admin
  // if (context.auth.token.admin !== true) {
  //     return {error: 'Admin can add another admin'};
  // }
  console.log("Data from user =>", data.email);
  const user = await admin.auth().getUserByEmail(data.email);
  console.log("user =>", user);
  return admin.auth().setCustomUserClaims(user.uid, {dev: true});
});

exports.fbEmailVerify = functions.auth.user().beforeCreate((user, context) => {
  if (user.email && !user.emailVerified &&
     context.eventType.indexOf(":facebook.com") !== -1) {
    return {
      emailVerified: true,
    };
  }
});

exports.updateUserHouseId = functions.firestore.document("houses/{houseId}")
    .onCreate( async (snap, context) => {
      const {houseId, createdBy} = snap.data();
      return await admin.firestore().collection("users").doc(createdBy).set({
        houseId: houseId,
      }, {merge: true});
    });

exports.createEveryDayMealsDoc = functions.pubsub.schedule("00 20 * * *")
    .timeZone("Asia/Dhaka").onRun( async (context) => {
      const tomorrowDate = Date.today().addDays(1).toString("ddMMyyyy");
      return admin.firestore().collection("houses").get()
          .then( (query) => {
            if (query.empty) {
              console.log("No house Found");
            } else {
              query.forEach((doc) => {
                return admin.firestore().collection("houses")
                    .doc(doc.data().houseId).collection("meals")
                    .doc(`${tomorrowDate}`).set({
                      id: `${tomorrowDate}`,
                      createdAt: new Date(),
                      breakfastTakenBy: doc.data().mealsFor,
                      lunchTakenBy: doc.data().mealsFor,
                      dinnerTakenBy: doc.data().mealsFor,
                      breakfastNotTakenBy: [],
                      lunchNotTakenBy: [],
                      dinnerNotTakenBy: [],
                      guestsL: [],
                      guestsD: [],
                      guestsB: [],
                    }, {merge: true});
              });
            }
          });
    });

