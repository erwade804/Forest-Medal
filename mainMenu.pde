void drawMainMenu() {
  image(startScreen, 0, 0);
  if (options == true) {
    drawOptionsMenu();
  }
}

void drawOptionsMenu() {
  image(optionsScreen, width/2-60, height/2-30);
}
