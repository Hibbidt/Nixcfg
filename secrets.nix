let
  #SYSTEMS
  FWL12 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILEb/J3EHaZBUxI+iy4pBtKfUqtBPCZbx2Hiw5wmu0ZE";
  AQUILA = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINHrjXkp4N3icjS9nUvlzPOCeR/s68utauIEkGfy4ufu";

  #USERS
  corvus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKVuHn4m7xbprQKnMLLKqFdXlCKrTAfxhXIdJUxbtcl corvus@FWL12";

  users = [corvus];
  systems = [AQUILA FWL12];

in {
  "secrets/NM.age".publicKeys = systems ++ users;
}
