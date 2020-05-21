const express = require('express')
const router = express.Router()
const axios = require('axios');

router.get('/login', (req,res) => {
    res.send('Login route');
});

module.exports = router