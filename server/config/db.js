const mongoose = require("mongoose");
const config = require("./config");

const connectDB = async () => {
	try {
		var conn = await mongoose.connect(config.database, {
			useNewUrlParser: true,
			useUnifiedTopology: true,
		});
		console.log(`Database connected: ${conn.connection.host}`);
	} catch (error) {
		console.log(error);
		process.exit(1);
	}
};

module.exports = connectDB;
