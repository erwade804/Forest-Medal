

void mousePressed() { // when mouse pressed
  if (mode == "create" && mouseButton == RIGHT) {
  }
  if (mode == "create") { // if in create
    if (selectionHighlighted) { // if block is highlighted
      for (int i = 0; i < 5; i++) { // get the color of the block (in code not visual color)
        if (mouseX >420 && 460 > mouseX) {
          if (mouseY > 20+i*80 && 60 + i*80 > mouseY) {
            color temp = selectedColor;
            int typeColor = 0;
            if (selectedType == "wall") {
              typeColor = 1;
            } else if (selectedType == "NPC") {
              typeColor = 2;
              created.spriteIndex = i+selectionScroll;
              return;
            }
            selectedColor = color(i + selectionScroll, typeColor, 0);
            try {
              PImage tempImage = loadImage(selectedType+"/"+(i+selectionScroll-1) +".png");
              image(tempImage, -40, -40);
            }
            catch(Exception E) {
              selectedColor = temp;
            }
          }
        }
      }
      if (mapHighlighted) { // if on the map
        if (selectedType == "NPC") { // if youre block is an NPC
          int x = mouseX/40;
          int y = mouseY/40;
          int npcNum = db.getMaxNPC()+1;
          int tempNum = created.spriteIndex;
          created = new npc(cameraMain, new PVector(x, y)); // make new NPC
          created.spriteIndex = tempNum;
          created.number = npcNum;
          mode = "typingForNPC";
          return;
        } else if (selectedType == "NPC DELETE") { // edit the text of the NPC, (or change the sprite???)
          int x = mouseX/40;
          int y = mouseY/40;
          for (int i = 0; i < npcs.size(); i++) {
            npc temp = npcs.get(i);
            if (temp.mapNumber == cameraMain) {
              if (temp.location == new PVector(x, y)) {
                // go into text changing mode, to update the npc text.
              }
            }
          }
        }
        String fileName = "map/map-"+(int)cameraMain.x+"-"+(int)cameraMain.y+".png"; // gets map file name
        int x = mouseX/40;
        int y = mouseY/40;
        try {
          mainMap[4].mapImage.loadPixels(); // loads the map
          mainMap[4].mapImage.pixels[x*10+y] = selectedColor; // changes the map's NPC
          mainMap[4].mapImage.save(fileName); // saves map
        }
        catch(Exception e) { //just in case
        }
      }
    }
  } else if (mode == "mainMenu") { // if on main menu
    if (!options) { // if not in option menu
      if (mouseX > 25*4 && mouseX < 75*4) { 
        if (mouseY > 30*4 && mouseY < 45*4) { // if on play button
          mode = "textMenu"; // start the first sequence
          currentNPC = startNPC;
        } else if (mouseY > 55*4 && mouseY < 70*4) {
          options = !options;
        }
      }
    } else if (mouseX > width/2 - 60 && mouseX < width/2 + 60) { // if on exit button
      if (mouseY > height/2-30 && mouseY < height/2 + 30) {
        exit(); // exit
      } else if (mouseY > 55*4 && mouseY < 70*4) {
        options = !options; // open options menu if on options button
      }
    }
  }
}

void mouseDragged() { //used specifically for create
  if (mode == "create") {
    if (selectionHighlighted) {
      for (int i = 0; i < 5; i++) {
        if (mouseX >420 && 460 > mouseX) {
          if (mouseY > 20+i*80 && 60 + i*80 > mouseY) {
            color temp = selectedColor;
            int typeColor = 0;
            if (selectedType == "wall") {
              typeColor = 1;
            } else if (selectedType == "NPC") {
              typeColor = 2;
              return;
            }
            selectedColor = color(i + selectionScroll, typeColor, 0);
            try {
              PImage tempImage = loadImage(selectedType+"/"+(i+selectionScroll) +".png");
              image(tempImage, -40, -40);
            }
            catch(Exception E) {
              selectedColor = temp;
            }
          }
        }
      }
      if (mapHighlighted) {
        if (selectedType != "NPC") {

          String fileName = "map/map-"+(int)cameraMain.x+"-"+(int)cameraMain.y+".png";
          int x = mouseX/40;
          int y = mouseY/40;
          try {
            mainMap[4].mapImage.loadPixels();
            mainMap[4].mapImage.pixels[x*10+y] = selectedColor;
            mainMap[4].mapImage.save(fileName);
          }
          catch(Exception e) {
          }
        }
      }
    }
  }
}

void keyPressed() { 
  if (mode == "typingForNPC") {
    if (key == ENTER || key == RETURN) {
      if (newString.equals("")) {
        try {
          // save to npc and send to database
          created.lines = new String[newStringArray.size()];
          for (int i = 0; i < newStringArray.size(); i++) {
            created.lines[i] = newStringArray.get(i);
          }
          db.saveNPC(created);
          created = new npc();
          mode = "openWorld";
        }
        catch(Exception e) {
          println("insert failed, reason why:");
          println(e);
          mode = "openWorld";
        }
      } else {
        newStringArray.add(newString);
        newString = "";
        lineNumber +=1;
      }
    } else if (key == DELETE || key == BACKSPACE) {
      if (newString.length() > 0) {
        newString = newString.substring(0, newString.length() - 1);
      }
    }
    if (alphabet.contains(String.valueOf(key))) {
      newString = newString+key;
    }
  } else if (mode == "textMenu") { // if any key is pressed, next line on text menu
    nextLine();
  } else { // for all other situations
    if (key  == 'p') { // print the screen with p
      save("printScreen.png");
    }

    // for the following, we save the state of if the key was pressed this frame (when we check)
    if (key == 'a') {
      keys[0] = true;
    }
    if (key == 's') {
      keys[1] = true;
    }
    if (key == 'd') {
      keys[2] = true;
    }
    if (key == 'w') {
      keys[3] = true;
    }
    if (key == 'k') {
      keys[4] = true;
    }
    if (key == 'l') {
      keys[5] = true;
    }
    if (key == 'i') {
      keys[6] = true;
    }
    if (key == 'j') {
      keys[7] = true;
    }
    if (keyCode == RIGHT) {
      keys[8] = true;
    }
    if (keyCode == LEFT) {
      keys[9] = true;
    }
    if (keyCode == UP) {
      keys[10] = true;
    }
    if (keyCode == DOWN) {
      keys[11] = true;
    }
    if (keyCode == ENTER) {
      keys[12] = true;
    }
  }
}



void updateKeys() { // after the frame we save the keys on, we then check what should happen when the key is pressed. if anything does happen.
  if (mode == "openWorld") { // if we are in the open world
    if (keys[0] || keys[9]) { // a or left is pressed, move left
      playerPosition.x -= 1;
      checkMove(-1, 0);
      keys[0] = false;
      keys[9] =  false;
    }
    if (keys[1] || keys[11]) { // if s or down is pressed, move down
      playerPosition.y += 1;
      checkMove(0, 1);
      keys[1] = false;
      keys[11] = false;
    }
    if (keys[2] || keys[8]) { // if if d or right is pressed, move right
      playerPosition.x += 1;
      checkMove(1, 0);
      keys[2] = false;
      keys[8] = false;
    }
    if (keys[3] || keys[10]) { // if w or up is pressed, move up
      playerPosition.y -= 1;
      checkMove(0, -1);
      keys[3] = false;
      keys[10] = false;
    }
  } else if (mode == "create") { // if we are in create
    if (keys[0]) { // if a is pressed, move left
      playerPosition.x -= 1;
      checkMove(-1, 0);
      keys[0] = false;
    }
    if (keys[1]) { // if s is pressed, move down
      playerPosition.y += 1;
      checkMove(0, 1);
      keys[1] = false;
    }
    if (keys[2]) { // if d is pressed, move right
      playerPosition.x += 1;
      checkMove(1, 0);
      keys[2] = false;
    }
    if (keys[3]) { // if w is pressed, move up
      playerPosition.y -= 1;
      checkMove(0, -1);
      keys[3] = false;
    }
    if (keys[4]) { // if k is pressed, move map up
      cameraMain.add(0, -1);
      playerPosition.y += 10;
      keys[4] = false;
    }
    if (keys[5]) { // if l is pressed, move map right
      cameraMain.add(1, 0);
      playerPosition.x += 10;
      keys[5] = false;
    }
    if (keys[6]) { // if i is pressed, move map up
      cameraMain.add(0, 1);
      playerPosition.y -= 10;
      keys[6] = false;
    }
    if (keys[7]) { // if j is pressed, move map left
      cameraMain.add(-1, 0);
      playerPosition.x -= 10;
      keys[7] = false;
    }
    if (keys[8]) { // if right is pressed, add to select to select different versions of blocks
      selectedTypeAdd();
      keys[8] = false;
      selectionScroll = 0;
    }
    if (keys[9]) { // if left is pressed, do nothing
      keys[9] = false;
    }
    if (keys[10]) { // if up is pressed, try scrolling up
      if (selectionScroll != 0) {
        selectionScroll -= 1;
      }
      keys[10] = false;
    }
    if (keys[11]) { // if down is pressed, check if there is a block lower, if there is scroll down one
      try {
        image(loadImage(selectedType+"/"+int(selectionScroll+5)+".png"), 500, 500);
        selectionScroll += 1;
      }
      catch(Exception e) {
      }
      keys[11] = false;
    }
  } else if (mode == "battle") { // if in battle
    if (keys[8]) { // if right is pressed, select goes to the right
      selectionX = (selectionX+1)%2;
      keys[8] = false;
    }
    if (keys[9]) {  // if left is pressed, select goes to the left
      selectionX = (selectionX+1)%2;
      keys[9] = false;
    }
    if (keys[10]) { // if up is pressed, select goes up
      selectionY = (selectionY+1)%2;
      keys[10] = false;
    }
    if (keys[11]) { // if down is pressed, select goes down
      selectionY = (selectionY+1)%2;
      keys[11] = false;
    }
    if (keys[12]) { // if enter is pressed, save move
      if (moveType == "") {
        moveType = getMoveType();
        canTick = false;
        doMove();
        //wait = 1 * frameRate;
      }
    }
  }
}
