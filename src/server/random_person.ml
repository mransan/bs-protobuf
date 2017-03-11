let random_string len = 
  let bytes = Bytes.create len in 
  for i = 0 to (len - 1) do 
    Bytes.set bytes i (char_of_int (97 + (Random.int 26))) 
  done; 
  Bytes.to_string bytes  

let random_id max = 
  Random.int max |> Int32.of_int 

let random_email () = 
  String.concat "" [
    random_string 10;
    "@";
    random_string 5;
    ".com"
  ]

let random_phone () = 
  String.concat "" [
    "(917) "; 
    string_of_int (100 + (Random.int 800)); 
    "-";
    string_of_int (1000 + Random.int 8000); 
  ]

let random_person () = Example01_pb.({
  name = random_string 20; 
  id = random_id 4000; 
  email = Some (random_email ()); 
  phone = [
    random_phone (); 
    random_phone ();
  ];
}) |> Example01.binary_of_person
