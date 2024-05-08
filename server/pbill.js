const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();

app.use(cors());
app.use(express.json());

mongoose.connect('mongodb://localhost:27017/Warehouse');

const InventorySchema = new mongoose.Schema({
    "ITEM ID": String,
    "ITEM NAME": String,
    "ITEMS AVAILABLE": String,
    "PRICE(For item)": String
});

const SoldSchema = new mongoose.Schema({
    "ITEM ID": String,
    "ITEM NAME": String,
    "ITEMS SOLD": { type: Number, default: 0 } // Specify type as Number
});


const InventoryModel = mongoose.model("inventories", InventorySchema);
const SoldModel = mongoose.model("solds", SoldSchema);

app.get("/getinventory", (req, res) => {
    InventoryModel.find({})
        .then(function (inventory) {
            if (inventory.length === 0) {
                res.status(404).json({ error: "Inventory not found" });
            } else {
                res.json(inventory);
            }
        })
        .catch(function (err) {
            console.log("Error:", err);
            res.status(500).json({ error: "Internal server error" });
        });
});

app.get("/getsold", (req, res) => {
    SoldModel.find({})
        .then(function (soldItems) {
            if (soldItems.length === 0) {
                res.status(404).json({ error: "Sold items not found" });
            } else {
                res.json(soldItems);
            }
        })
        .catch(function (err) {
            console.log("Error:", err);
            res.status(500).json({ error: "Internal server error" });
        });
});


app.post("/print-bill", async (req, res) => {
    try {
        const { billItems } = req.body;

        // Ensure billItems is an array of objects
        if (!Array.isArray(billItems)) {
            throw new Error("billItems is not an array");
        }

        // Update inventories based on billed items
        for (const item of billItems) {
            const inventoryItem = await InventoryModel.findOne({ "ITEM ID": item['ITEM ID'] });
            if (inventoryItem) {
                // Subtract the quantity of sold items from the available quantity
                inventoryItem["ITEMS AVAILABLE"] = String(Number(inventoryItem["ITEMS AVAILABLE"]) - Number(item['ITEMS SOLD']));
                await inventoryItem.save();
            }
        }

        // Add billed items to the sold collection
        for (const item of billItems) {
            const existingSoldItem = await SoldModel.findOne({ "ITEM ID": item['ITEM ID'] });
            if (existingSoldItem) {
                // If item already exists, update the quantity
                await SoldModel.findOneAndUpdate(
                    { "ITEM ID": item['ITEM ID'] },
                    { $inc: { "ITEMS SOLD": Number(item['ITEMS SOLD']) } } // Increment the quantity
                );
            } else {
                // If item doesn't exist, insert a new document
                await SoldModel.insertMany(item);
            }
        }


        res.status(200).json({ message: "Bill printed successfully" });
    } catch (error) {
        console.log("Error updating inventories and adding billed items to sold collection:", error);
        res.status(500).json({ error: "Internal server error" });
    }
});

app.post("/addinventory", async (req, res) => {
    try {
        const { AddItems } = req.body;
        InventoryModel.insertMany(AddItems);
        res.status(200).json({ message: "Inventory item added successfully" });

        // const savedItem = await inventoryItem.save();

        // if (savedItem) {
        //     res.status(200).json({ message: "Inventory item added successfully", item: savedItem });
        // } else {
        //     res.status(500).json({ error: "Failed to save inventory item" });
        // }
    } catch (error) {
        console.log("Error adding inventory item:", error);
        res.status(500).json({ error: "Internal server error" });
    }
});


app.patch("/updateinventory", async (req, res) => {
    try {
        const { UpdateItems } = req.body;
        for (const item of UpdateItems) {
            const inventoryItem = await InventoryModel.findOne({ "ITEM ID": item['ITEM ID'] });
            if (inventoryItem) {
                inventoryItem["ITEMS AVAILABLE"] = String(Number(inventoryItem["ITEMS AVAILABLE"]) + Number(item['ITEMS AVAILABLE']));
                await inventoryItem.save();
                res.status(200).json({ message: "Inventory item updated successfully" });
            } else {
                res.status(404).json({ error: "Inventory item not found" });
            }
        }

    } catch (error) {
        console.log("Error updating inventory item:", error);
        res.status(500).json({ error: "Internal server error" });
    }
});



app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
