"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const child_process_1 = require("child_process");
const express = require('express');
const app = express();
const cors = require('cors');
const multer = require('multer');
const mongoose = require('mongoose');
const TaskSchema = require('./TaskSchema');
let db = mongoose
    .connect('mongodb://localhost:1000/tasks', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
    .then((res) => {
    console.log('Connected');
});
mongoose.connection.on('connected', () => {
    console.log('Connected to MongoDB');
    mongoose.connection.db
        .listCollections()
        .toArray((err, collections) => {
        console.log('Collections');
        if (err) {
            console.log(err);
        }
        else {
            console.log('Collections:');
            collections.forEach((collection) => {
                console.log(collection.name);
            });
        }
    });
});
mongoose.connection.on('error', (err) => {
    console.log('Error connecting to MongoDB:', err);
});
app.use(cors());
const storageProteins = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, `uploads/proteins`);
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
        console.log(uniqueSuffix);
        let ext = file.originalname.split('.')[1];
        cb(null, file.originalname + '-' + uniqueSuffix + '.' + ext);
    },
});
const storageLignads = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, `uploads/ligands`);
    },
    filename: function (req, file, cb) {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
        console.log(file);
        let ext = file.originalname.split('.')[1];
        cb(null, file.originalname + '-' + uniqueSuffix + '.' + ext);
    },
});
const uploadProteins = multer({ storage: storageProteins });
const uploadLignds = multer({ storage: storageLignads });
app.get('/', (req, res) => {
    res.send('Hello wolrd from mac');
});
app.post('/proteins', uploadProteins.array('proteins'), (req, res) => {
    res.send('Proteins Upload');
});
app.post('/ligands', uploadLignds.array('ligands'), (req, res) => {
    res.send('Hello Lignds');
});
app.post('/wild', (req, res) => {
    console.log('started Wild');
    const command = 'cd ./DockScript && julia ./app.jl';
    (0, child_process_1.exec)(command, (error, stdout, stderr) => {
        res.send('done');
        if (error) {
            console.log('ERROR', error);
        }
        if (stderr) {
            console.log('EROOOOOE');
        }
        console.log('Somethinggggg');
    });
});
app.get('/getalltasks', (req, res) => {
    TaskSchema.find({}).then((r) => {
        console.log(r);
        res.send(r);
    }).catch((err) => {
        console.log(err);
        res.send(err);
    });
});
app.listen(3000, () => {
    console.log('Backedn start at 3000');
});
