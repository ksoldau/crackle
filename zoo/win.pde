// class for last scene after you win
class Win {

  int correct_x;
  int correct_y;

  PImage background;
  PImage img;
  PImage win_image; 

  Win() {
    win_image = loadImage("data/youwin.png");
    setCorrectLocation();
  }
  
  //sets where correct location is on guess creen
  void setCorrectLocation() {
    if (USER == "GORILLA_A") {
      correct_x = 497;
      correct_y = 268;
    }
    else if (USER == "GORILLA_B") {}
    else if (USER == "COBRA_A") {}
    else if (USER == "COBRA_B") {}
    else if (USER == "POLAR_A") {}
    else if (USER == "POLAR_B") {}
  }
  
  //displays the guessing screen
  void doGuess() {
    ON_GUESS = true;
    image(GUESS_SCENE_BG, 0, 0);
  }

  //displays the winning screen
  void doWin() {
    image(win_image, 0, 0);
  }

  //determines if a mouse pressed on animal in the habitat
  boolean mousePressedAnimal() { // yea we know this isn't super legit
    return false;
  }

  //determiens if cursor over the correct answer
  boolean cursorOverCorrect() {
      return cursorOver(correct_x, correct_x + 200, correct_y, correct_y + 200);
  }

  //decides what to do if mouse pressed in the habitat
  void mousePressedOnGuess() {
    if (cursorOverCorrect()) {
      ON_GUESS = false;
      ON_WIN = true;
      //doWin();
    }
  }
}

