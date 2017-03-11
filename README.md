# bs-protobuf

> Prototype the use of ocaml-protoc with BuckleScript for Isomorphic type sharing and serialization
> between a Javascript client and server. Note that the OCaml code is also usable with 
> a native server.

The application consists in a server exposing a `/person` endpoint which returns a value of the ocaml type
[person](src/shared/example01/example01_pb.mli). This person type was generated with the 
[ocaml-protoc](http://github.com/mransan/ocaml-protoc/) compiler. The value returned by the server is using the 
generated protobuf encoding as well as a Base64 encoding.

The client side of the application uses the same shared code to `decode` the message and pretty-print the 
person value. 

**[src/shared](src/shared)**

This directory constains all the OCaml code shared by both client and server. 

First it contains OCaml libraries which are in OPAM but not in NPM. Long term solution would be to create npm packages
for such libraries:
* [ocaml-base64](https://github.com/mirage/ocaml-base64): A popular OCaml library for Base64 encoding
* [ppx_deriving_protobuf](https://github.com/whitequark/ppx_deriving_protobuf): Low-level function for protobuf serialization
* [ocaml-protoc](http://github.com/mransan/ocaml-protoc/): The runtime library for the generated code 

Second it contains the actual application code which consist in a single type definition (`person`) along with the 
encoding/decoding/pretty-print functions. 
* [example01](src/shared/example01)

**[src/client](src/client)**

Client side code simply makes repetitive AJAX queries to the server for randomly generated person data. It then display
the decoded value.

**[src/server](src/server)**

Server side code consists in an a simple OCaml module to generate random value of the `person` type. It also contain the
express server.
