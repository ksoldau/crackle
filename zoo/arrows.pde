//arrows
// and some items that you gather
class Arrows {
  PImage background;

  Arrows() {
    this.background = loadImage("data/arrows.png");
  }

  public void display() {
    image(background, 0, 0);
    if (USER == "GORILLA_B" && HAS_ITEM) {
      displayCherryBlossom();
    }
  }
  
  //assume GORILLA_B and that user has it
  void displayCherryBlossom() {
    image(CHERRY_BLOSSOM_CORNER, 810, 0);
  }
  
  
}


