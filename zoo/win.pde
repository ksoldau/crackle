// class for last scene after you win
class Win {

  int correctXi = 497;
  int correctYi =268;

  PImage background;
  PImage img;

  Win() {
  }

  //** might not do anything now?
  void display() {
    background = loadImage("data/box.png"); //change, not right
    image(background, 0, 0);
  }

  //displays the guessing screen
  void doGuess() {
    ON_GUESS = true;
    image(GUESS_SCENE_BG, 0, 0);
  }

  //displays the winning screen
  void doWin() {
    img = loadImage("data/youwin.png");
    image(img, 0, 0);
  }

  //determines if a mouse pressed on animal in the habitat
  boolean mousePressedAnimal() { // yea we know this isn't super legit
    return false;
  }

  //determiens if cursor over the correct answer
  boolean cursorOverCorrect() {
    return ((correctXi < mouseX) && (mouseX < (correctXi + 200)))
      && ((correctYi < mouseY) && (mouseY < (correctYi + 200)));
  }

  //decides what to do if mouse pressed in the habitat
  void mousePressedOnGuess() {
    if (cursorOverCorrect()) {
      ON_GUESS = false;
      doWin();
    }
  }
}

