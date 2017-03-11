(** Wrapper module to encode/decode Example01_pb.person type from a
    base64 string *)

let base64_of_person person = 
  let encoder = Pbrt.Encoder.create () in 
  Example01_pb.encode_person person encoder; 
  Pbrt.Encoder.to_bytes encoder 
  |> Bytes.to_string 
  |> B64.encode

let person_of_base64 base64 = 
  base64
  |> B64.decode
  |> Bytes.of_string 
  |> Pbrt.Decoder.of_bytes 
  |> Example01_pb.decode_person 

let string_of_person person = 
  Format.asprintf "%a" Example01_pb.pp_person person
