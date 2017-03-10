let () = 
  (* Create OCaml value of generated type *) 

  let person = Example01_pb.({ 
    name = "John Doe"; 
    id = 1234l;
    email = Some "jdoe@example.com"; 
    phone = ["123-456-7890"];
  }) in 
  
  (* Create a Protobuf encoder and encode value *)

  let encoder = Pbrt.Encoder.create () in 
  Example01_pb.encode_person person encoder; 
  let buffer = Pbrt.Encoder.to_bytes encoder in 

  Js.log "Encoded message:";
  Js.log buffer;

  let decoder = Pbrt.Decoder.of_bytes buffer in 
  let person' = Example01_pb.decode_person decoder in 

  Js.log "Decoded message:";
  Js.log (Format.asprintf "%a" Example01_pb.pp_person person')
