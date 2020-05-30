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

router.get("/logout", (req, res) => {
  try {
    firebase.auth().signOut();
  } catch {
    res.status(404).send("No account found to logout.");
  }
});

router.post("/createuser", (req, res) => {
  console.log(req.body);
  const avatar = req.body.avatar;
  const username = req.body.username;
  const email = req.body.email;
  const password = req.body.password;

  try {
    firebase
      .auth()
      .createUserWithEmailAndPassword(email, password)
      .then((res) => {
        let user = firebase.auth().currentUser;
        //avatar
        const storageRef = firebase.storage().ref(user.uid + "/avatar");
        storageRef
          .put(Buffer.from(avatar,'base64'))
          .then(() => {
            console.log("Avatar uploaded!");
          })
          .catch((e) => {
            console.log(e);
            res.send(e);
          });
        //user profile
        const profile = { displayName: username, photoUrl: storageRef.child(user.uid + '/avatar') };
        user.updateProfile(profile);
        //email verification
        user
          .sendEmailVerification()
          .then((res) => {
            console.log(res);
            res.status(200).send("Success, Please verify your email address.");
          })
          .catch((error) => {
            res.send(error.message);
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

//MapBox
// router.get('/breweries', (req, res) => {
//     var url =
//         `https://api.openbrewerydb.org/breweries?by_city=${req.body.city}&by_state=${req.body.state}`;

// });

module.exports = router;
