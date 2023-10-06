const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.createProfile = functions.auth.user().onCreate((user, data) => {
  console.log("user info in func =>", user);
  const userPhoto = data.signingProvider === "FACEBOOK" ?
  data.fbPhotoUrl : user.photoUrl;
  const userData = {
    "displayName": user.displayName,
    "email": user.email,
    "photoURL": userPhoto,
    "provider": data.signingProvider,
    "userID": user.uid,
  };

  return admin.firestore().doc("users/"+user.uid).set(userData);
  // or admin.firestore().doc('users').add(userObject); for auto generated ID
});

exports.addAdminRole = functions.https.onCall((data, context)=>{
  // only admin made admin
  // if (context.auth.token.admin !== true) {
  //     return {error: 'Admin can add another admin'};
  // }

  return admin.auth().getUserByEmail(data.email).then((user) => {
    return admin.auth.getAuth().setCustomUserClaims(user.uid, {
      admin: true,
    });
  }).then(() => {
    return {
      "message": `Success! ${data.email} has been made an admin`,
    };
  }).catch((err) => {
    return err;
  });
});

