const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.addUserToDB = functions.auth.user().onCreate( async (user) => {
  const {uid, displayName, email, photoURL, providerData} = user;
  return await admin.firestore().collection("users")
      .doc(uid).set({userID: uid, 
        displayName: providerData[0].providerId == "password" ? "" : displayName,
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

