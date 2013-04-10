PImage img;
Intro intro;
Jungle1 jungle;

int WIDTH = 960;
int HEIGHT = 650;
int HABITAT_HEIGHT = 540;

boolean WELCOME_SCREEN = true; // is it on the welcome screen

//coordinates for start button on welcome page
int STARTXi = 400;
int STARTXf = 560;
int STARTYi = 500;
int STARTYf = 550;

//coordinates for map
int MAPXi = 780;
int MAPXf = 960;
int MAPYi = 550;
int MAPYf = 690;

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
  if (WELCOME_SCREEN && cursor_over(STARTXi, STARTXf, STARTYi, STARTYf)) {
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
  if (cursor_over(MAPXi, MAPXf, MAPYi, MAPYf)) {
  }
}

// assume: on welcome screen
// determines what actions to perform if mouse pressed 
void mousePressedWelcomeScreen() {
  if (cursor_over(STARTXi, STARTXf, STARTYi, STARTYf) && mousePressed == true) {
  doIntro();
  WELCOME_SCREEN = false;
  }
}

// determines if cursor in a certain box
boolean cursor_over(int xmin, int xmax, int ymin, int ymax) {
  return xmin < mouseX && mouseX < xmax && ymin < mouseY && mouseY < ymax;
}


  
  



