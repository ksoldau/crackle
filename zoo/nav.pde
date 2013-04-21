// Nav
class Nav {

  PImage navbar;

  boolean clue1; //GA fur
  boolean clue2; 
  boolean clue3;
  boolean clue4;

  int clue1xi = 57;
  int clue2xi = 211;
  int clue3xi = 368;
  int clue4xi = 524;
  int clueyi = 570;

  Nav() {
    this.navbar = loadImage("data/nav.png");
  }

  // display the scene
  void display() {
    image(navbar, 0, 0);
    if (clue1) {
      displayClue1();
    }
    if (clue2) {
      displayClue2();
    }
    if (clue3) {
      displayClue3();
    }
    if (clue4) {
      displayClue4();
    }
  }

  void displayClue1() {
    if (USER == "GORILLA_A") {
      image(GA_CLUE1, clue1xi, clueyi);
    }
    else {
      image(TEST_CLUE1, clue1xi, clueyi);
    }
  }

  void displayClue2() {
    if (USER == "GORILLA_A") {
      image(GA_CLUE2, clue2xi, clueyi);
    }
    else {
      image(TEST_CLUE2, clue2xi, clueyi);
    }
  }


  void displayClue3() {
    if (USER == "GORILLA_A") {
      image(GA_CLUE3, clue3xi, clueyi);
    }
    else {
      image(TEST_CLUE3, clue3xi, clueyi);
    }
  }

  void displayClue4() {
    if (USER == "GORILLA_A") {
      image(GA_CLUE4, clue4xi, clueyi);
    }
    else {
      image(TEST_CLUE4, clue4xi, clueyi);
    }
  }
}

