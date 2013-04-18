// class for last scene after you win
class Win {
  
  Win() {}
  
  PImage background;
  void display() {
    background = loadImage("data/box.png"); //change, not right
    image(background, 0, 0);
  }
  
  boolean mousePressedAnimal() { // yea we know this isn't super legit
  return false;
  }
  
}
