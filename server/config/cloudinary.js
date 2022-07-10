const cloudinary = require("cloudinary").v2;
const multer = require("multer");

const cloudinaryMethods = {
	connectCloudinary: () => {
		try {
			cloudinary.config({
				cloud_name: "deepessence",
				api_key: process.env.CLOUDINARY_API_KEY,
				api_secret: process.env.CLOUDINARY_API_SECRET,
			});
			console.log("Cloudinary Connected.");
		} catch (error) {
			console.log(e.message);
			process.exit(1);
		}
	},

	configStorage: (name) => {
		var storage = multer.diskStorage({
			filename: function (_, file, callback) {
				callback(null, Date.now() + file.originalname);
			},
		});
		return multer({ storage: storage }).single(name);
	},
};

module.exports = cloudinaryMethods;
