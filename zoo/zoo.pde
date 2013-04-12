import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import gifAnimation.*;

PImage img;

// declaring variables outside of setup so they can be used anywhere
// a la "public" in standard java

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

Habitat[] LIST_OF_HABITATS = new Habitat[9];

// Navigation and arrows
Nav nav;
Arrows arrows;
Map map;

// Audio Setup
Minim minim;
AudioSample baron;

//--------------------------------------

//Static variables
int WIDTH = 960;
int HEIGHT = 650;
int HABITAT_HEIGHT = 540;

//Dynamic variables
boolean WELCOME_SCREEN = true; // is it on the welcome screen
boolean ON_MAP = false; // is true if on the map

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
int scene_number = 0;

//--------------------------------------
String USER; // which animal the user is can be 
// "gorillaA", "gorillaB", "cobraA", "cobraB", 
// "polarbearA", or "polarbearB"

Gif animal_animation;
//Talking animals gifs
/*Gif GIF_CAMEL_TALKING; //Africa1
Gif GIF_GIRAFFE_TALKING; //Africa2
Gif GIF_LION_TALKING; //Africa3
Gif GIF_TIGER_TALKING; //Asia1
Gif GIF_PANDA_TALKING; //Asia2
Gif GIF_PENGUIN_TALKING; //Frosty1
Gif GIF_SEAL_TALKING; //Frosty2
Gif GIF_ELEPHANT_TALKING; //Jungle1
Gif GIF_SLOTH_TALKING; //Jungle2
*/

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
  
  LIST_OF_HABITATS[0] = africa1;
  LIST_OF_HABITATS[1] = africa2;
  LIST_OF_HABITATS[2] = africa3;
  LIST_OF_HABITATS[3] = asia1;
  LIST_OF_HABITATS[4] = asia2;
  LIST_OF_HABITATS[5] = frosty1;
  LIST_OF_HABITATS[6] = frosty2;
  LIST_OF_HABITATS[7] = jungle1;
  LIST_OF_HABITATS[8] = jungle2;

  
  nav = new Nav();
  arrows = new Arrows();
  map = new Map();

  // chooses which animal habitat to start on
  scene_number = 0;
  
  // randomly chooses which animal and which 
  // iteration of that animal the user will play
  chooseUserAnimal();
  
  println(LIST_OF_HABITATS[0]);

  // Setting up sound engine
  minim = new Minim(this);
  baron = minim.loadSample( "baron.mp3", // filename
                                512      // buffer size
  );
  
  
   animal_animation = new Gif(this, "data/calvin_camel_motion.gif");
  // initializing GIFs for talking animals
  //GIF_CAMEL_TALKING = new Gif(this, "data/calvin_talk.gif");
  /* GIF_GIRAFFE_TALKING = new Gif(this, xxxx); //Africa2
  Gif GIF_LION_TALKING = new Gif(this, xxxx); //Africa3
  Gif GIF_TIGER_TALKING = new Gif(this, xxxx); //Asia1
  Gif GIF_PANDA_TALKING = new Gif(this, xxxx); //Asia2
  Gif GIF_PENGUIN_TALKING = new Gif(this, xxxx); //Frosty1
  Gif GIF_SEAL_TALKING = new Gif(this, xxxx); //Frosty2
  Gif GIF_ELEPHANT_TALKING = new Gif(this, xxxx); //Jungle1
  Gif GIF_SLOTH_TALKING = new Gif(this, xxxx); //Jungle2
  */
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
  image(animal_animation, 10, 10);
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
  cursor_over_right() ||
  (ON_MAP && (
  cursor_over_africa1() ||
  cursor_over_africa2() ||
  cursor_over_africa3() ||
  cursor_over_asia1() ||
  cursor_over_asia2() ||
  cursor_over_frosty1() ||
  cursor_over_frosty2() ||
  cursor_over_jungle1() ||
  cursor_over_jungle2() ))) 
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

// map screen
void doMap() {
  map.display();
  arrows.display(); // because currently we cant get out of the map
}

//---------------------
// all of the do methods display the habitat for each 
// specified habitat

void doAfrica1() {
  africa1.display();
  africa1.displayAnimal();
  arrows.display();
}
void doAfrica2() {
  africa2.display();
  africa2.displayAnimal();
  arrows.display();
}

void doAfrica3() {
  africa3.display();
  africa3.displayAnimal();
  arrows.display();
}

void doAsia1() {
  asia1.display();
  asia1.displayAnimal();
  arrows.display();
}

void doAsia2() {
  asia2.display();
  asia2.displayAnimal();
  arrows.display();
}

void doFrosty1() {
  frosty1.display();
  frosty1.displayAnimal();
  arrows.display();
}

void doFrosty2() {
  frosty2.display();
  frosty2.displayAnimal();
  arrows.display();
}

void doJungle1() {
  jungle1.display();
  jungle1.displayAnimal();
  arrows.display();
}

void doJungle2() {
  jungle2.display();
  jungle2.displayAnimal();
  arrows.display();
}

//---------------------------------------------
// what to do when mouse is pressed


// if mouse is pressed, do this stuff 
void mousePressed() {
  if (WELCOME_SCREEN) { // decides what to do with mouse if pressed when on welcoem screen
    mousePressedWelcomeScreen(); 
  }
  if (ON_MAP) {
    mousePressedOnMap();
  }
  else if (cursor_over_map()) {
    doMap();
    ON_MAP = true;
  }
  else if (cursor_over_left()) {
    doScene(updateSceneNumber("left"));
  }
  else if (cursor_over_right()) {
    doScene(updateSceneNumber("right"));
  }
  // if the mouse was pressed in current habitat
  else if (!ON_MAP && cursorOverHabitat()) { 
    africa1.asd();
  }
}

//assume: not on welcome screen, not on map
// determines if mouse pressed in a habitat
boolean cursorOverHabitat() {
  return cursor_over(0, 960, 0, 540);
}
  


// assume: on welcome screen
// determines what actions to perform if mouse pressed 
void mousePressedWelcomeScreen() {
  if (cursor_over_start() && mousePressed == true) {
  doIntro();
  WELCOME_SCREEN = false;
  }
}

// assume: on map
// determines what actiosn to perform if on map
void mousePressedOnMap() {
  if (cursor_over_africa1()) {
    doAfrica1();
  }
  else if (cursor_over_africa2()) {
    doAfrica2();
  }
  else if (cursor_over_africa2()) {
    doAfrica2();
  }
  else if (cursor_over_africa3()) {
    doAfrica3();
  }
  else if (cursor_over_asia1()) {
    doAsia1();
  }
  else if (cursor_over_asia2()) {
    doAsia2();
  }
  else if (cursor_over_frosty1()) {
    doFrosty1();
  }
  else if (cursor_over_frosty2()) {
    doFrosty2();
  }
  else if (cursor_over_jungle1()) {
    doJungle1();
  }
  else if (cursor_over_jungle2()) {
    doJungle2();
  }
  ON_MAP = false;
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

// assuming in the map
boolean cursor_over_africa1() {
  return cursor_over(473, 562, 96, 160);
}
boolean cursor_over_africa2() {
  return cursor_over(564, 654, 171, 237);
}
boolean cursor_over_africa3() {
  return cursor_over(581, 670 ,270, 336);
}
boolean cursor_over_asia1() {
  return cursor_over(527,616,370, 435);
}
boolean cursor_over_asia2() {
  return cursor_over(423,513, 409,474);
}
boolean cursor_over_frosty1() {
  return cursor_over(318,407,369, 433);
}
boolean cursor_over_frosty2() {
  return cursor_over(267, 356, 272, 336);
}
boolean cursor_over_jungle1() {
  return cursor_over(283, 372, 171, 235);
}
boolean cursor_over_jungle2() {
  return cursor_over(373, 461, 95, 159);
}



  
  



