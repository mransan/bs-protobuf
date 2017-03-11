// The code on the client is using the shared code from OCaml
// to decode the `base64 + protobuf` sent by the server, it then 
// pretty-print the decode OCaml value.
// pretty print of the 
//
// -----
// Note this file was not implemented in OCaml because I simply did not 
// look into available bindings to the various DOM API.
// ----- 

import {
  string_of_person, 
  person_of_binary} from '../../lib/js/src/shared/example01/example01' 

const base64MessageEl = document.getElementById("base64Message");
const personStringEl = document.getElementById("personString");

function requestRandomPerson() {
  const xhttp = new XMLHttpRequest();

  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      const person = person_of_binary(this.responseText);
      const personString= string_of_person(person);
      personStringEl.innerHTML = personString; 
      base64MessageEl.innerHTML = 
        new String(this.responseText.length) + 
        " | " + 
        new String(personString.length);
    }
  };
  xhttp.open("GET", "/person", true);
  xhttp.send();
}

setInterval(requestRandomPerson, 1000);
