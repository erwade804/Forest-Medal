
void drawText(String text) {
  fill(102, 205, 66);
  text = text + " ";
  String[] texts = text.split(" ");
  ArrayList <String> lines = new ArrayList<String>();
  String currentString = "";
  for (int i = 0; i < texts.length; i++) {
    String pastString = currentString;
    currentString += " " + texts[i];
    if (textWidth(currentString) > 200) {
      lines.add(pastString);
      currentString = texts[i];
    }
    if (i == texts.length-1) {
      lines.add(currentString);
    }
  }
  for (int i = 0; i < lines.size(); i++) {
    text(lines.get(i), 200, 290 + i * 20);
  }
}

void nextLine() {
  try {
    if (currentNPC.lines.length-1 == lineNumber) {
      lineNumber = 0;
      // next two lines for you battle
      // cameraMain = battleCamera;
      // player = battlePlacement;
      println(currentNPC.number);
      try {
        mode = "battle";
        loadBattle(currentNPC.number);
      }
      catch(Exception e) {
        mode = "openWorld";
      }
    } else {
      lineNumber += 1;
    }
  }
  catch(Exception e) {
  }
}
