// class for last scene after you win
class Win {
  
  int correctXi = 497;
  int correctYi 268;
  
  Win() {}
  
  PImage background;
  void display() {
    background = loadImage("data/box.png"); //change, not right
    image(background, 0, 0);
  }
  
  boolean mousePressedAnimal() { // yea we know this isn't super legit
  return false;
  }
  
  boolean mousePressedCorrect() {
    return ((correctXi < mouseX) && (mouseX < (correctXi + 200)))
      && ((correctYi < mouseY) && (mouseY < (correctYi + 200)));
  }
  
}
