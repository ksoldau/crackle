// class for last scene after you win
class Win {

  int correct_x;
  int guess_y = 268;
  
  int guess1_x = 32; 
  int guess2_x = 264;
  int guess3_x = 498;
  int guess4_x = 730;

  PImage background;
  PImage img;
  PImage guess_screen;
  PImage win_image; 

  Win() {
    win_image = loadImage("data/youwin.png");
    setCorrectLocation();
    setGuessScreen();
  }

  //sets where correct location is on guess creen
  void setCorrectLocation() {
    if (USER == "GORILLA_A") {
      correct_x = guess3_x;
    }
    else if (USER == "GORILLA_B") {
      correct_x = guess1_x;
    }
    else if (USER == "COBRA_A") {
      correct_x = guess2_x;
    }
    else if (USER == "COBRA_B") {
      correct_x = guess3_x;
    }
    else if (USER == "POLAR_A") {
      correct_x = guess4_x;
    }
    else if (USER == "POLAR_B") {
      correct_x = guess3_x;
    }
  }
  
  //set correct guess screen based on user animal
  void setGuessScreen() {
    if (USER == "GORILLA_A") {
      guess_screen = loadImage("data/guess/guess_gorilla_a.png");
    }
    else if (USER == "GORILLA_B") {
      guess_screen = loadImage("data/guess/guess_gorilla_b.png");
    }
    else if (USER == "COBRA_A") {
      guess_screen = loadImage("data/guess/guess_cobra_a.png");
    }
    else if (USER == "COBRA_B") {
    guess_screen = loadImage("data/guess/guess_cobra_b.png");
    }
    else if (USER == "POLAR_A") {
      guess_screen = loadImage("data/guess/guess_polar_a.png");
    }
    else if (USER == "POLAR_B") {
      guess_screen = loadImage("data/guess/guess_polar_b.png");
    }
  }

  //displays the guessing screen
  void doGuess() {
    ON_GUESS = true;
    image(guess_screen, 0, 0);
  }

  //displays the winning screen
  void doWin() {
    image(win_image, 0, 0);
  }

  //determines if a mouse pressed on animal in the habitat
  boolean mousePressedAnimal() { // yea we know this isn't super legit
    return false;
  }
  
  boolean cursorOverGuessOption() {
    return cursorOver(guess1_x, guess1_x + 100, guess_y, guess_y + 200) 
    || cursorOver(guess2_x, guess2_x + 100, guess_y, guess_y + 200) 
    || cursorOver(guess3_x, guess3_x + 100, guess_y, guess_y + 200) 
    || cursorOver(guess4_x, guess4_x + 100, guess_y, guess_y + 200); 
  }

  //determiens if cursor over the correct answer
  boolean cursorOverCorrect() {
    return cursorOver(correct_x, correct_x + 200, guess_y, guess_y + 200);
  }

  //decides what to do if mouse pressed in the habitat
  void mousePressedOnGuess() {
    if (cursorOverCorrect()) {
      ON_GUESS = false;
      ON_WIN = true;
      //doWin();
    }
    else if (cursorOverGuessOption()) { //and not correct option
    TRY_AGAIN_AUDIO.trigger();
    }
  }
}


