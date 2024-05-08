const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();

app.use(cors());

mongoose.connect('mongodb://localhost:27017/Employee');

const AdminSchema = new mongoose.Schema({
    userId: String,
    password: String
});

const EmployeeSchema = new mongoose.Schema({
    userId: String,
    password: String
});



const AdminModel = mongoose.model("admins", AdminSchema);
const EmployeeModel = mongoose.model("employees", EmployeeSchema); // Define Employee model

app.get("/getadmins", (req, res) => {
    AdminModel.find({}).then(function (admins) {
        res.json(admins);
    }).catch(function (err) {
        console.log(err);
        res.status(500).json({ error: "Internal server error" }); // Send 500 status code for internal server error
    });
});

app.get("/getemployees", (req, res) => { // Define route for fetching employees
    EmployeeModel.find({}).then(function (employees) {
        res.json(employees);
    }).catch(function (err) {
        console.log(err);
        res.status(500).json({ error: "Internal server error" });
    });
});



app.use(express.json());

// POST endpoint for login
app.post("/login", async (req, res) => {
    const { userId, password } = req.body;

    try {
        const admin = await AdminModel.findOne({ "USER ID": userId, "Password": password });
        if (admin) {
            res.json({ result: 1 }); // User is an admin
            return;
        }

        const employee = await EmployeeModel.findOne({ "USER ID": userId, "Password": password });
        if (employee) {
            res.json({ result: 2 }); // User is an employee
            return;
        }

        res.json({ result: 3 }); // User not found
    } catch (err) {
        console.log(err);
        res.status(500).json({ error: "Internal server error" });
    }
});


app.listen(3001, () => {
    console.log('server is running');
});
