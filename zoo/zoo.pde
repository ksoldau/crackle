PImage img;

// declaring variables outside of setup so they can be used anywhere
// a la "public" in standard java
//
// Background images
Intro intro;

Africa1 africa1;
Africa2 africa2;
Africa3 africa3;

Asia1 asia1;
Asia2 asia2;

Frosty1 frosty1;
Frosty2 frosty2;

Jungle1 jungle1;
Jungle2 jungle2;

// Navigation and arrows
Nav nav;
Arrows arrows;

//--------------------------------------

// Static variables
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

//--------------------------------------
int scene_number;

//--------------------------------------
String USER; // which animal the user is can be 
// "gorillaA", "gorillaB", "cobraA", "cobraB", 
// "polarbearA", or "polarbearB"

//setup runs once
void setup() {
  background(255);
  size(WIDTH, HEIGHT);
  
  // load image that says "Zoo guess who click here to start"
  img = loadImage("data/welcome.png");// obvs a wrong link
  image(img, 0, 0);

  
  // making all the background objects
  intro = new Intro();
  
  africa1 = new Africa1(4, false);
  africa2 = new Africa2(4, false);
  africa3 = new Africa3(4, false);
  
  asia1 = new Asia1(4, false);
  asia2 = new Asia2(4, false);
 
  frosty1 = new Frosty1(4, false);
  frosty2 = new Frosty2(4, false);
  
  jungle1 = new Jungle1(4, false);
  jungle2 = new Jungle2(4, false);
  
  nav = new Nav();
  arrows = new Arrows();
  
  // chooses which animal habitat to start on
  scene_number = 0;
  
  chooseUserAnimal();

}

//randomly chooses which animal the user is 
// and which group of 6 animal interacts with
void chooseUserAnimal() {
  float random_number = random(0, 6);
  if (random_number < 1) {
    USER = "gorillaA";
  }
  else if (random_number < 2) {
    USER = "gorillaB";
  }
  else if (random_number < 3){
    USER = "polarbearA";   
  }
  else if (random_number < 4){
    USER = "polarbearB";   
  }
  else if (random_number < 5){
    USER = "cobraA";   
  }
  else if (random_number < 6){
    USER = "cobraB";   
  }
  println(USER);
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

//---------------------------------------
// "do" functions 
// these call the display methods in the corresponding classes
// so we can view them in zoo.pde

//chooses what scene to do next based on int argument
void doScene(int i) {
  if (i == 0) {
    doAfrica1();
  }
  else if (i == 1) {
    doAfrica2();
  } 
  else if (i == 2) {
    doAfrica3();
  }
  else if (i == 3) {
    doAsia1();
  }
  else if (i == 4) {
    doAsia2();
  }
  else if (i == 5) {
    doFrosty1();
  }
  else if (i == 6) {
    doFrosty2();
  }
  else if (i == 7) {
    doJungle1();
  }
  else if (i == 8) {
    doJungle2();
  }
}
  
// intro of the box screen
void doIntro() {
  intro.display();
  arrows.display();
  nav.display();
}

void doAfrica1() {
  africa1.display();
  arrows.display();
}
void doAfrica2() {
  africa2.display();
  arrows.display();
}

void doAfrica3() {
  africa3.display();
  arrows.display();
}

void doAsia1() {
  asia1.display();
  arrows.display();
}

void doAsia2() {
  asia2.display();
  arrows.display();
}

void doFrosty1() {
  frosty1.display();
  arrows.display();
}

void doFrosty2() {
  frosty2.display();
  arrows.display();
}

void doJungle1() {
  jungle1.display();
  arrows.display();
}

void doJungle2() {
  jungle2.display();
  arrows.display();
}



//---------------------------------------------
// what to do when mouse is pressed


// if mouse is pressed, do this stuff 
void mousePressed() {
  if (WELCOME_SCREEN) { // decides what to do with mouse if pressed when on welcoem screen
    mousePressedWelcomeScreen(); 
  }
  if (cursor_over_map()) {
  }
  if (cursor_over_left()) {
    doScene(updateSceneNumber("left"));
  }
  if (cursor_over_right()) {
    doScene(updateSceneNumber("right"));

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

// to update the scene the user is on
// when they click on an arrow key as specified by query
int updateSceneNumber(String query) {
  if (query.equals("left") && scene_number == 0) {
    scene_number = 8;
  }
  else if (query.equals("right") && scene_number == 8) {
    scene_number = 0;
  }
  else if (query.equals("left")) {
    scene_number--;
  }
  else { // assume query == "right" 
    scene_number++;
  }
  return scene_number;
}


//---------------------------------------------
// determine if cursor is over a certain area 


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


  
  



