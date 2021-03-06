void loadMainMap() {
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      int loc = 3*(i+1) + j + 1;
      mainMap[loc] = loadMap((int)cameraMain.x+i, (int)cameraMain.y+j);
    }
  }
}

Map createMap(int x, int y) {
  return new Map(x, y);
}

Map loadMap(int x, int y) {  // loads map, if none can be loaded, makes a new map.
  String fileName = "map/map-"+x+"-"+y+".png"; 
  try {
    return new Map(x, y);
  }
  catch(Exception e) {
    PImage temp = createImage(10, 10, RGB);
    temp.loadPixels();
    for (int i = 0; i < 100; i++) {
      temp.pixels[i] = color(0, 0, 0);
    }
    temp.save(fileName);
    return createMap(x, y);
  }
}
