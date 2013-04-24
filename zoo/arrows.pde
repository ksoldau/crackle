//arrows
// and some items that you gather
class Arrows {
  PImage background;

  Arrows() {
    this.background = loadImage("data/arrows.png");
  }

  //displays the arrows and any necessary elements
  public void display() {
    image(background, 0, 0);
    if (USER == "GORILLA_A" && HAS_ITEM) {
      displayToken();
    }
    if (USER == "GORILLA_B" && HAS_ITEM) {
      displayCherryBlossom();
    }
    if (USER == "POLAR_A" && HAS_ITEM) {
      if (FROSTY1_STATE >= 3) {
        displayBamboo();
      }
      else {
        displayFish();
      }
    }
  }

  //assume GORILLA_B and that user HAS_ITEM
  void displayCherryBlossom() {
    image(CHERRY_BLOSSOM_CORNER, 810, 0);
  }

  //assume POLAR_A and that user has it
  void displayFish() {
    image(FISH_CORNER, 810, 0);
  }

  //assume POLAR_A and that user HAS_ITEM
  void displayBamboo() {
    image(BAMBOO_CORNER, 810, 0);
  }

  //assume GORILLA_A and HAS_ITEM
  void displayToken() {
    displayCherryBlossom(); ///
  }
}

