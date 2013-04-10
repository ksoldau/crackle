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

//coordinates for map button
int MAPXi = 780;
int MAPXf = 960;
int MAPYi = 550;
int MAPYf = 690;

//coordinates for help button
int HELPXi = 680;
int HELPXf = 760;
int HELPYi = 550;
int HELPYf = 690;

//coordinates for left arrow button
int LEFTXi = 24;
int LEFTXf = 127;
int LEFTYi = 226;
int LEFTYf = 301;

//coordinates for right arrow button
int RIGHTXi = 834;
int RIGHTXf = 942;
int RIGHTYi = 226;
int RIGHTYf = 301;

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
  if (WELCOME_SCREEN) {
    if (cursor_over(STARTXi, STARTXf, STARTYi, STARTYf)) {
      cursor(HAND); 
    }
    else { cursor(ARROW); }
  }
  else if 
  (cursor_over_map() || 
  cursor_over_help() || 
  cursor_over_left() ||
  cursor_over_right()) 
  {
    cursor(HAND);
  }

  // changes cursor to be the general arrow to show there's nothing to click there
  else { cursor(ARROW); }
}

void doIntro() {
  intro.display();
  displayArrows();
  displayBar();

}
void doFrosty() {
  Frosty1 frosty1 = new Frosty1(4, false);
  frosty1.display();
  displayArrows();  
  displayBar();

}
void doAsia() {
  Asia1 asia1 = new Asia1(4, false);
  asia1.display();
  displayArrows();
}

// display the bar at bottom of screen
void displayBar() {
  PImage nav = loadImage("data/nav.png");
  image(nav, 0, 0);
}

// display arrows to go between habitats
void displayArrows() {
  PImage arrows = loadImage("data/arrows.png"); // note: does not exist yet;
  image(arrows, 0, 0);
}

// if mouse is pressed, do this stuff 
void mousePressed() {
  if (WELCOME_SCREEN) { // decides what to do with mouse if pressed when on welcoem screen
    mousePressedWelcomeScreen(); 
  }
  if (cursor_over_map()) {
  }
  if (cursor_over_left()) {
    doFrosty();
  }
  if (cursor_over_right()) {
    doAsia();
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

// determines if cursor in a certain box
boolean cursor_over(int xmin, int xmax, int ymin, int ymax) {
  return xmin < mouseX && mouseX < xmax && ymin < mouseY && mouseY < ymax;
}

// determines if cursor over the start button 
// assume: on welcome page
boolean cursor_over_start() {
  return cursor_over(STARTXi, STARTXf, STARTYi, STARTYf);
}
// determines if cursor over map 
boolean cursor_over_map() {
  return cursor_over(MAPXi, MAPXf, MAPYi, MAPYf);
}
boolean cursor_over_help() {
  return cursor_over(HELPXi, HELPXf, HELPYi, HELPYf);
}
boolean cursor_over_left() {
  return cursor_over(LEFTXi, LEFTXf, LEFTYi, LEFTYf);
}
boolean cursor_over_right() {
  return cursor_over(RIGHTXi, RIGHTXf, RIGHTYi, RIGHTYf);
}


  
  



