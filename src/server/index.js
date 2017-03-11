// The code on the server side is exposing 2 endpoing
// - '/' which returns the HTML file 
// - '/person' which calls the OCaml function random_person. 
//
// 'random_person' function is implemented using the shared code
// between server and client
//
// -----
// Note this file was not implemented in OCaml because I simply did not 
// look into available bindings to the express library
// ----- 

import express from 'express';

import { random_person } from '../../lib/js/src/server/random_person' 
  // Server side function which generate a random Example01_pb.person 
  // value then serialize it to Protobuf binary format and finally
  // encode it as Base64

const app = express(); 

app.use('/static', express.static('dist'));

app.get('/', (function (req, res) {
  res.send(`
<!doctype html>
<html>
  <head>
    <title>BS-Proto</title>
  </head>
  <body>
    <h1>BS Protobuf Test</h1>
    <div>
      <h4>Base64 Message:</h4>
      <p id="base64Message"></p>
    </div>
    <div>
      <h4>Person as a string:</h4>
      <p id="personString"></p>
    </div>
    <script src="/static/js/bundle.js"> </script>
  </body>
</html>
  `);
}));

app.get('/person', (req, res) => {
  res.send(random_person ()); 
});

app.listen(8000, () => { console.log("Web server started"); });
