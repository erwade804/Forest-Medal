import samuelal.squelized.*;
PVector cameraMain;
PVector playerPosition, playerCamera;
int movementLeft = 0;
boolean[] keys;

PImage playerImage;
PImage archer, mage, sword;


// create mode
int selectionScroll;
color selectedColor;
boolean selectionHighlighted;
String selectedType = "floor";
boolean mapHighlighted;
ArrayList<String> newStringArray;
String newString;
String alphabet;

// mainMenu mode
PImage startScreen, optionsScreen;
boolean options;

// npc information
PImage textBox;
PFont font;
ArrayList<npc> npcs;
int lineNumber;
npc currentNPC;
npc startNPC;
npc created;

// the 9 local maps loaded in
Map[] mainMap;

// the game mode we're in, (main menu, open world, crate, ect.)
String mode;


// fight mode information
ArrayList<card> playerCards;
ArrayList<card> enemyCards;
boolean toggleFight;
boolean canTick;
PImage backgroundBattle, arrowImage;
int selectionX, selectionY;
int selectEnemy;
int wait;
String moveType;


//database workings
MySQL db;

void setup() {
  size(480, 480);
  // connect to the data base
  db = new MySQL();
  db.setFight(2, 0);
  alphabet = "abcdefghijklmnopqrstuvwxyz.,!()?[]+=_{}<>@#$%^&*ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~ ";
  newStringArray = new ArrayList<String>();
  newString = "";
  moveType = "";
  wait = 0;
  while (startNPC == null) {
    startNPC = db.getNPC(-1);
  }
  currentNPC = startNPC;
  created = new npc();
  toggleFight = true;
  selectEnemy = -1;
  canTick = true;
  playerCards = new ArrayList<card>(3);
  playerCards.add(new card("cardImages/archer.png", 100, 10, 50));
  playerCards.add(new card("cardImages/manaMage.png", 100, 10, 50));
  playerCards.add(new card("cardImages/archer.png", 100, 10, 50));
  enemyCards = new ArrayList<card>(3);
  textAlign(CENTER);
  font = createFont("Arial", 20, true);
  npcs = new ArrayList<npc>();
  lineNumber = 0;
  textFont(font, 20);
  keys = new boolean[13];
  frameRate(30);
  startScreen = loadImage("sprites/titleMenu.png");
  optionsScreen = loadImage("sprites/optionsMenu.png");
  textBox = loadImage("sprites/textBox.png");
  playerImage = loadImage("sprites/player.png");
  backgroundBattle = loadImage("sprites/battleground.png");
  arrowImage = loadImage("sprites/arrow.png");
  playerPosition = new PVector(1005, 1005);
  mapHighlighted = false;
  selectionScroll = 0;
  mainMap = new Map[9];
  cameraMain = new PVector(0, 0);
  if (width == 480) {
    mode = "create";
  } else {
    mode = "mainMenu";
  }
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
  loadNPCs();
}



void draw() {
  drawTheMode();
  //saveFrame("number####");
}
