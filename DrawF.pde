void drawPlayer() {
  image(playerImage, (int)playerCamera.x*40, (int)playerCamera.y*40);
}

void drawMap() { // draws the physical map

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      pushMatrix();
      translate(i*40, j*40);

      color tempColor = mainMap[4].mapImage.pixels[i * 10 + j];
      try {
        String tempType = "floor";
        if ((int)green(tempColor) == 1) {
          tempType = "wall";
          image(loadImage("floor/0.png"), 0, 0);
        }
        String imageName = tempType+"/"+(int)red(tempColor)+".png";
        PImage temp = loadImage(imageName);
        image(temp, 0, 0);
      }
      catch(Exception e) {
        fill(tempColor);
        stroke(tempColor);
        rect(0, 0, 40, 40);
      }
      popMatrix();
    }
  }
  // draw the npc's on the current map
  for (int i = 0; i < npcs.size(); i++) {
    if (cameraMain.x == npcs.get(i).mapNumber.x && cameraMain.y == npcs.get(i).mapNumber.y) {
      npcs.get(i).show();
    }
  }
}


void updateCharacter() { // updates player position
  playerCamera = new PVector(playerPosition.x%10, playerPosition.y%10);
  if (playerPosition.x < 0) {
    playerCamera.x = 9 + playerCamera.x;
  }
  if (playerPosition.y < 0) {
    playerCamera.y = 9 + playerCamera.y;
  }
  cameraMain.x = (int)playerPosition.x / 10;
  if (playerPosition.x < 0) {
    cameraMain.x -= 1;
  }
  cameraMain.y = (int)playerPosition.y / 10;
  if (playerPosition.y < 0) {
    cameraMain.y -= 1;
  }
}


void drawTextMenu() { // draws text menu, with current text on screen
  image(textBox, 0, 0);
  pushMatrix();
  scale(-1, 1);
  image(playerImage, -346, 204); // this specific place for the player
  popMatrix();
  image(currentNPC.image, 50, 204); // this specific place for the NPC/opponent
  drawText(currentNPC.lines[lineNumber]);
}

void drawTextMenuType() {
  image(textBox, 0, 0);
  drawText(newString);
}

void drawTheMode() { // draws the mode, more info in function
  if (wait > 0) {
    canTick = false;
    wait--;
    return;
  }
  colorMode(RGB);
  if (mode == "openWorld" && width == 480) {
    mode = "create";
  }
  updateCharacter(); // update the charactor before the frame is drawn
  if (mode == "openWorld") { // what to do in open world
    background(0); // background = black
    loadMainMap(); // load the main map
    drawMap(); // draw the playable area
    drawPlayer(); // draw the player
  } else if (mode == "mainMenu") { // what to do in main menu
    background(0, 0, 200); // background 200 blue
    drawMainMenu(); // draw the main menu
  } else if (mode == "create") { // what to do in create
    background(51); // background = 51 grey
    loadMainMap(); // load the main map
    drawMap(); // draw the playable area
    drawPlayer(); // draw the player
    drawSelection(); // draw the selection of blocks
    drawHighLight(); // draw the highlight for selection (off playable screen)
  } else if (mode == "textMenu") { // what to do in text menu
    loadMainMap(); // load the main map
    drawMap(); // draw the playable area
    drawPlayer(); // draw the player
    //drawTextMenu(); // draw the text menu so its not affected by the transparent rectangle
  } else if (mode == "battle") { // what to do in battle
    background(0, 250, 0); // create background
    image(backgroundBattle, 0, 0); // draw overlay
    drawCards(); // draw the cards
    if (toggleFight == true) { // toggle the fight to stop for a second to select attack style
      canTick = false; // stop ticking
    }
    if (!canTick) { // if no one can tick, something is happening, don't draw arrow
      drawArrow();
    }
  }
  if (mode == "textMenu") {
    fill(0, 0, 0, 220); // fill with a slightly transparent black
    rect(0, 0, 400, 400); // fill the playable screen
    drawTextMenu();
  }
  if (mode == "typingForNPC") {
    fill(0, 0, 0, 220);
    rect(0, 0, 400, 400);
    loadMainMap();
    drawMap();
    drawPlayer();
    drawTextMenuType();
  }
  updateKeys(); // every frame, update the key so it doesn't affect gameplay
}

void drawLines() { // debugging only
  stroke(0);
  for (int i = 0; i < 10; i++) {
    line(i*40, 0, i*40, height);
    line(0, i*40, width, i*40);
  }
}



void postProcessing() { // for gamejam, ignore this for now.
  noStroke();
  float f = frameCount/2;
  float x = cameraMain.x;
  float y = cameraMain.y;
  for (int i = -1; i < 100; i++) {
    for (int j = -1; j < 100; j++) { //noise(f+j*10*i*10, f+i*10+j*10)*256+10
      float k = noise(f/50.0-(j+x*5000)/50.0 + (i+y*3000)/30.0, f/20.0-(i+x*3000)/30.0 - (j+y*3000)/30.0)*256;
      if (k > noise(f/100.0, f/100.0)*256+10) {
        color colors = color(k+100, k);
        fill(colors);
        rect(i*4, j*4, 4, 4);
      }
    }
  }
}
