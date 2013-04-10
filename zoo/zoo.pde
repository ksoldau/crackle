PImage img;
Intro intro;
Jungle1 jungle;

int WIDTH = 960;
int HEIGHT = 650;
boolean WELCOME_SCREEN = true;
// int HABITAT_HEIGHT = 540; 

//setup runs once
void setup() {
  background(255);
  size(WIDTH,HEIGHT);
  
  // load image that says "Zoo guess who click here to start"
  img = loadImage("data/welcome.png");// obvs a wrong link
  image(img, 0, 0);
  
  intro = new Intro();
}

// draw is called directly after setup
// called automatically, don't mess with it
void draw() {
  // changes the cursor to show it's over the start button
  if (WELCOME_SCREEN && cursor_over_start()) {
      cursor(HAND);
  }
  // changes cursor to be the general arrow to show there's nothing to click there
  else { cursor(ARROW); }
}

void doIntro() {
  intro.display();
}

// if mouse is pressed, do this stuff 
void mousePressed() {
  if (WELCOME_SCREEN) { // decides what to do with mouse if pressed when on welcoem screen
    mousePressedWelcomeScreen(); 
  }
}

// assume: on welcome screen
// determines what actions to perform if mouse pressed 
void mousePressedWelcomeScreen() {
  if (cursor_over_start() && mousePressed == true) {
  doIntro();
  WELCOME_SCREEN = false;
  }
}

// determines if on the welcome screen with the cursor over the start button
boolean cursor_over_start() {
  return 400 < mouseX && mouseX < 560 && 500 < mouseY && mouseY < 550;
}

  
  



