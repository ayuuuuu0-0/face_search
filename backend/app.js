const express = require("express");
const path = require("path");
const app = express();
const port = 3000;

// Serve static files from the "public" directory
app.use("/images", express.static(path.join(__dirname, "images")));

// Dummy database of images
const imagesDb = {
  hrithik: [
    "image1.jpeg",
    "image2.jpeg",
    "image3.jpeg",
    "image4.jpeg",
    "image5.jpeg",
  ],
  // Add more entries as needed
};

app.get("/get_images/:name", (req, res) => {
  const name = req.params.name;
  if (imagesDb[name]) {
    // Convert filenames to URLs
    const imageUrls = imagesDb[name].map(
      (filename) => `http://localhost:${port}/images/${filename}`
    );
    res.json(imageUrls);
  } else {
    res.status(404).json({ error: "No images found for this name" });
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
