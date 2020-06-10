require('dotenv').config({ path: '.env' });
const firebase = require('firebase');
require('firebase/storage');
const XMLHttpRequest = require("xhr2");
global.XMLHttpRequest = XMLHttpRequest

var firebaseConfig = {
  // apiKey: process.env.FIREBASE_API_TOKEN,
  apiKey: process.env.FIREBASE_API_TOKEN,
  authDomain: "flutterbeer.firebaseapp.com",
  databaseURL: "https://flutterbeer.firebaseio.com",
  projectId: "flutterbeer",
  storageBucket: "flutterbeer.appspot.com",
  messagingSenderId: "1014860394889",
  appId: "1:1014860394889:web:1433e64edd7a38c34e7158"
};
firebase.initializeApp(firebaseConfig);

module.exports = firebase;