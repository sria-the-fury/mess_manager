const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.addUserToDB = functions.auth.user().onCreate( async (user) => {
  const {uid, displayName, email, photoURL} = user;
  return await admin.firestore().collection("users")
      .doc(uid).set({userID: uid, displayName, email, photoURL});
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
  console.log("user => ", user);
  if (user.email && !user.emailVerified &&
     context.eventType.indexOf(":facebook.com") !== -1) {
    console.log("context =>", context);
    return {
      emailVerified: true,
    };
  }
});

