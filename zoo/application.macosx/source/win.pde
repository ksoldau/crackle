// class for last scene after you win
class Win {

  int correctXi = 497;
  int correctYi =268;

  PImage background;
  PImage img;

  Win() {
  }

  void display() {
    background = loadImage("data/box.png"); //change, not right
    image(background, 0, 0);
  }

  void doGuess() {
    ON_GUESS = true;
    image(GUESS_SCENE_BG, 0, 0);
  }

  void doWin() {
    img = loadImage("data/youwin.png");
    image(img, 0, 0);
  }

  boolean mousePressedAnimal() { // yea we know this isn't super legit
    return false;
  }

  boolean cursorOverCorrect() {
    return ((correctXi < mouseX) && (mouseX < (correctXi + 200)))
      && ((correctYi < mouseY) && (mouseY < (correctYi + 200)));
  }

  void mousePressedOnGuess() {
    if (cursorOverCorrect()) {
      doWin();
    }
  }
}

