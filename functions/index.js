const functions = require("firebase-functions");
const cors = require("cors")({ origin: true });
const Busboy = require("busboy");

const os = require("os");
const path = require("path");
const fs = require("fs");
const uuid = require("uuid/v4");
const fbAdmin = require("firebase-admin");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

const gcconfig = {
  projectId: "my-products-370c8",
  keyFilename: "flutter-products.json"
};

const { Storage } = require("@google-cloud/storage");

const gcs = new Storage(gcconfig);

fbAdmin.initializeApp({
  credential: fbAdmin.credential.cert(require("./flutter-products.json"))
});

exports.storeImage = functions.https.onRequest((req, res) => {
  //return cors function with req, and res which will set headers
  return cors(req, res, () => {
    if (req.method !== "POST")
      return res.status(500).json({
        message: "Only Post required"
      });
    //omitting header authorization request : making it public
    const busboy = new Busboy({ headers: req.headers }); //for parsing request and file
    let uploadData;
    let oldImagePath;
    busboy.on("file", (fieldname, file, filename, encoding, mimetype) => {
      const filePath = path.join(os.tmpdir(), filename);
      uploadData = { filePath, type: mimetype, name: filename };
      file.pipe(fs.createWriteStream(filePath));
    });

    //on file event
    busboy.on("field", (fieldNmae, value) => {
      oldImagePath = decodeURIComponent(value);
    });
    // on finish event
    busboy.on("finish", () => {
      const bucket = gcs.bucket("my-products-370c8.appspot.com");
      const id = uuid();
      let imagePath = "images/" + id + "-" + uploadData.name;
      if (oldImagePath) {
        imagePath = oldImagePath;
      }
      return bucket
        .upload(uploadData.filePath, {
          uploadType: "media",
          destination: imagePath,
          metadata: {
            metadata: {
              contentType: uploadData.type
            }
          }
        })
        .then(() => {
          return res.status(201).json({
            imageUrl:
              "https://firebasestorage.googleapis.com/v0/b/" +
              bucket.name +
              "/o/" +
              encodeURIComponent(imagePath) +
              "?alt=media",
            imagePath: imagePath //adde
          });
        })
        .catch(err => {
          return res.status(401).json({ error: new Error(err) });
        });
    });

    return busboy.end(req.rawBody);
  });
});

exports.deleteImage = functions.https.onRequest((req, res) => {
  return cors(req, res, () => {
    let { imagePath } = req.body || {};
    if (!imagePath) {
      return res.status(500).json({ message: "image path can not be null" });
    }
    const bucket = gcs.bucket("my-products-370c8.appspot.com");
    return bucket
      .file(imagePath)
      .delete()
      .then(() => {
        res.status(201).json({ message: "image deleted successfully" });
      })
      .catch(err => {
        return res.status(401).json({ error: new Error(err) });
      });
  });
});
