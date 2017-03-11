[@@@ocaml.warning "-27-30-39"]

type person = {
  name : string;
  id : int32;
  email : string option;
  phone : string list;
}

and person_mutable = {
  mutable name : string;
  mutable id : int32;
  mutable email : string option;
  mutable phone : string list;
}

let rec default_person 
  ?name:((name:string) = "")
  ?id:((id:int32) = 0l)
  ?email:((email:string option) = None)
  ?phone:((phone:string list) = [])
  () : person  = {
  name;
  id;
  email;
  phone;
}

and default_person_mutable () : person_mutable = {
  name = "";
  id = 0l;
  email = None;
  phone = [];
}

let rec decode_person d =
  let v = default_person_mutable () in
  let id_is_set = ref false in
  let name_is_set = ref false in
  let rec loop () = 
    match Pbrt.Decoder.key d with
    | None -> (
      v.phone <- List.rev v.phone;
    )
    | Some (1, Pbrt.Bytes) -> (
      v.name <- Pbrt.Decoder.string d; name_is_set := true;
      loop ()
    )
    | Some (1, pk) -> raise (
      Protobuf.Decoder.Failure (Protobuf.Decoder.Unexpected_payload ("Message(person), field(1)", pk))
    )
    | Some (2, Pbrt.Varint) -> (
      v.id <- Pbrt.Decoder.int32_as_varint d; id_is_set := true;
      loop ()
    )
    | Some (2, pk) -> raise (
      Protobuf.Decoder.Failure (Protobuf.Decoder.Unexpected_payload ("Message(person), field(2)", pk))
    )
    | Some (3, Pbrt.Bytes) -> (
      v.email <- Some (Pbrt.Decoder.string d);
      loop ()
    )
    | Some (3, pk) -> raise (
      Protobuf.Decoder.Failure (Protobuf.Decoder.Unexpected_payload ("Message(person), field(3)", pk))
    )
    | Some (4, Pbrt.Bytes) -> (
      v.phone <- (Pbrt.Decoder.string d) :: v.phone;
      loop ()
    )
    | Some (4, pk) -> raise (
      Protobuf.Decoder.Failure (Protobuf.Decoder.Unexpected_payload ("Message(person), field(4)", pk))
    )
    | Some (_, payload_kind) -> Pbrt.Decoder.skip d payload_kind; loop ()
  in
  loop ();
  begin if not !id_is_set then raise Protobuf.Decoder.(Failure (Missing_field "id")) end;
  begin if not !name_is_set then raise Protobuf.Decoder.(Failure (Missing_field "name")) end;
  ({
    name = v.name;
    id = v.id;
    email = v.email;
    phone = v.phone;
  } : person)

let rec encode_person (v:person) encoder = 
  Pbrt.Encoder.key (1, Pbrt.Bytes) encoder; 
  Pbrt.Encoder.string v.name encoder;
  Pbrt.Encoder.key (2, Pbrt.Varint) encoder; 
  Pbrt.Encoder.int32_as_varint v.id encoder;
  (
    match v.email with 
    | Some x -> (
      Pbrt.Encoder.key (3, Pbrt.Bytes) encoder; 
      Pbrt.Encoder.string x encoder;
    )
    | None -> ();
  );
  List.iter (fun x -> 
    Pbrt.Encoder.key (4, Pbrt.Bytes) encoder; 
    Pbrt.Encoder.string x encoder;
  ) v.phone;
  ()

let rec pp_person fmt (v:person) = 
  let pp_i fmt () =
    Format.pp_open_vbox fmt 1;
    Pbrt.Pp.pp_record_field "name" Pbrt.Pp.pp_string fmt v.name;
    Pbrt.Pp.pp_record_field "id" Pbrt.Pp.pp_int32 fmt v.id;
    Pbrt.Pp.pp_record_field "email" (Pbrt.Pp.pp_option Pbrt.Pp.pp_string) fmt v.email;
    Pbrt.Pp.pp_record_field "phone" (Pbrt.Pp.pp_list Pbrt.Pp.pp_string) fmt v.phone;
    Format.pp_close_box fmt ()
  in
  Pbrt.Pp.pp_brk pp_i fmt ()
