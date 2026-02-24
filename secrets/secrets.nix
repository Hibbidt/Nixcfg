let
  FWL12 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILEb/J3EHaZBUxI+iy4pBtKfUqtBPCZbx2Hiw5wmu0ZE";
  corvus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKVuHn4m7xbprQKnMLLKqFdXlCKrTAfxhXIdJUxbtcl corvus@FWL12";
in {
  "NM.age".publicKeys = [FWL12 corvus];
}
