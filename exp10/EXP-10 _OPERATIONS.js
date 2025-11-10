// ===================== BOOKSTORE DATABASE SETUP =====================
use bookstore_db

// ======================= INSERT OPERATIONS =======================

// Insert a single document
db.books.insertOne({
  title: "The Alchemist",
  author: "Paulo Coelho",
  genre: "Fiction",
  price: 450,
  pages: 208,
  publisher: "HarperCollins",
  fuel_type: "N/A",
  features: ["Inspirational", "Adventure"],
  available: true
});

// Insert multiple documents
db.books.insertMany([
  {
    title: "Atomic Habits",
    author: "James Clear",
    genre: "Self-Help",
    price: 550,
    pages: 320,
    publisher: "Penguin",
    fuel_type: "N/A",
    features: ["Productivity", "Motivation"],
    available: true
  },
  {
    title: "Wings of Fire",
    author: "A.P.J. Abdul Kalam",
    genre: "Autobiography",
    price: 400,
    pages: 180,
    publisher: "Universities Press",
    fuel_type: "N/A",
    features: ["Inspiration", "Biography"],
    available: false
  },
  {
    title: "Deep Work",
    author: "Cal Newport",
    genre: "Self-Help",
    price: 600,
    pages: 304,
    publisher: "Grand Central",
    fuel_type: "N/A",
    features: ["Focus", "Discipline"],
    available: true
  }
]);

// ======================= READ OPERATIONS =======================

// Find all documents
db.books.find();

// Find one document
db.books.findOne();

// Find specific columns (title, price only)
db.books.find({}, { _id: 0, title: 1, price: 1 });

// Find with condition (books with price > 500)
db.books.find({ price: { $gt: 500 } });

// Add nested document
db.books.updateOne(
  { title: "The Alchemist" },
  { $set: { publication: { year: 1988, country: "Brazil" } } }
);

// Find nested document
db.books.find({ "publication.country": "Brazil" });

// ======================= UPDATE OPERATIONS =======================

// Update one document
db.books.updateOne(
  { title: "The Alchemist" },
  { $set: { price: 500 } }
);

// Add new value inside an array using $push
db.books.updateOne(
  { title: "Atomic Habits" },
  { $push: { features: "Habit Tracking" } }
);

// Remove a value from array using $pull
db.books.updateOne(
  { title: "Atomic Habits" },
  { $pull: { features: "Motivation" } }
);

// Update many documents (add new field)
db.books.updateMany({}, { $set: { language: "English" } });

// Add same feature in all documents
db.books.updateMany({}, { $push: { features: "Reader Favorite" } });

// Remove a field using $unset
db.books.updateOne(
  { title: "Deep Work" },
  { $unset: { publisher: "" } }
);

// Add new column to all documents
db.books.updateMany({}, { $set: { colors: ["Blue", "Green"] } });

// Upsert (update or insert if not exists)
db.books.updateOne(
  { title: "Ikigai" },
  {
    $set: { author: "Héctor García", genre: "Self-Help", price: 450 },
  },
  { upsert: true }
);

// ======================= DELETE OPERATIONS =======================

// Delete one document
db.books.deleteOne({ title: "Deep Work" });

// Delete many with condition
db.books.deleteMany({ price: { $lt: 500 } });

// Delete all documents
db.books.deleteMany({});

// ======================= GROUPING / AGGREGATION =======================

// Group by author – count books
db.books.aggregate([
  {
    $group: {
      _id: "$author",
      total_books: { $sum: 1 }
    }
  }
]);

// Group by genre – average price
db.books.aggregate([
  {
    $group: {
      _id: "$genre",
      avg_price: { $avg: "$price" }
    }
  }
]);

// Group by availability
db.books.aggregate([
  {
    $group: {
      _id: "$available",
      count: { $sum: 1 }
    }
  }
]);

// Find number of books for each genre
db.books.aggregate([
  {
    $group: {
      _id: "$genre",
      TotalBooks: { $sum: 1 }
    }
  }
]);
