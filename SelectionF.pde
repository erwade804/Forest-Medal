void drawHighLight() {
  int x = mouseX/40;
  int y = mouseY/40;
  if (x < 10 && y < 10) {
    if (mode == "NPC DELETE") {
      fill(255, 100, 100, 100);
    } else {
      fill(127, 255, 212, 100);
    }
    rect(x*40, y*40, 40, 40);
    mapHighlighted = true;
  } else {
    mapHighlighted = false;
  }
}


void drawSelection() {
  for (int i = 0; i < 5; i++) {
    pushMatrix();
    try {
      translate(420, 20 + i*80);
      int typeColor = 0;
      if (selectedType == "wall") {
        typeColor = 1;
      }
      image(loadImage(selectedType+"/"+(i+selectionScroll) + ".png"), typeColor, 0);
      if (mouseX > 420 && 460 > mouseX) {
        if (mouseY > 20+i*80 && 60 + i*80 > mouseY) {
          selectionHighlighted = true;
          fill(127, 255, 212, 100);
          rect(0, 0, 40, 40);
        }
      }
    }
    catch(Exception e) {
    }
    popMatrix();
  }
}

void selectedTypeAdd() {
  if (selectedType == "floor") {
    selectedType = "wall";
  } else if (selectedType == "wall") {
    selectedType = "NPC";
  } else if (selectedType == "NPC") {
    selectedType = "NPC DELETE";
  } else if (selectedType == "NPC DELETE") {
    selectedType = "floor";
  }
}
