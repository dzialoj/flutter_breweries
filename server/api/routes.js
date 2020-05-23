const express = require('express')
const router = express.Router();
const firebase = require('../firebase/config');
const axios = require('axios');

// TODO: Logout, Create User (yawn)
// TODO: Move mapbox to server side
router.post('/login', (req, res) => {
    if (req.body) {
        let email = req.body.username;
        let password = req.body.password;
        try {
            firebase.auth().signInWithEmailAndPassword(email, password).then((response) => {
                res.status(201).send(response);
            }).catch((error) => {
                var errorCode = error.code;
                var errorMessage = error.message;
                res.status(404).send(errorMessage);
            })
        } catch (error) {
            res.status(404).send(error);
        }
    }
});

router.get('/logout', (req, res) => { res.send('logout') });

module.exports = router