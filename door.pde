class door {
  PVector mapLoc;
  PVector location;
  PVector goTo;

  door(PVector mainLocation, PVector miniLocation, PVector doorGoTo) {
    this.mapLoc = mainLocation;
    this.location = miniLocation;
    this.goTo = doorGoTo;
  }

  door() {
    // make nothing, nothing should be done, just setting up a door to be made so i don't have much work
  }

  void setMapLoc(PVector mainLocation) {
    this.mapLoc = mainLocation;
  }

  void setlocation(PVector loc) {
    this.location = loc;
  }

  void setGoTo(PVector go) {
    this.goTo = go;
  }

  void saveDoor() {
  }
}


void loadDoors() {
}
