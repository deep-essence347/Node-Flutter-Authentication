const cloudinary = require("cloudinary").v2;

const imageMethods = {
	upload: async ({ filePath, folder, name }, cb) => {
		cloudinary.uploader.upload(
			filePath,
			{ folder: folder, public_id: name },
			function (err, result) {
				if (err) return cb(err);
				return cb(null, result);
			}
		);
	},
};

module.exports = imageMethods;
