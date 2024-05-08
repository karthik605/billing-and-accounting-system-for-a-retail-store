const mongoose = require('mongoose');

// Connect to the "Employee" database
mongoose.connect('mongodb://localhost:27017/Warehouse');

// Define the schema for inventory items
const InventorySchema = new mongoose.Schema({
    "ITEM ID": String,
    "ITEM NAME": String,
    "ITEMS AVAILABLE": String,
    "PRICE(For item)": String
});

// Define the model for the inventory collection
const InventoryModel = mongoose.model("inventory", InventorySchema);

// Insert sample data into the "inventory" collection
const sampleInventoryData = [
    { "ITEM ID": "1", "ITEM NAME": "Item 1", "ITEMS AVAILABLE": "10", "PRICE(For item)": "10.00" },
    { "ITEM ID": "2", "ITEM NAME": "Item 2", "ITEMS AVAILABLE": "20", "PRICE(For item)": "20.00" },
    { "ITEM ID": "3", "ITEM NAME": "Item 3", "ITEMS AVAILABLE": "30", "PRICE(For item)": "30.00" },
    { "ITEM ID": "4", "ITEM NAME": "Item 4", "ITEMS AVAILABLE": "40", "PRICE(For item)": "40.00" },
    { "ITEM ID": "5", "ITEM NAME": "Item 5", "ITEMS AVAILABLE": "50", "PRICE(For item)": "50.00" },
    { "ITEM ID": "6", "ITEM NAME": "Item 6", "ITEMS AVAILABLE": "60", "PRICE(For item)": "60.00" },
    { "ITEM ID": "7", "ITEM NAME": "Item 7", "ITEMS AVAILABLE": "70", "PRICE(For item)": "70.00" },
    { "ITEM ID": "8", "ITEM NAME": "Item 8", "ITEMS AVAILABLE": "80", "PRICE(For item)": "80.00" },
    { "ITEM ID": "9", "ITEM NAME": "Item 9", "ITEMS AVAILABLE": "90", "PRICE(For item)": "90.00" },
    { "ITEM ID": "10", "ITEM NAME": "Item 10", "ITEMS AVAILABLE": "20", "PRICE(For item)": "20.00" },
    { "ITEM ID": "11", "ITEM NAME": "Item 11", "ITEMS AVAILABLE": "20", "PRICE(For item)": "20.00" },
    { "ITEM ID": "12", "ITEM NAME": "Item 12", "ITEMS AVAILABLE": "20", "PRICE(For item)": "20.00" },
    { "ITEM ID": "13", "ITEM NAME": "Item 13", "ITEMS AVAILABLE": "20", "PRICE(For item)": "20.00" },
    { "ITEM ID": "14", "ITEM NAME": "Item 14", "ITEMS AVAILABLE": "20", "PRICE(For item)": "20.00" },
    // Add more sample documents as needed
];

// Insert sample data into the "inventory" collection
InventoryModel.insertMany(sampleInventoryData)
    .then(() => {
        console.log("Sample inventory data inserted successfully.");
    })
    .catch(err => {
        console.error("Error inserting sample inventory data:", err);
    });
