

class card {
  int health;
  int startHealth;
  int speed;
  int damage;
  PImage image;
  int cooldown;
  int index;
  String move;

  card(String imageFileName, int health, int damage, int speed) {
    image = loadImage(imageFileName);
    this.health = health;
    this.damage = damage;
    this.speed = speed;
    this.cooldown = 0;
  }
  card(String info) {
    String[] allInfo = info.split(", ");
    image = loadImage(allInfo[0]);
    health = Integer.parseInt(allInfo[1]);
    speed = Integer.parseInt(allInfo[2]);
    damage = Integer.parseInt(allInfo[3]);
  }

  void takeDamage(card car) {
    this.health -= car.damage;
  }

  void updateIndex() {
    // get the index from the array of cards the user has, max of 3
  }

  boolean atMax() {
    return speed == cooldown;
  }

  void tick() {
    // add one to the cooldown, once it reaches its max, wait till next frame, then toggle the stop before cards are ticked.
    // 
    if (canTick) {
      this.cooldown += 1;
    }
    if (this.atMax()) {
      toggleFight = true;
    }
  }
}
