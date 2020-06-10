const express = require("express");
const router = express.Router();
const firebase = require("../firebase/config");
const axios = require("axios");

router.get("/ping", (req, res) => {
  res.send("ping");
});
// TODO: Logout, Create User (yawn)
// TODO: Move mapbox to server side
router.post("/login", (req, res, next) => {
  if (req.body) {
    let email = req.body.username;
    let password = req.body.password;
    try {
      firebase
        .auth()
        .signInWithEmailAndPassword(email, password)
        .then((response) => {
          refreshAvatar();
          res.status(201).send(response);
        })
        .catch((error) => {
          var errorCode = error.code;
          var errorMessage = error.message;
          res.status(404).send(errorMessage);
        });
    } catch (error) {
      res.status(404).send(error);
    }
  }
});

refreshAvatar  = async () => {
  const user = firebase.auth().currentUser;
  const storageRef = firebase.storage().ref(user.uid + "/avatar");
  try {
    const profilePicture = await storageRef.getDownloadURL();
    console.log(user);
    // Create user object
    let userProfile = {
      username: user.displayName,
      avatar: profilePicture,
    };
    user.updateProfile(userProfile);
  } catch (e) {
    res.send(e);
  }
}

router.get("/logout", (req, res) => {
  firebase.auth().signOut().then((response) => {
    res.send(response);
  }).catch((e) => {
    res.send(e);
  });
});

router.post("/createuser", (req, res) => {
  console.log(req.body);
  const avatar = req.body.avatar;
  const username = req.body.username;
  const email = req.body.email;
  const password = req.body.password;
  let downloadURL = '';
  var user = null;

  try {
    firebase
      .auth()
      .createUserWithEmailAndPassword(email, password)
      .then((response) => {
        user = firebase.auth().currentUser;
        //avatar
        const storageRef = firebase.storage().ref(user.uid + "/avatar");
        storageRef
          .put(Buffer.from(avatar, "base64"))
          .then((snapshot) => {
            console.log("Avatar uploaded!");
            downloadURL = snapshot.downloadURL;
          })
          .catch((e) => {
            console.log(e);
            res.send(e);
          });
        
        //user profile
        // const profile = { displayName: username, photoUrl: storageRef.getDownloadURL() };
        // user.updateProfile(profile);
        user.updateProfile({ displayName: username, photoURL: downloadURL });
        //email verification
        user
          .sendEmailVerification()
          .then((response) => {
            console.log(response);
            res.status(200).send("Success, Please verify your email address.");
          })
          .catch((error) => {
            res.send(error);
          });
      })
      .catch((e) => {
        console.log(e);
        res.status(400).send(e.message);
      });
  } catch (error) {
    console.log(error);
    res.send("Unable to create account. Please try again.");
  }
});

router.get("/currentUser", async (req, res) => {
  const user = firebase.auth().currentUser;
  const storageRef = firebase.storage().ref(user.uid + "/avatar");
  try {
    const profilePicture = await storageRef.getDownloadURL();
    console.log(profilePicture);
    // Create user object
    let userProfile = {
      username: user.displayName,
      avatar: profilePicture,
    };
    console.log(userProfile);
    res.send(userProfile);
  } catch (e) {
    res.send(e);
  }
});


//MapBox
// router.get('/breweries', (req, res) => {
//     var url =
//         `https://api.openbrewerydb.org/breweries?by_city=${req.body.city}&by_state=${req.body.state}`;

// });

module.exports = router;
