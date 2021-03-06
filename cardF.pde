

void drawCards() {
  try {
    for (int i = 0; i < 3; i++) {
      if (playerCards.get(i).health > 0) {
        PImage cardsImage = playerCards.get(i).image;
        image(cardsImage, 80, 40 + 80* i);
      }
    }
  }
  catch(Exception e) {
  }
  try {
    for (int i = 0; i < 3; i++) {
      if (enemyCards.get(i).health > 0) {
        PImage cardsImage = enemyCards.get(i).image;
        pushMatrix();
        scale(-1, 1);
        image(cardsImage, -320, 40 + 80* i);
        popMatrix();
      }
    }
  }
  catch(Exception e) {
  }
}


void drawArrow() {
  if (selectionX == 0) {
    scale(-1, 1);
  }
  int x = -204; // these values are specific so do not change them. They are debugged for placement
  int y = 250;
  if (selectionX == 1) {
    println("x = 1");
    x = 196;
  } else println("x = 0");
  if (selectionY == 1) {
    println("y = 1");
    y = 308;
  } else println("y = 0");
  image(arrowImage, x, y); // draw the arrow pointing in the right direction towards the corret icon
}

void loadBattle(int num) {
  // player cards are always constant, just to make things simple
  String[] lines = loadStrings("battles/"+num+".txt");
  String line1 = lines[0];
  String line2 = lines[1];
  String line3 = lines[2];
  enemyCards = new ArrayList<card>(3);
  enemyCards.add(new card(line1));
  enemyCards.add(new card(line2));
  enemyCards.add(new card(line3));
  println("loaded battle");
}

String getMoveType() {
  if (selectionX == 0 && selectionY == 0) {
    return "attack 1";
  } else if (selectionX == 1 && selectionY == 0) {
    return "attack 2";
  } else if (selectionX == 0 && selectionY == 1) {
    return "attack 3";
  }
  return "block";
}

void doMove() {
  
}
