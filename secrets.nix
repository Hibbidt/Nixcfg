let
  #SYSTEMS
  FWL12 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILEb/J3EHaZBUxI+iy4pBtKfUqtBPCZbx2Hiw5wmu0ZE";
  AQUILA = "AAAAC3NzaC1lZDI1NTE5AAAAIHjjDCTTaJU+2TdGy9nTzC18Y8L5yt+PzJpgODVBcP/S";

  #USERS
  corvus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKVuHn4m7xbprQKnMLLKqFdXlCKrTAfxhXIdJUxbtcl corvus@FWL12";

  users = [corvus];
  systems = [AQUILA FWL12];
in {
  "secrets/NM.age".publicKeys = systems ++ users;
}
