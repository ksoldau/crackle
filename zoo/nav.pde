// Nav
class Nav {
  
  PImage navbar;
  
  boolean clue1; //GA fur
  boolean clue2; 
  boolean clue3;
  boolean clue4;
  
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
  }
  
  void displayClue2() {
  }
  void displayClue3() {
  }
  void displayClue4() {
  }
}
