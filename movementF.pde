void checkMove(int dx, int dy) {
  int x, y;
  x = (int)playerPosition.x%10;
  y = (int)playerPosition.y%10;
  if ((y == 0 && dy == 1) || (y == 9 && dy == -1) || (x == 0 && dx == 1) || (x == 9 && dx == -1)) {
    cameraMain.add(dx, dy);
    loadMainMap();
  }
  loadMap((int)cameraMain.x, (int)cameraMain.y);
  try {
    mainMap[4].mapImage.loadPixels();
  } 
  catch(Exception e) {
  }
  if (green(mainMap[4].mapImage.pixels[x*10 + y]) == 1) { // if its a wall
    playerPosition.x -= dx;
    playerPosition.y -= dy;
  }
  for (int i = 0; i < npcs.size(); i++) {
    if (cameraMain.x == npcs.get(i).mapNumber.x && cameraMain.y == npcs.get(i).mapNumber.y) {
      if (playerPosition.x%10 == npcs.get(i).location.x && playerPosition.y%10 == npcs.get(i).location.y) {
        playerPosition.x -= dx;
        playerPosition.y -= dy;
        mode = "textMenu";
        currentNPC = npcs.get(i);
        lineNumber = 0;
        return;
      }
    }
  }
}
