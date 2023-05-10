"use strict";
const mongoose = require('mongoose');
const TaskSchema = new mongoose.Schema({
    _id: {
        type: String,
        required: true
    },
    protein: {
        type: String,
        required: true
    },
    ligand: {
        type: String,
        required: true
    },
    energy: {
        type: Array,
        required: true
    },
    output: {
        type: String,
        required: true
    },
});
const Task = mongoose.model("prototype", TaskSchema);
module.exports = Task;
