


class npc {
  String[] lines;
  PVector mapNumber = new PVector();
  PVector location = new PVector();
  public int spriteIndex;
  int number;
  PImage image;
  int fightNumber;
  npc(PVector mapNumber, PVector location, String[] liness, int number) {
    this.lines = liness;
    this.mapNumber = mapNumber;
    this.location = location;
    this.number = number;
    spriteIndex = 0;
    this.image = loadImage("NPC/0.png");
  }
  npc(PVector mapNumber, PVector location, String[] liness) {
    this.lines = liness;
    this.mapNumber = mapNumber;
    this.location = location;
    spriteIndex = 0;
    this.image = loadImage("NPC/0.png");
  }
  npc(PVector mapNumber, PVector location) {
    this.location = location;
    this.mapNumber = mapNumber;
    spriteIndex = 0;
    this.image = loadImage("NPC/0.png");
  }
  npc(int numb) {
    this.number = numb;
    spriteIndex = 0;
    this.image = loadImage("NPC/0.png");
  }
  npc() {
    spriteIndex = 0;
    this.image = loadImage("NPC/0.png");
  }

  String getText() {
    StringBuilder str = new StringBuilder();
    for (String a : lines) {
      str.append(a).append("-");
    }
    if (str.length() > 0) {
      String st = str.substring(0, str.length() - 1);
      return st;
    }
    return "";
  }

  int getSpriteID() { // load each sprite from npc, check if equal, if they are, get the index. if they aren't, return 0
    try {
      int index = 0;
      for (; true; index++) {
        PImage tempImage = loadImage("NPC/"+index+".png");
        if (picturesAlike(tempImage, this.image)) {
          return index;
        }
      }
    }
    catch(Exception e) {
      return 0;
    }
  }

  void setLocation(PVector mapNumber, PVector location) {
    this.mapNumber = mapNumber;
    this.location = location;
  }

  void setLines(String[] line) {
    this.lines = line;
  }

  void setImage(PImage image) {
    this.image = image;
  }

  void setSprite(int si) {
    spriteIndex = si;
  }

  void setFight(int numb) {
    db.setFight(this.number, numb);
  }

  void show() {
    try {
      image(this.image, location.x*40, location.y*40);
    }
    catch(Exception e) {
      println(this.number);
      exit();
    }
  }
}

boolean picturesAlike(PImage a, PImage b) {
  a.loadPixels();
  b.loadPixels();
  for (int i = 0; i < a.pixels.length; i++) {
    if (a.pixels[i] != b.pixels[i]) {
      return false;
    }
  }
  return true;
}
