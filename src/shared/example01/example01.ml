(** Wrapper module to encode/decode Example01_pb.person type from a
    base64 string *)

let binary_of_person person = 
  let encoder = Pbrt.Encoder.create () in 
  Example01_pb.encode_person person encoder; 
  Pbrt.Encoder.to_bytes encoder 
  |> Bytes.to_string 

let base64_of_person person = 
  binary_of_person person
  |> B64.encode

let person_of_binary s = 
  s
  |> Bytes.of_string 
  |> Pbrt.Decoder.of_bytes 
  |> Example01_pb.decode_person 

let person_of_base64 base64 = 
  base64
  |> B64.decode
  |> person_of_binary 

let string_of_person person = 
  Format.asprintf "%a" Example01_pb.pp_person person
