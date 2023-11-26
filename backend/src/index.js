const app = require("./app");
const {connect} = require('./db')

async function main() {
    //Database connection
    await connect();
    //Express applicattion
  await app.listen(7000);
  console.log('Server on port 7000: Connected')
}

main();
