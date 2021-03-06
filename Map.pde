class Map {
  PVector miniMapCords;
  PImage mapImage;
  String FILENAME;

  Map(int x, int y) { // creates a new map, to avoid any errors, creates a blank map
    this.miniMapCords = new PVector(x, y);
    FILENAME = "map/map-"+x+"-"+y+".png";
    try {
      this.mapImage = loadImage(FILENAME);
      this.mapImage.loadPixels();
    }
    catch(Exception e) {
      this.mapImage = createImage(10, 10, RGB);
      this.mapImage.save(FILENAME);
    }
  }

  Map(Map preMap, int x, int y) {
    PVector temp = preMap.miniMapCords;
    temp.add(x, y);
    this.miniMapCords = new PVector(temp.x, temp.y);
    FILENAME = "map/map-"+(int)temp.x+"-"+(int)temp.y+".png";
    this.mapImage = loadImage(FILENAME);
  }
}
