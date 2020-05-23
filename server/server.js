const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();
const PORT = 3000;
const router = require('./api/routes');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cors({ credentials: true, origin: true }));

app.use('/api', router);

app.listen(PORT, () => {
    console.log(`App listening on PORT: ${PORT}`)
});