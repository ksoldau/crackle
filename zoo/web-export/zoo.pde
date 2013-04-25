import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import java.text.NumberFormat;
import processing.video.*;

import gifAnimation.*; //from http://www.extrapixel.ch/processing/gifAnimation/

//elements
PImage TRASH_IMAGE;
PImage ROCK_IMAGE;
PImage CHERRY_BLOSSOM;
PImage BAMBOO_IMAGE;
PImage FISH_IMAGE;
PImage VINES_IMAGE;
PImage VINES_CUT_IMAGE;
PImage SLOTH_TOKEN_IMAGE; 

//items user might collect
PImage CHERRY_BLOSSOM_CORNER;
PImage FISH_CORNER;
PImage BAMBOO_CORNER;
PImage SLOTH_TOKEN_CORNER;

//clues
PImage CLUE1;
PImage CLUE2;
PImage CLUE3;
PImage CLUE4;

//clue audio
AudioSample CLUE1_AUDIO;
AudioSample CLUE2_AUDIO;
AudioSample CLUE3_AUDIO;
AudioSample CLUE4_AUDIO;

//guess scene
PImage GUESS_SCENE_BG;

// declaring variables outside of so they can be used anywhere
// a la "public" in standard java
int ANIMAL_TALKING_START_TIME;
//
int CLUE_TALKING_START_TIME;

int OPENING_START_TIME;

int CURRENT_TIME;

PImage BACKGROUND_IMG;
Intro INTRO;
Win WIN;

// Habitat classes 
Africa1 AFRICA1;
Africa2 AFRICA2;
Africa3 AFRICA3;

Asia1 ASIA1;
Asia2 ASIA2;

Frosty1 FROSTY1;
Frosty2 FROSTY2;

Jungle1 JUNGLE1;
Jungle2 JUNGLE2;

//States for each Habitat class
int AFRICA1_STATE;
int AFRICA2_STATE;
int AFRICA3_STATE;

int ASIA1_STATE;
int ASIA2_STATE;

int FROSTY1_STATE;
int FROSTY2_STATE;

int JUNGLE1_STATE;
int JUNGLE2_STATE;


// list of Habitats
Habitat[] LIST_OF_HABITATS = new Habitat[9]; 



// Navigation,arrows, map, owl
Nav NAV;
Arrows ARROWS;
Map MAP;
Owl OWL;

// Audio Setup
// WE will have to initialize all the clips here. Just fyi cause memory leak and etc.
Minim minim;

AudioPlayer AFRICA_BG;
AudioPlayer FROSTY_BG;
AudioPlayer ASIA_BG;
AudioPlayer JUNGLE_BG;


//Dummy lines
AudioSample CAMEL_DUMMY;
AudioSample GIRAFFE_DUMMY;
AudioSample LION_DUMMY;
AudioSample TIGER_DUMMY;
AudioSample PANDA_DUMMY;
AudioSample PENGUIN_DUMMY;
AudioSample SEAL_DUMMY;
AudioSample ELEPHANT_DUMMY;
AudioSample SLOTH_DUMMY;

//Audio for just GORILLA_A
AudioSample GA_CAMEL1;
AudioSample GA_CAMEL2;
AudioSample GA_LION1;
AudioSample GA_LION2;
AudioSample GA_LION3;
AudioSample GA_PANDA1;
AudioSample GA_PANDA2;
AudioSample GA_SEAL1;
AudioSample GA_ELEPHANT1;
AudioSample GA_SLOTH1;
AudioSample GA_SLOTH2;

//Audio for just GORILLA_B
AudioSample GB_SEAL1;
AudioSample GB_CAMEL1;
AudioSample GB_PENGUIN1;
AudioSample GB_PENGUIN2;
AudioSample GB_GIRAFFE1;
AudioSample GB_TIGER1;
AudioSample GB_SLOTH1;

//Audio for just COBRA_A
AudioSample CA_PENGUIN1;
AudioSample CA_CAMEL1;
AudioSample CA_PANDA1;
AudioSample CA_PANDA2;
AudioSample CA_ELEPHANT1;
AudioSample CA_LION1;
AudioSample CA_TIGER1;

//Audio for just COBRA_B
AudioSample CB_GIRAFFE1;
AudioSample CB_LION1;
AudioSample CB_TIGER1;
AudioSample CB_SLOTH1;
AudioSample CB_SLOTH2;
AudioSample CB_PANDA1;
AudioSample CB_GIRAFFE2;
AudioSample CB_PANDA2;
AudioSample CB_SEAL1;

//Audio for just POLAR_A
AudioSample PA_ELEPHANT1;
AudioSample PA_CAMEL1;
AudioSample PA_PENGUIN1;
AudioSample PA_PENGUIN2;
AudioSample PA_PANDA1;
AudioSample PA_PANDA2;
AudioSample PA_SLOTH1;
AudioSample PA_SLOTH2;
AudioSample PA_GIRAFFE1;
AudioSample PA_GIRAFFE2;


//Audio for just POLAR_B
AudioSample PB_TIGER1;
AudioSample PB_GIRAFFE1;
AudioSample PB_ELEPHANT1;
AudioSample PB_SEAL1; 
AudioSample PB_SEAL2;
AudioSample PB_PENGUIN1;
AudioSample PB_PANDA1;





//Audio for Guess screen
AudioSample TRY_AGAIN_AUDIO;


//------------------------------------------------
//Static variables

//width and height of scenes and total height
int WIDTH;
int HEIGHT;
int HABITAT_HEIGHT;

//coordinates for start button on welcome page
int STARTXi;
int STARTXf;
int STARTYi;
int STARTYf;

//coordinates for map button
int MAPXi;
int MAPXf;
int MAPYi;
int MAPYf;

//coordinates for help button
int HELPXi;
int HELPXf;
int HELPYi;
int HELPYf;

//coordinates for left arrow button
int LEFTXi;
int LEFTXf;
int LEFTYi;
int LEFTYf;

//coordinates for right arrow button
int RIGHTXi;
int RIGHTXf;
int RIGHTYi;
int RIGHTYf;

//--------------------------------------------
//Dynamic variables 

// if a certain screen is up
boolean WELCOME_SCREEN; // is it on the welcome screen
boolean ON_INTRO; // is it on the intro screen
boolean ON_MAP; 
boolean ON_GUESS;
boolean ON_WIN;

boolean HAS_ITEM;

//current habitat number
int HABITAT_NUMBER;

//current help owl
int HELP;
//list of Helps
PImage[] LIST_HELP_IMAGES = new PImage[13];
//is it on help
boolean ON_OWL;
//initialize lines //test for now
AudioSample TEST_OWL;
AudioSample[] LIST_OWL_AUDIO = new AudioSample[13];

//time owl started talking
int OWL_TALKING_START_TIME;

//last habitat number
int LAST_HABITAT_NUMBER;

//is the current animal talking
boolean ANIMAL_TALKING;
boolean CLUE_TALKING;

//did user make animal snore
boolean Z;

//the opening sequence
Movie OPENING_MOVIE;

//------------------------------------------
//setting up who the user is
String USER; // which animal the user is can be 
// "GORILLA_A", "GORILLA_B", "COBRA_A", "COBRA_B", 
// "POLAR_A", or "POLAR_B"

//------------------------------------------
//Gifs of talking animals

PImage[] GIFS_CAMEL_TALKING;
PImage[] GIFS_GIRAFFE_TALKING;
PImage[] GIFS_TIGER_TALKING;
PImage[] GIFS_LION_TALKING;
PImage[] GIFS_PANDA_TALKING;
PImage[] GIFS_PENGUIN_TALKING;
PImage[] GIFS_SEAL_TALKING;
PImage[] GIFS_ELEPHANT_TALKING;
PImage[] GIFS_SLOTH_TALKING;

//Gifs and other information for effects
PImage[] GIFS_ZS;
int NUMZFRAMES;
int AUDIO_LENGTH;



////////////////////////////////////////////////////////////////////////////////
//           _               
//          | |              
//  ___  ___| |_ _   _ _ __  
// / __|/ _ \ __| | | | '_ \ 
// \__ \  __/ |_| |_| | |_) |
// |___/\___|\__|\__,_| .__/ 
//                    | |    
//                    |_|    
////////////////////////////////////////////////////////////////////////////////
void setup() {
  frameRate(12);
  background(255);
  
  WIDTH = 960;
HEIGHT = 650;
HABITAT_HEIGHT = 540;
  size(WIDTH, HEIGHT);
  
  
//width and height of scenes and total height

//coordinates for start button on welcome page
STARTXi = 400; //wrong
STARTXf = 560; //wrong
STARTYi = 500; //wrong
STARTYf = 550; //wrong

//coordinates for map button
MAPXi = 780;
 MAPXf = 960;
 MAPYi = 550;
 MAPYf = 690;

//coordinates for help button
 HELPXi = 680;
 HELPXf = 760;
 HELPYi = 550;
 HELPYf = 690;

//coordinates for left arrow button
 LEFTXi = 24;
 LEFTXf = 127;
 LEFTYi = 226;
 LEFTYf = 301;

//coordinates for right arrow button
 RIGHTXi = 834;
 RIGHTXf = 942;
 RIGHTYi = 226;
 RIGHTYf = 301;

//--------------------------------------------
//Dynamic variables 

// if a certain screen is up
 WELCOME_SCREEN = true; // is it on the welcome screen
 ON_INTRO = false; // is it on the intro screen
 ON_MAP = false; 
 ON_GUESS = false;
 ON_WIN = false;

 HAS_ITEM = false;

//is it on help
ON_OWL = false;

//last habitat number
LAST_HABITAT_NUMBER = 8;

//is the current animal talking
 ANIMAL_TALKING = false;
 CLUE_TALKING = false;

//did user make animal snore
 Z = false;
 
 NUMZFRAMES = 13;

  //elements for scenes
  TRASH_IMAGE= loadImage("data/elements/trash.png");
  ROCK_IMAGE = loadImage("data/elements/rock.png");
  CHERRY_BLOSSOM = loadImage("data/elements/cherryblossom.png");
  FISH_IMAGE = loadImage("data/elements/fish.png");
  BAMBOO_IMAGE = loadImage("data/elements/bamboo.png");
  VINES_IMAGE = loadImage("data/elements/vineswhole.png");  
  VINES_CUT_IMAGE = loadImage("data/elements/vinescut.png"); 
  SLOTH_TOKEN_IMAGE = loadImage("data/elements/slothtoken.png");

  CHERRY_BLOSSOM_CORNER = loadImage("data/elements/cherryblossomcorner.png");
  FISH_CORNER = loadImage("data/elements/fishcorner.png");
  BAMBOO_CORNER = loadImage("data/elements/bamboocorner.png");
  SLOTH_TOKEN_CORNER = loadImage("data/elements/slothtokencorner.png");


  // load image that says "Zoo guess who click here to start"
  BACKGROUND_IMG = loadImage("data/welcome.png");
  image(BACKGROUND_IMG, 0, 0);

  //helpowls
  LIST_HELP_IMAGES[0] = loadImage("data/oscar/help_calvin_288.png"); 
  LIST_HELP_IMAGES[1] =loadImage("data/oscar/help_gerry_288.png"); 
  LIST_HELP_IMAGES[2] =loadImage("data/oscar/help_leonard_288.png");
  LIST_HELP_IMAGES[3] =loadImage("data/oscar/help_tina_288.png");
  LIST_HELP_IMAGES[4] =loadImage("data/oscar/help_patty_288.png");
  LIST_HELP_IMAGES[5] =loadImage("data/oscar/help_peter_288.png");
  LIST_HELP_IMAGES[6] =loadImage("data/oscar/help_sam_288.png");
  LIST_HELP_IMAGES[7] =loadImage("data/oscar/help_eliza_288.png");
  LIST_HELP_IMAGES[8] =loadImage("data/oscar/help_stanley_288.png");



  // making all the background objects
  INTRO = new Intro();
  OPENING_MOVIE = new Movie(this, "opening.mov");

  // randomly chooses which animal and which 
  // iteration of that animal the user will play
  chooseUser();
  println("YOU ARE THIS USER" + USER);
  //USER = "GORILLA_A";

  //chooses correct habitat number to start on based on user animal
  setFirstHabitatNumber();
  //set the first help numner 
  setFirstHelp();

  //loading all animal classes
  //depends on which animal/iteration the user is 
  loadAnimalClasses();
  loadClueImages();

  //initialize states of habitats
  AFRICA1_STATE = 0;
  AFRICA2_STATE = 0;
  AFRICA3_STATE = 0;

  ASIA1_STATE = 0;
  ASIA2_STATE = 0;

  FROSTY1_STATE = 0;
  FROSTY2_STATE = 0;

  JUNGLE1_STATE = 0;
  JUNGLE2_STATE = 0;

  LIST_OF_HABITATS[0] = AFRICA1;
  LIST_OF_HABITATS[1] = AFRICA2;
  LIST_OF_HABITATS[2] = AFRICA3;
  LIST_OF_HABITATS[3] = ASIA1;
  LIST_OF_HABITATS[4] = ASIA2;
  LIST_OF_HABITATS[5] = FROSTY1;
  LIST_OF_HABITATS[6] = FROSTY2;
  LIST_OF_HABITATS[7] = JUNGLE1;
  LIST_OF_HABITATS[8] = JUNGLE2;



  //initialize the navigation bar class
  NAV = new Nav();

  //initialize the class for the arrows
  ARROWS = new Arrows();

  //initialize the class for the map
  MAP = new Map();

  //initialize the win class
  WIN = new Win();

  //initialize the Owl class
  OWL = new Owl();

  // Setting up sound engine
  minim = new Minim(this);

  //AFRICA_BG = minim.loadFile("africa_bg.mp3", 512);
  FROSTY_BG = minim.loadFile("frosty_bg.mp3", 512);
  ASIA_BG = minim.loadFile("asia_bg.mp3", 512);
  JUNGLE_BG = minim.loadFile("jungle_bg.mp3", 512);

  // initializing lists for GIFs for talking animals
  GIFS_CAMEL_TALKING = Gif.getPImages(this, "data/calvin_talk_288.gif");
  GIFS_GIRAFFE_TALKING = Gif.getPImages(this, "data/gerry_talk_288.gif");
  GIFS_TIGER_TALKING  = Gif.getPImages(this, "data/tina_talk_288.gif");
  GIFS_LION_TALKING = Gif.getPImages(this, "data/leonard_talk_288.gif");
  GIFS_PANDA_TALKING = Gif.getPImages(this, "data/patty_talk_288.gif");
  GIFS_PENGUIN_TALKING = Gif.getPImages(this, "data/peter_talk_288.gif");
  GIFS_SEAL_TALKING = Gif.getPImages(this, "data/sam_talk_288.gif");
  GIFS_ELEPHANT_TALKING = Gif.getPImages(this, "data/eliza_talk_288.gif");
  GIFS_SLOTH_TALKING = Gif.getPImages(this, "data/stanley_talk_288.gif");

  //initializing lists for GIfs of effects
  GIFS_ZS = Gif.getPImages(this, "data/z.gif");

  GUESS_SCENE_BG = loadImage("data/guesswho.png");

  initializeAudio();
  initializeHelpAudioAndImages();
  initializeClueAudio();
  TRY_AGAIN_AUDIO = minim.loadSample("try_again.mp3", 512);
}

//sets the first habitat the user sees to correct one
//based on USER
void setFirstHabitatNumber() {
  if (USER == "GORILLA_A") {
    HABITAT_NUMBER = 0;
  }
  else if (USER == "GORILLA_B") {
    HABITAT_NUMBER = 6;
  }
  else if (USER == "COBRA_A") {
    HABITAT_NUMBER = 5;
  }
  else if (USER == "COBRA_B") {
    HABITAT_NUMBER = 1;
  }
  else if (USER == "POLAR_A") {
    HABITAT_NUMBER = 7;
    LAST_HABITAT_NUMBER = 0;
  }
  else if (USER == "POLAR_B") {
    HABITAT_NUMBER = 3;
  }
}

//set first help number 
void setFirstHelp() {
  HELP = HABITAT_NUMBER;
}

//initialize the audio
void initializeAudio() {
  //Audio for just GORILLA_A
  if (USER == "GORILLA_A") {
    CAMEL_DUMMY = minim.loadSample("CAMEL_DUMMY.mp3", 512); 
    ELEPHANT_DUMMY = minim.loadSample("ELEPHANT_DUMMY.mp3", 512);
    PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
    SLOTH_DUMMY = minim.loadSample("SLOTH_DUMMY.mp3", 512);
    SEAL_DUMMY = minim.loadSample("SEAL_DUMMY.mp3", 512);
    LION_DUMMY = minim.loadSample("LION_DUMMY.mp3", 512);

    GA_CAMEL1 = minim.loadSample("GA_CAMEL1.mp3", 512); //***
    GA_ELEPHANT1 = minim.loadSample("GA_ELEPHANT1.mp3", 512); 
    GA_PANDA1 = minim.loadSample("GA_PANDA1.mp3", 512);
    GA_SLOTH1 = minim.loadSample("GA_SLOTH1.mp3", 512);
    GA_PANDA2 = minim.loadSample("GA_PANDA2.mp3", 512);
    GA_SEAL1 = minim.loadSample("GA_SEAL1.mp3", 512);
    GA_CAMEL2 = minim.loadSample("GA_CAMEL2.mp3", 512);
    GA_LION1 = minim.loadSample("GA_LION1.mp3", 512);
    GA_SLOTH2 = minim.loadSample("GA_SLOTH2.mp3", 512);
    GA_LION2 = minim.loadSample("GA_LION2.mp3", 512);
  }


  else if (USER == "GORILLA_B") {
    //Dummy lines
    CAMEL_DUMMY = minim.loadSample("CAMEL_DUMMY.mp3", 512);
    GIRAFFE_DUMMY = minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    TIGER_DUMMY = minim.loadSample("TIGER_DUMMY.mp3", 512);
    PENGUIN_DUMMY = minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    SEAL_DUMMY = minim.loadSample("SEAL_DUMMY.mp3", 512);
    SLOTH_DUMMY = minim.loadSample("SLOTH_DUMMY.mp3", 512);

    //Audio for just GORILLA_B
    GB_SEAL1 = minim.loadSample("GB_SEAL1.mp3", 512);
    GB_CAMEL1 = minim.loadSample("GB_CAMEL1.mp3", 512);
    GB_PENGUIN1 = minim.loadSample("GB_PENGUIN1.mp3", 512);
    GB_PENGUIN2 = minim.loadSample("GB_PENGUIN2.mp3", 512);
    GB_GIRAFFE1 = minim.loadSample("GB_GIRAFFE1.mp3", 512);
    GB_TIGER1 = minim.loadSample("GB_TIGER1.mp3", 512);
    GB_SLOTH1 = minim.loadSample("GB_SLOTH1.mp3", 512);
  }

  //Audio for just COBRA_A
  else if (USER == "COBRA_A") {
    //Dummy lines
    CAMEL_DUMMY = minim.loadSample("CAMEL_DUMMY.mp3", 512);
    LION_DUMMY = minim.loadSample("LION_DUMMY.mp3", 512);
    TIGER_DUMMY = minim.loadSample("TIGER_DUMMY.mp3", 512);
    PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
    PENGUIN_DUMMY = minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    ELEPHANT_DUMMY = minim.loadSample("ELEPHANT_DUMMY.mp3", 512);

    CA_PENGUIN1 = minim.loadSample("CA_PENGUIN1.mp3", 512);
    CA_CAMEL1 = minim.loadSample("CA_CAMEL1.mp3", 512);
    CA_PANDA1 = minim.loadSample("CA_PANDA1.mp3", 512);
    CA_PANDA2 = minim.loadSample("CA_PANDA2.mp3", 512);
    CA_ELEPHANT1 = minim.loadSample("CA_ELEPHANT1.mp3", 512);
    CA_LION1 = minim.loadSample("CA_LION1.mp3", 512);
    CA_TIGER1 = minim.loadSample("CA_TIGER1.mp3", 512);
  }

  //Audio for just COBRA_B
  else if (USER == "COBRA_B") {
    //Dummy lines
    GIRAFFE_DUMMY = minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    LION_DUMMY = minim.loadSample("LION_DUMMY.mp3", 512);
    TIGER_DUMMY = minim.loadSample("TIGER_DUMMY.mp3", 512);
    PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
    SEAL_DUMMY = minim.loadSample("SEAL_DUMMY.mp3", 512);
    SLOTH_DUMMY = minim.loadSample("SLOTH_DUMMY.mp3", 512);

    CB_GIRAFFE1 = minim.loadSample("CB_GIRAFFE1.mp3", 512);
    CB_LION1 = minim.loadSample("CB_LION1.mp3", 512);
    CB_TIGER1 = minim.loadSample("CB_TIGER1.mp3", 512);
    CB_SLOTH1 = minim.loadSample("CB_SLOTH1.mp3", 512);
    CB_SLOTH2 = minim.loadSample("CB_SLOTH2.mp3", 512);
    CB_PANDA1 = minim.loadSample("CB_PANDA1.mp3", 512);
    CB_GIRAFFE2 = minim.loadSample("CB_GIRAFFE2.mp3", 512);
    CB_PANDA2 = minim.loadSample("CB_PANDA2.mp3", 512);
    CB_SEAL1 = minim.loadSample("CB_SEAL1.mp3", 512);
  }

  else if (USER == "POLAR_A") {
    //Dummy lines
    CAMEL_DUMMY = minim.loadSample("CAMEL_DUMMY.mp3", 512);
    GIRAFFE_DUMMY = minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
    PENGUIN_DUMMY = minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    ELEPHANT_DUMMY = minim.loadSample("ELEPHANT_DUMMY.mp3", 512);
    SLOTH_DUMMY = minim.loadSample("SLOTH_DUMMY.mp3", 512);

    //Audio for just POLAR_A
    PA_ELEPHANT1 = minim.loadSample("PA_ELEPHANT1.mp3", 512);
    PA_CAMEL1 = minim.loadSample("PA_CAMEL1.mp3", 512);
    PA_PENGUIN1 = minim.loadSample("PA_PENGUIN1.mp3", 512);
    PA_PENGUIN2 = minim.loadSample("PA_PENGUIN2.mp3", 512);
    PA_PANDA1 = minim.loadSample("PA_PANDA1.mp3", 512);
    PA_PANDA2 = minim.loadSample("PA_PANDA2.mp3", 512);
    PA_SLOTH1 = minim.loadSample("PA_SLOTH1.mp3", 512);
    PA_SLOTH2 = minim.loadSample("PA_SLOTH2.mp3", 512);
    PA_GIRAFFE1 = minim.loadSample("PA_GIRAFFE1.mp3", 512);
    PA_GIRAFFE2 = minim.loadSample("PA_GIRAFFE2.mp3", 512);
  }

  //Audio for just POLAR_B
  else if (USER == "POLAR_B") {
    //Dummy lines
    GIRAFFE_DUMMY = minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    TIGER_DUMMY = minim.loadSample("TIGER_DUMMY.mp3", 512);
    PANDA_DUMMY = minim.loadSample("PANDA_DUMMY.mp3", 512);
    PENGUIN_DUMMY = minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    SEAL_DUMMY = minim.loadSample("SEAL_DUMMY.mp3", 512);
    ELEPHANT_DUMMY = minim.loadSample("ELEPHANT_DUMMY.mp3", 512);

    PB_TIGER1 = minim.loadSample("PB_TIGER1.mp3", 512);
    PB_GIRAFFE1 = minim.loadSample("PB_GIRAFFE1.mp3", 512);
    PB_ELEPHANT1 = minim.loadSample("PB_ELEPHANT1.mp3", 512);
    PB_SEAL1 = minim.loadSample("PB_SEAL1.mp3", 512);
    PB_SEAL2 = minim.loadSample("PB_SEAL2.mp3", 512);
    PB_PENGUIN1 = minim.loadSample("PB_PENGUIN1.mp3", 512);
    PB_PANDA1 = minim.loadSample("PB_PANDA1.mp3", 512);
  }
}

void initializeHelpAudioAndImages() {
  if (USER == "GORILLA_A") {
    LIST_OWL_AUDIO[0] =  minim.loadSample("CAMEL_DUMMY.mp3", 512);  //("owl_help_0.mp3", 512);
    LIST_OWL_AUDIO[2] =  minim.loadSample("LION_DUMMY.mp3", 512);  //("owl_help_2.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("TIGER_DUMMY.mp3", 512);  //("owl_help_3.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("PANDA_DUMMY.mp3", 512); //("owl_help_4.mp3", 512);
    LIST_OWL_AUDIO[6] =  minim.loadSample("SEAL_DUMMY.mp3", 512); //("owl_help_6.mp3", 512);
    LIST_OWL_AUDIO[7] =  minim.loadSample("ELEPHANT_DUMMY.mp3", 512); //("owl_help_7.mp3", 512);
    LIST_OWL_AUDIO[8] =  minim.loadSample("SLOTH_DUMMY.mp3", 512); //("owl_help_8.mp3", 512);

    LIST_OWL_AUDIO[9] = minim.loadSample("owl_help_9_ga_trash.mp3", 512);
    LIST_HELP_IMAGES[9] = loadImage("data/oscar/help_stanley_288.png");
  }
  else if (USER == "GORILLA_B") {
    LIST_OWL_AUDIO[0] =  minim.loadSample("CAMEL_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[1] =  minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("TIGER_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[5] =  minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[6] =  minim.loadSample("SEAL_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[8] =  minim.loadSample("SLOTH_DUMMY.mp3", 512);
  }
  else if (USER == "COBRA_A") {
    LIST_OWL_AUDIO[0] =  minim.loadSample("CAMEL_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[2] =  minim.loadSample("LION_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("TIGER_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("PANDA_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[5] =  minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[7] =  minim.loadSample("ELEPHANT_DUMMY.mp3", 512);
  }
  else if (USER == "COBRA_B") {
    LIST_OWL_AUDIO[1] =  minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[2] =  minim.loadSample("LION_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("TIGER_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[8] =  minim.loadSample("SLOTH_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("PANDA_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[6] =  minim.loadSample("SEAL_DUMMY.mp3", 512);

    LIST_OWL_AUDIO[10] = minim.loadSample("owl_help_10_cb_rock.mp3", 512);
    LIST_HELP_IMAGES[10] = loadImage("data/oscar/help_stanley_288.png");
  }
  else if (USER == "POLAR_A") {
    LIST_OWL_AUDIO[0] =  minim.loadSample("CAMEL_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[1] =  minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("PANDA_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[5] =  minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[7] =  minim.loadSample("ELEPHANT_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[8] =  minim.loadSample("SLOTH_DUMMY.mp3", 512);

    LIST_OWL_AUDIO[11] = minim.loadSample("owl_help_11_pa_fish.mp3", 512);
    LIST_OWL_AUDIO[12] = minim.loadSample("owl_help_12_pa_vines.mp3", 512);
    LIST_HELP_IMAGES[11] = loadImage("data/oscar/help_patty_288.png");
    LIST_HELP_IMAGES[12] = loadImage("data/oscar/help_stanley_288.png");
  }
  else if (USER == "POLAR_B") {
    LIST_OWL_AUDIO[1] =  minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("TIGER_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("PANDA_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[7] =  minim.loadSample("ELEPHANT_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[6] =  minim.loadSample("SEAL_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[5] =  minim.loadSample("PENGUIN_DUMMY.mp3", 512);
  }
  else {

    LIST_OWL_AUDIO[0] =  minim.loadSample("CAMEL_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[1] =  minim.loadSample("GIRAFFE_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[2] =  minim.loadSample("LION_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[3] =  minim.loadSample("TIGER_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[4] =  minim.loadSample("PANDA_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[5] =  minim.loadSample("PENGUIN_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[6] =  minim.loadSample("SEAL_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[7] =  minim.loadSample("ELEPHANT_DUMMY.mp3", 512);
    LIST_OWL_AUDIO[8] =  minim.loadSample("SLOTH_DUMMY.mp3", 512);

    /*LIST_OWL_AUDIO[0] =  minim.loadSample("owl_help_0.mp3", 512);
     LIST_OWL_AUDIO[1] =  minim.loadSample("owl_help_1.mp3", 512);
     LIST_OWL_AUDIO[2] =  minim.loadSample("owl_help_2.mp3", 512);
     LIST_OWL_AUDIO[3] =  minim.loadSample("owl_help_3.mp3", 512);
     LIST_OWL_AUDIO[4] =  minim.loadSample("owl_help_4.mp3", 512);
     LIST_OWL_AUDIO[5] =  minim.loadSample("owl_help_5.mp3", 512);
     LIST_OWL_AUDIO[6] =  minim.loadSample("owl_help_6.mp3", 512);
     LIST_OWL_AUDIO[7] =  minim.loadSample("owl_help_7.mp3", 512);
     LIST_OWL_AUDIO[8] =  minim.loadSample("owl_help_8.mp3", 512); */
  }
}

void initializeClueAudio() {
  if (USER == "GORILLA_A") {
    CLUE1_AUDIO = minim.loadSample("GA_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("GA_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("GA_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("GA_CLUE4.mp3", 512);
  }
  else if (USER == "GORILLA_B") {
    CLUE1_AUDIO = minim.loadSample("GB_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("GB_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("GB_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("GB_CLUE4.mp3", 512);
  }
  else if (USER == "COBRA_A") {
    CLUE1_AUDIO = minim.loadSample("CA_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("CA_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("CA_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("CA_CLUE4.mp3", 512);
  }
  else if (USER == "COBRA_B") {
    CLUE1_AUDIO = minim.loadSample("CB_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("CB_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("CB_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("CB_CLUE4.mp3", 512);
  }
  else if (USER == "POLAR_A") {
    CLUE1_AUDIO = minim.loadSample("PA_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("PA_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("PA_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("PA_CLUE4.mp3", 512);
  }
  else if (USER == "POLAR_B") {
    CLUE1_AUDIO = minim.loadSample("PB_CLUE1.mp3", 512);
    CLUE2_AUDIO = minim.loadSample("PB_CLUE2.mp3", 512);
    CLUE3_AUDIO = minim.loadSample("PB_CLUE3.mp3", 512);
    CLUE4_AUDIO = minim.loadSample("PB_CLUE4.mp3", 512);
  }
}

//randomly chooses which animal the user is 
// and which group of 6 animal interacts with
void chooseUser() {
  float random_number = random(0, 6);
  if (random_number < 1) {
    USER = "GORILLA_A";
  }
  else if (random_number < 2) {
    USER = "GORILLA_B";
  }
  else if (random_number < 3) {
    USER = "POLAR_A";
  }
  else if (random_number < 4) {
    USER = "POLAR_B";
  }
  else if (random_number < 5) {
    USER = "COBRA_A";
  }
  else if (random_number < 6) {
    USER = "COBRA_B";
  }
}

void loadAnimalClasses() {
  if (USER == "GORILLA_A") {
    AFRICA1 = new Africa1(false);
    AFRICA2 = new Africa2(true);
    AFRICA3 = new Africa3(false);
    ASIA1 = new Asia1(true);
    ASIA2 = new Asia2(false);
    FROSTY1 = new Frosty1(true);
    FROSTY2 = new Frosty2(false);
    JUNGLE1 = new Jungle1(false);
    JUNGLE2 = new Jungle2(false);
  }
  else if (USER == "GORILLA_B") {
    AFRICA1 = new Africa1(false);
    AFRICA2 = new Africa2(false);
    AFRICA3 = new Africa3(true);
    ASIA1 = new Asia1(false);
    ASIA2 = new Asia2(true);
    FROSTY1 = new Frosty1(false);
    FROSTY2 = new Frosty2(false);
    JUNGLE1 = new Jungle1(true);
    JUNGLE2 = new Jungle2(false);
  }
  else if (USER == "COBRA_A") {
    AFRICA1 = new Africa1(false);
    AFRICA2 = new Africa2(true);
    AFRICA3 = new Africa3(false);
    ASIA1 = new Asia1(false);
    ASIA2 = new Asia2(false);
    FROSTY1 = new Frosty1(false);
    FROSTY2 = new Frosty2(true);
    JUNGLE1 = new Jungle1(false);
    JUNGLE2 = new Jungle2(true);
  }
  else if (USER == "COBRA_B") {
    AFRICA1 = new Africa1(true);
    AFRICA2 = new Africa2(false);
    AFRICA3 = new Africa3(false);
    ASIA1 = new Asia1(false);
    ASIA2 = new Asia2(false);
    FROSTY1 = new Frosty1(true);
    FROSTY2 = new Frosty2(false);
    JUNGLE1 = new Jungle1(true);
    JUNGLE2 = new Jungle2(false);
  }
  else if (USER == "POLAR_A") {
    AFRICA1 = new Africa1(false);
    AFRICA2 = new Africa2(false);
    AFRICA3 = new Africa3(true);
    ASIA1 = new Asia1(true);
    ASIA2 = new Asia2(false);
    FROSTY1 = new Frosty1(false);
    FROSTY2 = new Frosty2(true);
    JUNGLE1 = new Jungle1(false);
    JUNGLE2 = new Jungle2(false);
  }
  else if (USER == "POLAR_B") {
    AFRICA1 = new Africa1(true);
    AFRICA2 = new Africa2(false);
    AFRICA3 = new Africa3(true);
    ASIA1 = new Asia1(false);
    ASIA2 = new Asia2(false);
    FROSTY1 = new Frosty1(false);
    FROSTY2 = new Frosty2(false);
    JUNGLE1 = new Jungle1(false);
    JUNGLE2 = new Jungle2(true);
  }
}

void loadClueImages() {
  if (USER == "GORILLA_A") {
    CLUE1 = loadImage("data/clues/clue_fur.png");
    CLUE2 = loadImage("data/clues/clue_plants.png");
    CLUE3 = loadImage("data/clues/clue_2legs.png");
    CLUE4 = loadImage("data/clues/clue_black.png");
  }
  else if (USER == "GORILLA_B") {
    CLUE1 = loadImage("data/clues/clue_plants.png");
    CLUE2 = loadImage("data/clues/clue_climbstrees.png");
    CLUE3 = loadImage("data/clues/clue_muscular.png");
    CLUE4 = loadImage("data/clues/clue_black.png");
  }
  else if (USER == "COBRA_A") {
    CLUE1 = loadImage("data/clues/clue_sharpteeth.png");
    CLUE2 = loadImage("data/clues/clue_scales.png");
    CLUE3 = loadImage("data/clues/clue_poisonous.png");
    CLUE4 = loadImage("data/clues/clue_longtongue.png");
  }
  else if (USER == "COBRA_B") {  
    CLUE1 = loadImage("data/clues/clue_sharpteeth.png");
    CLUE2 = loadImage("data/clues/clue_scales.png");
    CLUE3 = loadImage("data/clues/clue_eggs.png");
    CLUE4 = loadImage("data/clues/clue_eatsmice.png");
  }
  else if (USER == "POLAR_A") {  
    CLUE1 = loadImage("data/clues/clue_white.png");
    CLUE2 = loadImage("data/clues/clue_4paws.png");
    CLUE3 = loadImage("data/clues/clue_blacknose.png");
    CLUE4 = loadImage("data/clues/clue_sharpteeth.png");
  }
  else if (USER == "POLAR_B") {
    CLUE1 = loadImage("data/clues/clue_4paws.png");
    CLUE2 = loadImage("data/clues/clue_fur.png");
    CLUE3 = loadImage("data/clues/clue_fish.png");
    CLUE4 = loadImage("data/clues/clue_claws.png");
  }
}


////////////////////////////////////////////////////////////////////////////////
//           _                    
//          | |                   
//        __| |_ __ __ ___      __
//       / _` | '__/ _` \ \ /\ / /
//      | (_| | | | (_| |\ V  V / 
//       \__,_|_|  \__,_| \_/\_/  
////////////////////////////////////////////////////////////////////////////////


// draw is called directly after setup
// called automatically
void draw() {

  CURRENT_TIME = millis();

  frameRate(12);
  drawCursor();

  if (ON_INTRO) {
    frameRate(30);
    image(OPENING_MOVIE, 0, 0);
    if (OPENING_MOVIE.time() >= 10) {
      ON_INTRO = false;
    }
  }

  if (ON_WIN) {
    WIN.doWin();
  }

  //automatically shows the guessing screen if need be
  else if (shouldShowGuess()) {
    WIN.doGuess();
  }

  else if (LAST_HABITAT_NUMBER != HABITAT_NUMBER) {
    Z = false;//cancel the Zs
  }

  //to stop the animal from visibly speaking if audio over
  else if (ANIMAL_TALKING && 
    (CURRENT_TIME - ANIMAL_TALKING_START_TIME >= AUDIO_LENGTH)) {
    ANIMAL_TALKING = false;
    doScene(HABITAT_NUMBER);
  }

  else if (CLUE_TALKING && 
    (CURRENT_TIME - CLUE_TALKING_START_TIME >= AUDIO_LENGTH)) {
    CLUE_TALKING = false;
  }
  //to display the correct animal for current habitat
  else if (ON_GUESS) {
  }

  //makes owl stay up as long as audio plays
  else if (ON_OWL) {
    if  (CURRENT_TIME - OWL_TALKING_START_TIME >= LIST_OWL_AUDIO[HELP].length()) {
      ON_OWL = false;
    }
    else {
      doOwl();
    }
  }

  else if (ON_MAP) {
    doMap();
  }


  else if (!ON_MAP && !WELCOME_SCREEN && !ON_INTRO && !ON_GUESS) { 
    doScene(HABITAT_NUMBER);
    //LIST_OF_HABITATS[HABITAT_NUMBER].displayAnimal(); //HERE IS WHERE ANIMALS ARE DISPLAYED
    //println(Z);
    if (Z) {
      LIST_OF_HABITATS[HABITAT_NUMBER].displayZs();
      println(Z);
    }
  }
  //printMem(); //DEBUG: To monitor memory usage

  //plays correct background music
  if (!WELCOME_SCREEN && !ON_INTRO && !ON_GUESS &&!ON_WIN) {
    whenPlay();
  }
}


// DEBUG section
// This is for memory concerns; it prints out the totals to the 
// console if called in draw()

/*void printMem() {
 Runtime runtime = Runtime.getRuntime();
 NumberFormat format = NumberFormat.getInstance();
 StringBuilder sb = new StringBuilder();
 long maxMemory = runtime.maxMemory();
 long allocatedMemory = runtime.totalMemory();
 long freeMemory = runtime.freeMemory();
 sb.append("free memory: 
 " + format.format(freeMemory / 1024) + "  ");
 sb.append("allocated memory: 
 " + format.format(allocatedMemory / 1024) + "  ");
 sb.append("max memory: 
 " + format.format(maxMemory / 1024) + "  ");
 sb.append("total free memory: 
 " + format.format((freeMemory + (maxMemory - allocatedMemory)) / 1024) + "  ");
 println(sb);
 }*/

// SOUNDS

void playBg() {  
  if (HABITAT_NUMBER == 0 || HABITAT_NUMBER == 1 || HABITAT_NUMBER == 2) {
    pauseAll();
    FROSTY_BG.loop(); //changed because of audio limit, both are wind sounds
  }
  if (HABITAT_NUMBER == 3 || HABITAT_NUMBER == 4) {
    pauseAll();
    ASIA_BG.loop();
  }
  if (HABITAT_NUMBER == 5 || HABITAT_NUMBER == 6) {
    pauseAll();
    FROSTY_BG.loop();
  } 
  if (HABITAT_NUMBER == 7 || HABITAT_NUMBER == 8) {
    pauseAll();    
    JUNGLE_BG.loop();
  }
}

//determines if this is the point where the guess screen should automatically pop up 
boolean shouldShowGuess() {
  if (! (!ANIMAL_TALKING && CURRENT_TIME - ANIMAL_TALKING_START_TIME >= AUDIO_LENGTH + 500)) {
    return false;
  }
  if (USER == "GORILLA_A" && AFRICA3_STATE == 4) { 
    return true;
  }
  else if (USER == "GORILLA_B" && JUNGLE2_STATE == 2) {
    return true;
  }
  else if (USER == "COBRA_A" && ASIA1_STATE == 2) {
    return true;
  }
  else if (USER == "COBRA_B" && FROSTY2_STATE == 2) { 
    return true;
  }
  else if (USER == "POLAR_A" && AFRICA2_STATE == 2) {
    return true;
  }
  else if (USER == "POLAR_B" && ASIA2_STATE == 2) {
    return true;
  }
  else {
    return false;
  }
}

void pauseAll() {
  //AFRICA_BG.pause();
  ASIA_BG.pause();
  JUNGLE_BG.pause();
  FROSTY_BG.pause();
}

//play the correct background music
void whenPlay() {
  /*if (HABITAT_NUMBER != LAST_HABITAT_NUMBER) {
   playBg();
   }*/
  if (((HABITAT_NUMBER==0) || (HABITAT_NUMBER==1) || (HABITAT_NUMBER==2))
    && !(LAST_HABITAT_NUMBER <= 2)) {
    playBg();
  }
  else if (((HABITAT_NUMBER ==3) || (HABITAT_NUMBER==4)) &&
    ((LAST_HABITAT_NUMBER != 3) && (LAST_HABITAT_NUMBER != 4))) {
    playBg();
  }
  else if (((HABITAT_NUMBER==5) || (HABITAT_NUMBER==6)) && 
    ((LAST_HABITAT_NUMBER != 5) && (LAST_HABITAT_NUMBER != 6))) {
    playBg();
  }
  else if (((HABITAT_NUMBER == 7) || (HABITAT_NUMBER == 8)) && !(LAST_HABITAT_NUMBER >= 7)) {
    playBg();
  }
  /*if (((HABITAT_NUMBER == 0) || (HABITAT_NUMBER == 1) || (HABITAT_NUMBER == 2)) &&
   !(LAST_HABITAT_NUMBER < 3)) {
   playBg();
   }
   else if (((HABITAT_NUMBER == 3) || (HABITAT_NUMBER == 4)) &&
   (!(HABITAT_NUMBER == 3) && !(HABITAT_NUMBER == 4))) {
   playBg();
   }
   else if (((HABITAT_NUMBER == 5) || (HABITAT_NUMBER == 6)) &&
   (!(HABITAT_NUMBER == 5) && !(HABITAT_NUMBER == 6))) {
   playBg();
   }
   else if (((HABITAT_NUMBER == 7) || (HABITAT_NUMBER == 8)) &&
   (!(HABITAT_NUMBER == 7) && !(HABITAT_NUMBER == 8))) {
   playBg();
   }*/
  LAST_HABITAT_NUMBER = HABITAT_NUMBER;
}


//changes the cursor to way we want it when we want it
//NOTE: *** does not currently show hand when on guess screen
void drawCursor() {
  // changes the cursor to show it's over the start button
  if (WELCOME_SCREEN) {

    if (cursorOver(STARTXi, STARTXf, STARTYi, STARTYf)) {
      cursor(HAND);
    }
    else {
      cursor(ARROW);
    }
  } 

  else if (ANIMAL_TALKING || ON_OWL || ON_INTRO || CLUE_TALKING) {
    cursor(ARROW);
  }

  else if (ON_GUESS) {
    if (WIN.cursorOverGuessOption()) {
      cursor(HAND);
    }
    else {
      cursor(ARROW);
    }
  }

  else if 
    (cursorOverMapButton() || 
    cursorOverHelp() || 
    cursor_over_left() ||
    cursor_over_right() ||
    (!LIST_OF_HABITATS[HABITAT_NUMBER].isSleeping &&
    LIST_OF_HABITATS[HABITAT_NUMBER].cursorOverAnimal()) ||
    (ON_MAP && (
  cursorOverAfrica1() ||
    cursorOverAfrica2() ||
    cursorOverAfrica3() ||
    cursorOverAsia1() ||
    cursorOverAsia2() ||
    cursorOverFrosty1() ||
    cursorOverFrosty2() ||
    cursorOverJungle1() ||
    cursorOverJungle2() ))) 
  {
    cursor(HAND);
  }
  else if (LIST_OF_HABITATS[HABITAT_NUMBER].cursorOverElement()) {
    cursor(HAND);
  }
  else if (NAV.cursorOverClue()) {
    cursor(HAND);
  }
  else if ((HABITAT_NUMBER == 8) && JUNGLE2.cursorOverTrash()) {
    cursor(HAND);
  }
  else {
    cursor(ARROW);
  }
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
  NAV.display();
  INTRO.display();
  ON_INTRO = true;
}

// map screen
void doMap() {
  MAP.display();
  ON_MAP = true;
}

//help Oscar Owl
void doOwl() {
  OWL.displayOwl();
  ON_OWL = true;
}

//---------------------
// all of the do methods display the habitat for each 
// specified habitat
// arrows are displayed because the backgrounds will hide them.

void doAfrica1() {
  AFRICA1.display();
  ARROWS.display();
  NAV.display();
}
void doAfrica2() {
  AFRICA2.display();
  ARROWS.display();
  NAV.display();
}

void doAfrica3() {
  AFRICA3.display();
  ARROWS.display();
  NAV.display();
}

void doAsia1() {
  ASIA1.display();
  ARROWS.display();
  NAV.display();
}

void doAsia2() {
  ASIA2.display();
  ARROWS.display();
  NAV.display();
}

void doFrosty1() {
  FROSTY1.display();
  ARROWS.display();
  NAV.display();
}

void doFrosty2() {
  FROSTY2.display();
  ARROWS.display();
  NAV.display();
}

void doJungle1() {
  JUNGLE1.display();
  ARROWS.display();
  NAV.display();
}

void doJungle2() {
  JUNGLE2.display();
  ARROWS.display();
  NAV.display();
}

//------------------------------------
//actions to take if mouse is pressed

// assume: on welcome screen
// determines what actions to perform if mouse pressed 
void mousePressedWelcomeScreen() {
  if (cursor_over_start() && mousePressed == true) {
    doIntro();
    WELCOME_SCREEN = false;
    OPENING_START_TIME = millis();
  }
}

// if mouse is pressed, do this stuff 
void mousePressed() {
  if (ON_WIN) {
    minim.stop();
    setup(); //restart 
  }
  //if welcome screen is up 
  if (WELCOME_SCREEN) { 
    mousePressedWelcomeScreen();
  }
  else if (ON_INTRO) {
  }
  //if an animal is talking
  else if (ANIMAL_TALKING || ON_OWL || CLUE_TALKING) {
  } //stops user from clicking on things while animal talking

  else if (!WELCOME_SCREEN && !ON_INTRO && NAV.cursorOverClue()) {
    NAV.mousePressedOnClue();
  }

  //if map is up
  else if (ON_MAP) {
    mousePressedOnMap();
  }

  else if (ON_GUESS) {
    WIN.mousePressedOnGuess();
  }

  //if over map 
  else if (cursorOverMapButton()) {
    doMap();
    ON_MAP = true;
  }

  //if over help
  else if (cursorOverHelp()) {
    OWL.talkOwl();
    ON_OWL = true;
  }

  else if (cursor_over_left()) {
    doScene(updateSceneNumber("left"));
  }
  else if (cursor_over_right()) {
    doScene(updateSceneNumber("right"));
  }
  else if (!ON_MAP && cursorOverHabitat()) {//&& (HABITAT_NUMBER == 0)) {
    LIST_OF_HABITATS[HABITAT_NUMBER].mousePressedInHabitat();
  }
}

// assume: on map
// determines what actions to perform if on map
void mousePressedOnMap() {
  if (cursorOverMapButton()) {
    ON_MAP = false;
  }
  else if (cursorOverHelp()) {
    OWL.talkOwl();
    ON_OWL = true;
  }
  else if (cursorOverAfrica1()) {
    doAfrica1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 0;
    ON_MAP = false;
  }
  else if (cursorOverAfrica2()) {
    doAfrica2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 1;
    ON_MAP = false;
  }
  else if (cursorOverAfrica3()) {
    doAfrica3();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 2;
    ON_MAP = false;
  }
  else if (cursorOverAsia1()) {
    doAsia1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 3;
    ON_MAP = false;
  }
  else if (cursorOverAsia2()) {
    doAsia2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 4;
    ON_MAP = false;
  }
  else if (cursorOverFrosty1()) {
    doFrosty1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 5;
    ON_MAP = false;
  }
  else if (cursorOverFrosty2()) {
    doFrosty2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 6;
    ON_MAP = false;
  }
  else if (cursorOverJungle1()) {
    doJungle1();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 7;
    ON_MAP = false;
  }
  else if (cursorOverJungle2()) {
    doJungle2();
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER = 8;
    ON_MAP = false;
  }
}


// to update the scene the user is on
// when they click on an arrow key as specified by query
int updateSceneNumber(String query) {
  if (query.equals("left") && HABITAT_NUMBER == 0) {
    HABITAT_NUMBER = 8;
    LAST_HABITAT_NUMBER = 0;
  }
  else if (query.equals("right") && HABITAT_NUMBER == 8) {
    HABITAT_NUMBER = 0;
    LAST_HABITAT_NUMBER = 8;
  }
  else if (query.equals("left")) {
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER--;
  }
  else { // assume query == "right" 
    LAST_HABITAT_NUMBER = HABITAT_NUMBER;
    HABITAT_NUMBER++;
  }
  return HABITAT_NUMBER;
}


//--------------------------------------------
void mouseMoved() {
  if (!WELCOME_SCREEN && !ON_MAP && !ON_GUESS && !ON_INTRO) {
    //LIST_OF_HABITATS[HABITAT_NUMBER].mouseOverInHabitat();
    LIST_OF_HABITATS[HABITAT_NUMBER].mouseMovedInHabitat();
  }
}


//---------------------------------------------
// determine if cursor is over a certain area 

// determines if cursor in a certain box
boolean cursorOver(int xmin, int xmax, int ymin, int ymax) {
  return xmin < mouseX && mouseX < xmax && ymin < mouseY && mouseY < ymax;
}

// determines if cursor over the start button 
// assume: on welcome page
boolean cursor_over_start() {
  return cursorOver(STARTXi, STARTXf, STARTYi, STARTYf);
}


//assume: not on welcome screen, not on map
// determines if mouse pressed in a habitat
boolean cursorOverHabitat() {
  return cursorOver(0, 960, 0, 540);
}

// determines if cursor over map 
boolean cursorOverMapButton() {
  return cursorOver(MAPXi, MAPXf, MAPYi, MAPYf);
}
boolean cursorOverHelp() {
  return cursorOver(HELPXi, HELPXf, HELPYi, HELPYf);
}
boolean cursor_over_left() {
  return cursorOver(LEFTXi, LEFTXf, LEFTYi, LEFTYf);
}
boolean cursor_over_right() {
  return cursorOver(RIGHTXi, RIGHTXf, RIGHTYi, RIGHTYf);
}

// assuming in the map
boolean cursorOverAfrica1() {
  return cursorOver(473, 562, 96, 160);
}
boolean cursorOverAfrica2() {
  return cursorOver(564, 654, 171, 237);
}
boolean cursorOverAfrica3() {
  return cursorOver(581, 670, 270, 336);
}
boolean cursorOverAsia1() {
  return cursorOver(527, 616, 370, 435);
}
boolean cursorOverAsia2() {
  return cursorOver(423, 513, 409, 474);
}
boolean cursorOverFrosty1() {
  return cursorOver(318, 407, 369, 433);
}
boolean cursorOverFrosty2() {
  return cursorOver(267, 356, 272, 336);
}
boolean cursorOverJungle1() {
  return cursorOver(283, 372, 171, 235);
}
boolean cursorOverJungle2() {
  return cursorOver(373, 461, 95, 159);
}


//method for opening intro
void movieEvent(Movie m) {
  m.read();
}

public abstract class Habitat { 

  boolean isSleeping;
  int sleepingx;
  int sleepingy;
  
  int frameZs = 0; 

  Habitat(boolean isSleeping, int sleepingx, int sleepingy) {
    this.isSleeping = isSleeping;
    this.sleepingx = sleepingx;
    this.sleepingy = sleepingy;
  } 

  PImage background =  loadImage("data/africa_1.png");  

  //displays the background of the scene
  abstract void display();

  //displays the animal
  public abstract void displayAnimal();

  //determines if cursor over animal in the habitat
  public abstract boolean cursorOverAnimal();

  //decides which actions to take if mouse was pressed in this habitat
  public abstract void mousePressedInHabitat();

  //decides what to do if moused over in habitat
  //abstract void mouseOverInHabitat();

  //determines what the current talk is 
  abstract AudioSample currentTalk(); 

  //plays correct lines for animal
  abstract void playCurrentTalk();

  //updates necessary state numbers for habitats/animals
  abstract void updateStateNumbers();
  
  //display the Zs (when mouse over sleeping animal)
  void displayZs() {
    frameZs = (frameZs + 1);
    if (frameZs < 13) {
      image(GIFS_ZS[frameZs], sleepingx, sleepingy - 180);
    }
    else {
      Z = false;
      frameZs = 0;
    }
  }
  
  boolean cursorOverElement() {
    //...yea, so this isn't the best practice, but it works so ...
    return false;
  
  }
    //decides what to do if something moused over
  void mouseMovedInHabitat() {
    if (this.isSleeping && cursorOverAnimal()) {
      Z = true;
      println(Z);
      //displayZs();
    }
  }
}


//The owl that comes up to help if user requests it
class Owl { 

  Owl() {
  }

  void displayOwl() {
    image(LIST_HELP_IMAGES[HELP], 520, 200);
  }

  void talkOwl() {
    LIST_OWL_AUDIO[HELP].trigger();
    OWL_TALKING_START_TIME = millis();
  }
}


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
    return cursorOver(guess1_x, guess1_x + 200, guess_y, guess_y + 200) 
    || cursorOver(guess2_x, guess2_x + 200, guess_y, guess_y + 200) 
    || cursorOver(guess3_x, guess3_x + 200, guess_y, guess_y + 200) 
    || cursorOver(guess4_x, guess4_x + 200, guess_y, guess_y + 200); 
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


// Calvin Camel
class Africa1 extends Habitat {  
  
  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 500;
  int animalTop = 100;

  PImage background = loadImage("data/africa_1.png");
  
  PImage animal_sleeping;

  Africa1(boolean isSleeping) { //isSleeping too
    super(isSleeping, 200, 200);
    if (isSleeping) {
      PImage animal_sleeping = loadImage("data/sleep/calvin_sleep_288.png");
    }
  }

  //display the background for this class
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
  } 

  //display the correct animal image
  void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, sleepingx, sleepingy);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //display the talking animal
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_CAMEL_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal 
  void displayAnimalNotTalking() {
    image(GIFS_CAMEL_TALKING[0], animalLeft, animalTop);
    //image(animal_not_talking, animalLeft, animalTop);
  }

  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) { 
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk(); //sound
    }
  }

  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    println("GOT TO CURRENT talk");
    updateStateNumbers();
  }

  //update state numbers after animal has spoken
  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (AFRICA1_STATE == 0) {
        AFRICA1_STATE ++;
        JUNGLE1_STATE ++;
        HELP = 7;
      }    
      else if (AFRICA1_STATE == 2) {
        AFRICA1_STATE ++ ;
        AFRICA3_STATE ++ ; //Leonard Lion
        NAV.clue3 = true; //two legs
        HELP = 2;
      }
    }
    else if (USER == "GORILLA_B") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        FROSTY1_STATE ++;
        NAV.clue1 = true; //eat plants
        HELP = 5;
      }
    }
    else if (USER == "COBRA_A") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        ASIA2_STATE ++;
        NAV.clue1 = true; //sharp teeth
        HELP = 4; //Patty Panda
      }
    }
    else if (USER == "COBRA_B") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        ASIA1_STATE++;
        NAV.clue1 = true;
      }
    }
    else if (USER == "POLAR_A") {
      if (AFRICA1_STATE == 1) {
        AFRICA1_STATE ++;
        FROSTY1_STATE ++;
        NAV.clue1 = true;
        HELP = 5; //Peter Penguin
      }
    }
    else if (USER == "POLAR_B") {
    }
  }


  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 200)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    }
  }

  //plays what the animal should currently be saying
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (AFRICA1_STATE == 0) { 
        return GA_CAMEL1;
      }
      else if (AFRICA1_STATE == 1) { 
        return CAMEL_DUMMY;
      }
      else if (AFRICA1_STATE == 2) { 
        return GA_CAMEL2;
      }
      else if (AFRICA1_STATE == 3) { 
        return CAMEL_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
      if (AFRICA1_STATE == 0) {
        return CAMEL_DUMMY;
      }
      else if (AFRICA1_STATE == 1) {
        return GB_CAMEL1;
      }
      else if (AFRICA1_STATE == 2) {
        return CAMEL_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      if (AFRICA1_STATE == 0) {
        return CAMEL_DUMMY;
      }
      else if (AFRICA1_STATE == 1) {
        return PA_CAMEL1;
      }
      else if (AFRICA1_STATE == 2) {
        return CAMEL_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      //Calvin Camel is asleep
    }
    else if (USER == "COBRA_A") {
      if (AFRICA1_STATE == 0) {
        return CAMEL_DUMMY;
      }
      else if (AFRICA1_STATE ==1) {
        return CA_CAMEL1;
      }
      else if (AFRICA1_STATE == 2) {
        return CAMEL_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      //Calvin Camel is asleep
    } 
    return CAMEL_DUMMY;
    //this is just so it doesn't yell at us for now, delete it later!
  }
}


// Gerry Giraffe
class Africa2 extends Habitat {
  int frame;
  int numTalkingFrames = 8;

  int animalLeft = 500;
  int animalTop = 100;
  
  PImage background = loadImage("data/africa_2.png");
  PImage animal_sleeping;

  Africa2(boolean isSleeping) {
    super(isSleeping, 400, 100);
    if (isSleeping) {
     animal_sleeping = loadImage("data/gerry_sleep_288.png");
    }
  }
  //displays the background for the habitat
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
  } 

  //determines if the animal in the habitat was clicked on
  void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, sleepingx, sleepingy);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //display the talking animal
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_GIRAFFE_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_GIRAFFE_TALKING[0], animalLeft, animalTop);
  }

  //determines if the mouse was pressed on an animal
  boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 200)))
      && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else { 
    return ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
      && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

//decides what to do if the mouse was pressed in the habitat
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (AFRICA2_STATE == 2) && USER == "POLAR_A") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }


  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    updateStateNumbers();
  }

  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
    } //Gerry Giraffe is asleep
    else if (USER == "GORILLA_B") {
      if (AFRICA2_STATE == 1) {
        AFRICA2_STATE ++;
        FROSTY1_STATE ++;
        NAV.clue2 = true; //climb trees
        HAS_ITEM = true;
        HELP = 5; //Peter Penguin
      }
    }
    else if (USER == "COBRA_A") {
    } //Gerry Giraffe is asleep
    else if (USER == "COBRA_B") {
      if (AFRICA2_STATE == 0) {
        AFRICA2_STATE ++;
        AFRICA3_STATE ++;
        HELP = 2;//Leonard Lion
      }
      if (AFRICA2_STATE == 2) {
        AFRICA2_STATE ++;
        ASIA2_STATE ++; //Patty Panda
        HELP = 4; //Patty Panda
      }
    }
    else if (USER == "POLAR_A") {
      if (AFRICA2_STATE == 1) {
        AFRICA2_STATE ++;
      }
    }
    else if (USER == "POLAR_B") {
      if (AFRICA2_STATE == 1) {
        AFRICA2_STATE ++;
        JUNGLE1_STATE ++;
        NAV.clue1 = true; //four paws
        HELP = 7; //Eliza Elephant
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
    } //Gerry Giraffe is asleep
    else if (USER == "GORILLA_B") {
      if (AFRICA2_STATE == 0) {
        return GIRAFFE_DUMMY;
      }
      else if (AFRICA2_STATE == 1) {
        return GB_GIRAFFE1;
      }
      else if (AFRICA2_STATE == 2) {
        return GIRAFFE_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      if (AFRICA2_STATE == 0) {
        return GIRAFFE_DUMMY;
      }
      else if (AFRICA2_STATE == 1) {
        return PA_GIRAFFE1;
      }
      else if (AFRICA2_STATE == 2) {
        return PA_GIRAFFE2;
      }
    }
    else if (USER == "POLAR_B") {
      if (AFRICA2_STATE == 0) {
        return GIRAFFE_DUMMY;
      }
      else if (AFRICA2_STATE == 1) {
        return PB_GIRAFFE1;
      }
      else if (AFRICA2_STATE == 2) {
        return GIRAFFE_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      //Gerry Giraffe is asleep
    }
    else if (USER == "COBRA_B") {
      if (AFRICA2_STATE == 0) {
        return CB_GIRAFFE1;
      }
      else if (AFRICA2_STATE == 1) {
        return GIRAFFE_DUMMY;
      }
      else if (AFRICA2_STATE == 2) {
        return CB_GIRAFFE2;
      }
      else if (AFRICA2_STATE == 3) {
        return GIRAFFE_DUMMY;
      }
    }
    return GIRAFFE_DUMMY;
    //this is just so it doesn't yell at us for now, delete it later!
  }
}


// Leonard Lion
class Africa3 extends Habitat {
  int frame;
  int numTalkingFrames = 10; 

  int animalLeft = 300;
  int animalTop = 50;

  PImage background = loadImage("data/africa_3.png");

  PImage animal_sleeping;

  Africa3(boolean isSleeping) {
    super(isSleeping, 200, 200);
    if (isSleeping) {
      animal_sleeping = loadImage("data/sleep/leonard_sleep_288.png");
    }
  }


  //displays the correct animal
  void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, sleepingx, sleepingy);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //display the talking anial
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_LION_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_LION_TALKING[0], animalLeft, animalTop);
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
    displayAnimal();
  }

  // determines if 
  boolean cursorOverAnimal() {   
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 200)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

  //decides what to do if the mouse was pressed in the habitat
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }


  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    updateStateNumbers();
  }

  //updates the state numbers to get  next line
  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (AFRICA3_STATE == 1) {
        AFRICA3_STATE ++;
        JUNGLE2_STATE ++; //SLOTH
        HELP = 8;
      }
      if (AFRICA3_STATE == 3) {
        AFRICA3_STATE ++; //to get to final screen kind of
      }
    }
    else if (USER == "GORILLA_B") {
    }//Leonard Lion is asleep
    else if (USER == "COBRA_A") {
      if (AFRICA3_STATE == 1) {
        AFRICA3_STATE ++;
        ASIA2_STATE ++;
        NAV.clue2 = true;
        HELP = 4; //Patty Panda
      }
    }
    else if (USER == "COBRA_B") {
      if (AFRICA3_STATE == 1) {
        AFRICA3_STATE++;
        ASIA1_STATE ++;
        NAV.clue1 = true;
        HELP = 3;//Tina Tiger
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (AFRICA3_STATE == 0) { 
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 1) {
        return GA_LION1;
      }
      else if (AFRICA3_STATE == 2) {
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 3) {
        return GA_LION2;
      }
      //  else if (AFRICA3_STATE == 4) {
      //  return GA_LION3;
      //}
    }
    else if (USER == "GORILLA_B") {
    } //Leonard Lion is sleeping
    else if (USER == "POLAR_A") {
      //Leonard Lion is asleep
    }
    else if (USER == "POLAR_B") {
      //Leonard Lion is asleep
    }
    else if (USER == "COBRA_A") {
      if (AFRICA3_STATE == 0) {
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 1) {
        return CA_LION1;
      }
      else if (AFRICA3_STATE == 2) {
        return LION_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      if (AFRICA3_STATE == 0) {
        return LION_DUMMY;
      }
      else if (AFRICA3_STATE == 1) {
        return CB_LION1;
      }
      else if (AFRICA3_STATE == 2) {
        return LION_DUMMY;
      }
    }

    return LION_DUMMY;
  }
}


//arrows
// and some items that you gather
class Arrows {
  PImage background;

  Arrows() {
    this.background = loadImage("data/arrows.png");
  }

  //displays the arrows and any necessary elements
  public void display() {
    image(background, 0, 0);
    if (USER == "GORILLA_A" && HAS_ITEM) {
      displayToken();
    }
    if (USER == "GORILLA_B" && HAS_ITEM) {
      displayCherryBlossom();
    }
    if (USER == "POLAR_A" && HAS_ITEM) {
      if (FROSTY1_STATE >= 3) {
        displayBamboo();
      }
      else {
        displayFish();
      }
    }
    if (USER == "POLAR_B" && HAS_ITEM) {
      displayFish();
    }
  }

  //assume GORILLA_B and that user HAS_ITEM
  void displayCherryBlossom() {
    image(CHERRY_BLOSSOM_CORNER, 810, 0);
  }

  //assume POLAR_A and that user has it
  void displayFish() {
    image(FISH_CORNER, 810, 0);
  }

  //assume POLAR_A and that user HAS_ITEM
  void displayBamboo() {
    image(BAMBOO_CORNER, 810, 0);
  }

  //assume GORILLA_A and HAS_ITEM
  void displayToken() {
    image(SLOTH_TOKEN_CORNER, 810, 0);
  }
}


// Tina Tiger
class Asia1 extends Habitat {
  int frame;
  int numTalkingFrames = 8;

  int animalLeft = 500;
  int animalTop = 300;

  PImage background = loadImage("data/asia_1.png");
  PImage animal_not_talking = loadImage("data/tina_tiger.gif");
  PImage animal_sleeping = loadImage("data/tina_sleep_288.png");

  Asia1(boolean isSleeping) {
    super(isSleeping, 300, 250);
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
  }

  //displays the correct animal
  void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, sleepingx, sleepingy);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //displays the talking animal 
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_TIGER_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_TIGER_TALKING[0], animalLeft, animalTop);
  }

  //determines if the animal in the habitat was clicked on
  boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 220)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return  ((animalLeft + 50 < mouseX) && (mouseX < (animalLeft + 230)))
        && ((animalTop + 40 < mouseY) && (mouseY < (animalTop + 280)));
    }
  }

  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (ASIA1_STATE == 2) && USER == "COBRA_A") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }  


  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    updateStateNumbers();
  }

  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
    } //Tina Tiger is asleep
    else if (USER == "GORILLA_B") {
      if (ASIA1_STATE == 1) {
        println("GOT TO ASIA ONE STATE HERE YO");
        ASIA1_STATE ++;
        JUNGLE2_STATE ++;
        NAV.clue4 = true; //black fur
        HELP = 8; //Stanley Sloth
      }
    }
    else if (USER == "COBRA_A") {
      if (ASIA1_STATE == 1) {
        ASIA1_STATE ++;
        //Finish
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA1_STATE == 1) {
        ASIA1_STATE ++;
        JUNGLE2_STATE ++;
        NAV.clue2 = true;
        HELP = 8; //Stanley Sloth
      }
    }
    else if (USER == "POLAR_A") {
    } // Tina Tiger is asleep
    else if (USER == "POLAR_B") {
      if (ASIA1_STATE == 0) {
        ASIA1_STATE ++;
        AFRICA2_STATE ++;
        HELP = 1; //Gerry Giraffe
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
    } // Tina Tiger is asleep
    else if (USER == "GORILLA_B") {
      if (ASIA1_STATE == 0) {
        return TIGER_DUMMY;
      }
      else if (ASIA1_STATE == 1) {
        return GB_TIGER1;
      }
      else if (ASIA1_STATE == 2) {
        return TIGER_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      //Tina Tiger is asleep
    }
    else if (USER == "POLAR_B") {
      if (ASIA1_STATE == 0) {
        return PB_TIGER1;
      }
      else if (ASIA1_STATE == 1) {
        return TIGER_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      if (ASIA1_STATE == 0) {
        return TIGER_DUMMY;
      }
      else if (ASIA1_STATE ==1) {
        return CA_TIGER1;
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA1_STATE == 0) {
        return TIGER_DUMMY;
      }
      else if (ASIA1_STATE == 1) {
        return CB_TIGER1;
      }
      else if (ASIA1_STATE == 2) {
        return TIGER_DUMMY;
      }
    }
    return CAMEL_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}





// Patty Panda
class Asia2 extends Habitat {
  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 500;
  int animalTop = 250;
  
  int elx = 200;
  int ely = 200;
  
  boolean replaced_bamboo = false;
  boolean has_token = false;

  PImage background = loadImage("data/asia_2.png");
  
  PImage animal_sleeping;
  
  Asia2(boolean isSleeping) {
    super(isSleeping, 200, 200); 
    if (isSleeping) {
      animal_sleeping = loadImage("data/sleep/patty_sleep_288.png");
    }
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
    
    if (USER == "POLAR_A") {
      displayBambooOrFish();
    }
    if (has_token) {
      displayToken();
    }
  }
  
  void displayToken() {
    image(SLOTH_TOKEN_IMAGE, elx, ely);
  }
  
  void displayBambooOrFish() {
    if (!replaced_bamboo) {
    image(BAMBOO_IMAGE, elx, ely);
    }
    else {
      image (FISH_IMAGE, elx, ely);
    }
  }
  
  //displays the correct animal 
  void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, sleepingx, sleepingy);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //displays the talking animal 
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_PANDA_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_PANDA_TALKING[0], animalLeft, animalTop);
  }

  boolean cursorOverAnimal() {   
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 200)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }
  
  boolean cursorOverElement() {
    return cursorOverBamboo();
  }
  
  boolean cursorOverBamboo() {
     return (USER == "POLAR_A" && !replaced_bamboo && (FROSTY1_STATE == 2)) &&
     ((elx < mouseX) && (mouseX < (elx + 200)))
        && ((ely < mouseY) && (mouseY < (ely + 200)));
  }
    

  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (USER == "POLAR_A" && cursorOverBamboo() && !replaced_bamboo && (FROSTY1_STATE == 2)) {
      replaced_bamboo = true;
      ASIA2_STATE ++;
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
      HELP = 5;
      FROSTY1_STATE ++;
      ASIA2_STATE ++;

    }
    else if (cursorOverAnimal() && (ASIA2_STATE == 2) && USER == "POLAR_B") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }  

  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    updateStateNumbers();
  }

  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        JUNGLE2_STATE ++; //Stanley Sloth
        HELP = 8;
      }
      if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        FROSTY2_STATE ++;//Sam Seal
        NAV.clue2 = true; //love to eat plants
        HELP = 6;
        HAS_ITEM = false;
        has_token = true;
      }
    }
    else if (USER == "GORILLA_B") { //Patty Panda is asleep
    }
    else if (USER == "COBRA_A") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        AFRICA3_STATE ++;
        HELP = 2; //Leonard Lion
      }
      else if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        JUNGLE1_STATE ++;
        NAV.clue3 = true;
        HELP = 7; //Eliza Elephant
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++;
        AFRICA2_STATE ++;
        HELP = 1; //Gerry Giraffe
      }
      if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        FROSTY2_STATE ++;
        NAV.clue4 = true; //eats mice
        HELP = 6;//Sam Seal
      }
    }
    else if (USER == "POLAR_A") {
      if (ASIA2_STATE == 1) {
        HELP = 5; //Peter Penguin
      }
      else if (ASIA2_STATE == 3) {
        ASIA2_STATE ++;
        JUNGLE2_STATE ++;
        NAV.clue3 = true; //black nose
        HELP = 8; //Stanley sloth
      }
    }
    else if (USER == "POLAR_B") {
      if (ASIA2_STATE == 1) {
        ASIA2_STATE ++; //last person
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (ASIA2_STATE == 0) { 
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return GA_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return GA_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
    } //Patty Panda is asleep
    else if (USER == "POLAR_A") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return PA_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return PA_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return PB_PANDA1;
      }
    }
    else if (USER == "COBRA_A") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return CA_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return CA_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      if (ASIA2_STATE == 0) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 1) {
        return CB_PANDA1;
      }
      else if (ASIA2_STATE == 2) {
        return PANDA_DUMMY;
      }
      else if (ASIA2_STATE == 3) {
        return CB_PANDA2;
      }
      else if (ASIA2_STATE == 4) {
        return PANDA_DUMMY;
      }
    }
    return PANDA_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}



// Peter Penguin
class Frosty1 extends Habitat {  
  int frame;
  int numTalkingFrames = 4;

  int animalLeft = 200;
  int animalTop = 160;


  PImage background = loadImage("data/frosty_1.png");
  PImage animal_not_talking = loadImage("data/peter_penguin.gif");
  PImage animal_sleeping = loadImage("data/peter_sleep_288.png");
  
  boolean show_blossom = false;

  Frosty1(boolean isSleeping) {
    super(isSleeping, 200, 200);
  }
  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
    
    if (show_blossom) {
      image (CHERRY_BLOSSOM, 250, 400);
    }
    if (USER == "POLAR_A" && FROSTY1_STATE > 3) {
      image(BAMBOO_IMAGE, 250, 400);
    }
  }

  //displays the correct animal 
  void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, sleepingx, sleepingy);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //displays the talking animal 
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_PENGUIN_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_PENGUIN_TALKING[0], animalLeft, animalTop);
  }

  //determines if the cursor is over Peter Penguin
  boolean cursorOverAnimal() { 
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 200)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return  ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

  //delegates what should happen if mouse pressed in Peter Penguin's habitat
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
      println("got here homeslice3");
    }
  }  

  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    updateStateNumbers();
  }

  //updates state numbers after an animal has spoken
  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
    }//Peter Penguin is asleep
    
    else if (USER == "GORILLA_B") {
      if (FROSTY1_STATE == 1) {
        FROSTY1_STATE ++;
        AFRICA2_STATE ++;
        HELP = 1;
      }
      else if (FROSTY1_STATE == 3) {
        println("got here homeslice");
        FROSTY1_STATE ++;
        ASIA1_STATE ++;
        NAV.clue3 = true; //muscles
        HELP = 3; //Tina Tiger
        HAS_ITEM = false;
        show_blossom = true;
      }
    }
    else if (USER == "COBRA_A") {
      if (FROSTY1_STATE == 0) {
        FROSTY1_STATE ++;
        AFRICA1_STATE ++;
        HELP = 0; //Calvin Camel
      }
    }
    else if (USER == "POLAR_A") {
      if (FROSTY1_STATE == 1) {
        FROSTY1_STATE ++;
        HAS_ITEM = true;
        HELP = 11; //switch bamboo for fish
      }
      else if (FROSTY1_STATE == 3) {
        FROSTY1_STATE ++;
        ASIA2_STATE ++;
        NAV.clue2 = true;
        HELP = 4; //Patty Panda
        HAS_ITEM = false;
      }
    }
    else if (USER == "POLAR_B") {
      if (FROSTY1_STATE == 1) {
        FROSTY1_STATE++;
        FROSTY2_STATE ++;
        NAV.clue3 = true;
        HELP = 6; //Sam Seal
        HAS_ITEM = true;
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
    } //Peter Penguinn is asleep
    else if (USER == "GORILLA_B") {
      if (FROSTY1_STATE == 0) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 1) {
        return GB_PENGUIN1;
      }
      else if (FROSTY1_STATE == 2) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 3) {
        return GB_PENGUIN2;
      }
      else if (FROSTY1_STATE == 4) {
        return PENGUIN_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      if (FROSTY1_STATE == 0) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 1) {
        return PA_PENGUIN1;
      }
      else if (FROSTY1_STATE == 2) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 3) {
        return PA_PENGUIN2;
      }
      else if (FROSTY1_STATE == 4) {
        return PENGUIN_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      if (FROSTY1_STATE == 0) {
        return PENGUIN_DUMMY;
      }
      else if (FROSTY1_STATE == 1) {
        return PB_PENGUIN1;
      }
      else if (FROSTY1_STATE == 2) {
        return PENGUIN_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      if (FROSTY1_STATE == 0) {
        return CA_PENGUIN1;
      }
      else if (FROSTY2_STATE == 1) {
        return PENGUIN_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      //Peter Penguin is asleep
    }
    return PENGUIN_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}

// Sam Seal (Conor doesn't know difference between seal and sea lion)
class Frosty2 extends Habitat {
  int frame;
  int numTalkingFrames = 6;

  int animalLeft = 200;
  int animalTop = 220;
 

  PImage background = loadImage("data/frosty_2.png");
  boolean has_fish;

PImage animal_sleeping;
  Frosty2(boolean isSleeping) {
    super(isSleeping, 200, 200);
    if (isSleeping) {
      animal_sleeping = loadImage("data/sleep/sam_sleep_288.png");
      
    }
  }
  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
        
        if (has_fish) {
          image(FISH_IMAGE, 400, 400);
        }
  }

  //displays the correct animal 
  void displayAnimal() {

    if (isSleeping) {
      image(animal_sleeping, sleepingx, sleepingy);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //displays the talking animal 
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_SEAL_TALKING[frame], animalLeft, animalTop);
  }

  //displays the not talking animal
  void displayAnimalNotTalking() {
    image(GIFS_SEAL_TALKING[0], animalLeft, animalTop);
  }

  boolean cursorOverAnimal() { 
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 200)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 200)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 200)));
    }
  }

  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal() && (FROSTY2_STATE == 2) && USER == "COBRA_B") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
  }  

  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    updateStateNumbers();
  }

  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (FROSTY2_STATE == 1) {
        FROSTY2_STATE ++;
        AFRICA1_STATE ++;
        HELP = 0;
      }
    }
    else if (USER == "GORILLA_B") {
      if (FROSTY2_STATE == 0) {
        FROSTY2_STATE ++;
        AFRICA1_STATE ++;
        HELP = 0;
      }
    }
    else if (USER == "COBRA_A") {
    } //Sam Seal is asleep
    else if (USER == "COBRA_B") {
      FROSTY2_STATE ++; //the last person to talk to here
    }
    else if (USER == "POLAR_A") {
    }//Sam Seal is asleep
    else if (USER == "POLAR_B") {
      if (FROSTY2_STATE == 1) {
        FROSTY2_STATE ++;
        FROSTY1_STATE ++;
        HELP = 5; //Peter Penguin *** but really need to get a fish
      }
      if (FROSTY2_STATE == 3) {
        FROSTY2_STATE ++;
        ASIA2_STATE ++;
        NAV.clue4 = true;
        HELP = 4; //Patty Panda
        HAS_ITEM = false;
        has_fish = true;
      }
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (FROSTY2_STATE == 0) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 1) {
        return GA_SEAL1;
      }
      else if (FROSTY2_STATE == 2) {
        return SEAL_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
      if (FROSTY2_STATE == 0) {
        return GB_SEAL1;
      }
      else if (FROSTY2_STATE == 1) {
        return SEAL_DUMMY;
      }
    }
    else if (USER == "POLAR_A") {
      //Sam Seal is asleep
    }
    else if (USER == "POLAR_B") {
      if (FROSTY2_STATE == 0) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 1) {
        return PB_SEAL1;
      }
      else if (FROSTY2_STATE == 2) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 3) {
        return PB_SEAL2;
      }
      else if (FROSTY2_STATE == 4) {
        return SEAL_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      //Sam Seal is asleep
    }
    else if (USER == "COBRA_B") {
      if (FROSTY2_STATE == 0) {
        return SEAL_DUMMY;
      }
      else if (FROSTY2_STATE == 1) {
        return CB_SEAL1;
      }
    }
    return SEAL_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}


// Intro class for when animal first coming out of box
// after user has hit the start button
class Intro {
    
  Intro() {
  }
  
  PImage img;
  void display() {
    OPENING_MOVIE.play();
  }
  
  
  boolean mousePressedAnimal() { // yea we know this isn't super legit
  return false;
  }
}

// Eliza Elephant
class Jungle1 extends Habitat {
  int frame;
  int numTalkingFrames = 16;

  int animalLeft = 500;
  int animalTop = 170;


  PImage background = loadImage("data/jungle_1.png"); 
  
  PImage animal_sleeping;
  
  Jungle1(boolean isSleeping) {
    super(isSleeping, 200, 200);
    if (isSleeping) {
      animal_sleeping = loadImage("data/sleep/eliza_sleep_288.png");
    }
  }

  //displays this habitat's background
  public void display() {
    image(this.background, 0, 0);
        displayAnimal();
  }

  //display the correct animal image
  void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, sleepingx, sleepingy);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //display the talking animal
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_ELEPHANT_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal 
  void displayAnimalNotTalking() {
    image(GIFS_ELEPHANT_TALKING[0], animalLeft, animalTop);
  }

  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if (cursorOverAnimal()) {
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
      playCurrentTalk();
    }
  }

  //play correct audio
  void playCurrentTalk() {
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    updateStateNumbers();
  }

  //updates state numbers 
  void updateStateNumbers() {
    if (USER == "GORILLA_A") {
      if (JUNGLE1_STATE == 1) {
        NAV.clue1 = true;// got fur clue
        JUNGLE1_STATE ++;
        ASIA2_STATE ++;
        HELP = 4;
      }
    }

    else if (USER == "GORILLA_B") {
    } //ELiza Elephant is asleep
    else if (USER == "COBRA_A") {
      if (JUNGLE1_STATE == 1) {
        JUNGLE1_STATE ++;
        ASIA1_STATE ++;
        NAV.clue4 = true;
        HELP = 3;//Tina Tiger
      }
    }
    else if (USER == "COBRA_B") {
    } //Elize Elephant is asleep
    else if (USER == "POLAR_A") {
      if (JUNGLE1_STATE == 0) {
        JUNGLE1_STATE ++;
        AFRICA1_STATE ++;
        HELP = 0;//Calvin Camel
      }
    }
    else if (USER == "POLAR_B") {
      if (JUNGLE1_STATE == 1) {
        JUNGLE1_STATE ++;
        FROSTY2_STATE ++;
        NAV.clue2 = true; //fur
        HELP = 6; //Sam Seal
      }
    }
  }

  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 200)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (JUNGLE1_STATE == 0) { 
        return ELEPHANT_DUMMY;
      }
      else if (JUNGLE1_STATE == 1) {

        println("got here");
        println("jungle state here" + JUNGLE1_STATE);
        return GA_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 2) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
    }//Eliza Elephant is sleeping
    else if (USER == "POLAR_A") {
      if (JUNGLE1_STATE == 0) {
        return PA_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 1) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      if (JUNGLE1_STATE == 0) {
        return ELEPHANT_DUMMY;
      }
      else if (JUNGLE1_STATE == 1) {
        return PB_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 2) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "COBRA_A") {
      if (JUNGLE1_STATE == 0) {
        return ELEPHANT_DUMMY;
      }
      else if (JUNGLE1_STATE == 1) {
        return CA_ELEPHANT1;
      }
      else if (JUNGLE1_STATE == 2) {
        return ELEPHANT_DUMMY;
      }
    }
    else if (USER == "COBRA_B") {
      //Eliza Elephant is asleep
    }
    return ELEPHANT_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}


// Stanley Sloth
class Jungle2 extends Habitat {
  int frame;
  int numTalkingFrames = 10;

  int animalLeft = 400;
  int animalTop = 40;


  PImage background = loadImage("data/jungle_2.png");

  PImage animal_sleeping;
  //did User pick up the trash
  boolean pickedUpTrash1;
  int trash1_x = 50;
  int trash1_y = 100;
  boolean pickedUpTrash2;
  int trash2_x = 150; 
  int trash2_y = 100;
  boolean pickedUpTrash3;
  int trash3_x = 250;
  int trash3_y = 100;

  int rockx = 800;
  int rocky = 100;

  //if POLAR_A
  boolean vines_cut = false;
  int vinex = 200; 
  int viney = 0;

  Jungle2(boolean isSleeping) {
    super(isSleeping, 400, 40);
    if (isSleeping || USER != "GORILLA_A") {
      this.pickedUpTrash1 = true;
      this.pickedUpTrash2 = true;
      this.pickedUpTrash3 = true;
    }
    if (!isSleeping) {
      this.pickedUpTrash1 = false;
      this.pickedUpTrash2 = false;
      this.pickedUpTrash3 = false;
    }
    if (isSleeping) {
      animal_sleeping = loadImage("data/sleep/stanley_sleep_288.png");
    }
  }

  //displays this habitat's background
  void display() {
    image(this.background, 0, 0);
    displayAnimal();

    if (USER == "GORILLA_A") {
      displayTrash();
    }
    else if (USER == "COBRA_B") {
      displayRock();
    }
    else if (USER == "POLAR_A") {
      displayVines();
    }
  }


  void displayVines() {
    if (vines_cut) {
      image(VINES_CUT_IMAGE, vinex, viney);
    }
    else {
      image(VINES_IMAGE, vinex, viney);
    }
  }
  //displays the trash
  //assume: not sleeping
  void displayTrash() {
    if (!pickedUpTrash1) {
      image(TRASH_IMAGE, trash1_x, trash1_y); //change
    }
    if (!pickedUpTrash2) {
      image(TRASH_IMAGE, trash2_x, trash2_y);
    }
    if (!pickedUpTrash3) {
      image(TRASH_IMAGE, trash3_x, trash3_y);
    }
  }

  //displayrock when necessary
  //assume on COBRA_B
  void displayRock() {
    image(ROCK_IMAGE, rockx, rocky);
  }

  //display the correct animal image
  void displayAnimal() {
    if (isSleeping) {
      image(animal_sleeping, sleepingx, sleepingy);
    }
    else if (ANIMAL_TALKING) {
      displayAnimalTalking();
    }
    else { 
      displayAnimalNotTalking();
    }
  }

  //display the talking animal
  void displayAnimalTalking() {
    frame = (frame+1) % numTalkingFrames;
    image(GIFS_SLOTH_TALKING[frame], animalLeft, animalTop);
  }

  //display the not talking animal 
  void displayAnimalNotTalking() {
    image(GIFS_SLOTH_TALKING[0], animalLeft, animalTop);
  }

  //decides which actions to take if mouse was pressed 
  //assume/know: animal is not talking
  void mousePressedInHabitat() {
    if (isSleeping) {
    }
    else if ((USER == "GORILLA_A") && (JUNGLE2_STATE == 2) && cursorOverTrash()) {
      if (cursorOverTrash1()) {
        pickedUpTrash1 = true;
      }
      else if (cursorOverTrash2()) {
        pickedUpTrash2 = true;
      }
      else if (cursorOverTrash3()) {
        pickedUpTrash3 = true;
      }
      
      if (pickedUpTrash1 && pickedUpTrash2 && pickedUpTrash3) {
        HAS_ITEM = true; //token         
        ASIA2_STATE ++; //Patty Panda
        HELP = 4;
      }
    }

    else if ((USER == "POLAR_A") && (JUNGLE2_STATE == 1) && cursorOverVines()) {
      vines_cut = true;
      JUNGLE2_STATE ++; 
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis();
      playCurrentTalk();
    }
    else if ((USER == "COBRA_B") && (JUNGLE2_STATE == 2) && cursorOverRock()) {
      rockx = rockx - 100; //move the rock
      JUNGLE2_STATE ++; //update state
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
      playCurrentTalk();
    }
    else if (cursorOverAnimal() && (JUNGLE2_STATE == 2) && USER == "GORILLA_B") {
      WIN.doGuess();
    }
    else if (cursorOverAnimal()) { 
      ANIMAL_TALKING = true;
      ANIMAL_TALKING_START_TIME = millis(); // saves time when pressed on animal
      playCurrentTalk();
    }
    else if (cursorOverTrash1() && (USER == "COBRA_B" )) {
      pickedUpTrash1 = true;
      JUNGLE2_STATE ++; // so Stanley Sloth will say next line
    }
  }

  //play correct audio
  void playCurrentTalk() {
    println(JUNGLE2_STATE);
    if (!this.isSleeping) {
      currentTalk().trigger();
      AUDIO_LENGTH = currentTalk().length();
    }
    updateStateNumbers();
  }

  void updateStateNumbers() {
    println("got to update statenumbers");
    println(USER == "GORILLA_B");
    if (USER == "GORILLA_A") {
      if (JUNGLE2_STATE == 1) {
        JUNGLE2_STATE ++;
        HELP = 9;
      } 
      if (JUNGLE2_STATE == 3) {
        JUNGLE2_STATE ++;
        AFRICA3_STATE ++;
        NAV.clue4 = true; //fur is black
        HELP = 2;
      }
    }
    else if (USER == "GORILLA_B") {
      if (JUNGLE2_STATE == 1) {
        JUNGLE2_STATE ++;
        //Finish
      }
    }
    else if (USER == "COBRA_A") {
    }
    else if (USER == "COBRA_B") {
      if (JUNGLE2_STATE == 1) { //stay same until pick up rock
        JUNGLE2_STATE ++;
        HELP = 10;
      }
      else if (JUNGLE2_STATE == 3) {
        JUNGLE2_STATE ++;
        ASIA2_STATE ++;
        NAV.clue3 = true;
        HELP = 4; //Patty Panda
      }
    }
    else if (USER == "POLAR_A") {
      if (JUNGLE2_STATE == 1) {
        NAV.clue4 = true;
        HELP = 12; //cut Stanley's vines
      }
      if (JUNGLE2_STATE == 2) {
        JUNGLE2_STATE ++;
        HELP = 1; //Gerry Giraffe
        AFRICA2_STATE ++;
      }
    }
    else if (USER == "POLAR_B") {
    }
  }

  //determines if cursor over any elements
  boolean cursorOverElement() {
    return cursorOverRock() || cursorOverTrash() || cursorOverVines();
  }

  //determines if the cursor is over the vines
  boolean cursorOverVines() {
    return (USER == "POLAR_A") && (JUNGLE2_STATE == 1) && 
      ((vinex < mouseX) && (mouseX < (vinex + 200))) 
      && ((viney < mouseY) && (mouseY < (viney + 540)));
  }
  //determines if cursor over the rock 
  //assume: it should be clicked on
  boolean cursorOverRock() {
    return (USER == "COBRA_B") && (JUNGLE2_STATE ==  2) &&
      ((rockx < mouseX) && (mouseX < (rockx + 60))) 
      && ((rocky < mouseY) && (mouseY < (rocky + 45)));
  }


  //determines if cursor over any of the trash
  boolean cursorOverTrash() {
    return (USER == "GORILLA_A") && !isSleeping && 
      ((!pickedUpTrash1 && cursorOverTrash1()) ||
      (!pickedUpTrash2 && cursorOverTrash2()) ||
      (!pickedUpTrash3 && cursorOverTrash3()));
  }


  //determines if mouse over trash1
  boolean cursorOverTrash1() {
    return ((trash1_x < mouseX) && (mouseX < (trash1_x + 100))) 
      && ((trash1_y < mouseY) && (mouseY < (trash1_y + 100)));
  }
  //determines if mouse over trash2
  boolean cursorOverTrash2() {
    return ((trash2_x < mouseX) && (mouseX < (trash2_x + 100))) 
      && ((trash2_y < mouseY) && (mouseY < (trash2_y + 100)));
  }
  //determines if mouse over trash3
  boolean cursorOverTrash3() {
    return ((trash3_x < mouseX) && (mouseX < (trash3_x + 100))) 
      && ((trash3_y < mouseY) && (mouseY < (trash3_y + 100)));
  }

  //determines if the mouse over the Camel
  boolean cursorOverAnimal() {
    if (isSleeping) {
      return ((sleepingx < mouseX) && (mouseX < (sleepingx + 200)))
        && ((sleepingy < mouseY) && (mouseY < (sleepingy + 200)));
    }
    else {
      return ((animalLeft < mouseX) && (mouseX < (animalLeft + 288)))
        && ((animalTop < mouseY) && (mouseY < (animalTop + 288)));
    }
  }

  //gets the current line the animal will be/is speaking
  AudioSample currentTalk() {
    if (USER == "GORILLA_A") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return GA_SLOTH1;
      }
      else if (JUNGLE2_STATE == 2) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 3) {
        return GA_SLOTH2;
      }
      else if (JUNGLE2_STATE == 4) {
        return SLOTH_DUMMY;
      }
    }
    else if (USER == "GORILLA_B") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return GB_SLOTH1;
      }
    }
    else if (USER == "POLAR_A") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return PA_SLOTH1;
      }
      else if (JUNGLE2_STATE == 2) {
        return PA_SLOTH2;
      }
      else if (JUNGLE2_STATE == 3) {
        return SLOTH_DUMMY;
      }
    }
    else if (USER == "POLAR_B") {
      //Stanley Sloth is asleep
    }
    else if (USER == "COBRA_A") {
      //Stanley Sloth is asleep
    }
    else if (USER == "COBRA_B") {
      if (JUNGLE2_STATE == 0) {
        return SLOTH_DUMMY;
      }
      else if (JUNGLE2_STATE == 1) {
        return CB_SLOTH1;
      }
      else if (JUNGLE2_STATE == 2) {
        return CB_SLOTH1;
      }
      else if (JUNGLE2_STATE == 3) {
        return CB_SLOTH2;
      }
      else if (JUNGLE2_STATE == 4) {
        return SLOTH_DUMMY;
      }
    }
    return SLOTH_DUMMY; //this is just so it doesn't yell at us for now, delete it later!
  }
}


// Map
class Map {
  PImage background;
  
  Map() {
    this.background = loadImage("data/map.png");
  }
  
  // display the scene
  void display() {
    image(background, 0, 0);
  }
}
    
  
// Nav
class Nav {

  PImage navbar;

  boolean clue1; //GA fur //GB //CA/ //CB //PA //PB
  boolean clue2; 
  boolean clue3;
  boolean clue4;

  int clue1xi = 55;
  int clue2xi = 209;
  int clue3xi = 366;
  int clue4xi = 522;
  int clueyi = 567;

  Nav() {
    this.navbar = loadImage("data/nav.png");
  }

  // display the scene
  void display() {
    image(navbar, 0, 0);
    if (clue1) {
      displayClue1();
    }
    if (clue2) {
      displayClue2();
    }
    if (clue3) {
      displayClue3();
    }
    if (clue4) {
      displayClue4();
    }
  }

  void displayClue1() {
    image(CLUE1, clue1xi, clueyi);
  }

  void displayClue2() {
    image(CLUE2, clue2xi, clueyi);
  }

  void displayClue3() {
    image(CLUE3, clue3xi, clueyi);
  }

  void displayClue4() {
    image(CLUE4, clue4xi, clueyi);
  }

  //determines if cursor should be over a clue
  boolean cursorOverClue() {
    return cursorOverClue1() || cursorOverClue2() || 
      cursorOverClue3() || cursorOverClue4();
  }

    boolean cursorOverClue1() {
      return (clue1 && cursorOver(clue1xi, clue1xi + 100, clueyi, clueyi+ 65));
      }
      boolean cursorOverClue2() {
        return (clue2 && cursorOver(clue2xi, clue2xi + 100, clueyi, clueyi+ 65));
      }
    boolean cursorOverClue3() {
      return (clue3 && cursorOver(clue3xi, clue3xi + 100, clueyi, clueyi+ 65));
    }
    boolean cursorOverClue4() {
      return clue4 && cursorOver(clue4xi, clue4xi + 100, clueyi, clueyi+ 65);
    }

    //decides what to do if mouse pressed on nav
    void mousePressedOnClue() {
      if (cursorOverClue1()) {
        CLUE1_AUDIO.trigger();
        AUDIO_LENGTH = CLUE1_AUDIO.length();
        CLUE_TALKING = true;
        CLUE_TALKING_START_TIME = millis();
      }
      else if (cursorOverClue2()) {
        CLUE2_AUDIO.trigger();        
        AUDIO_LENGTH = CLUE2_AUDIO.length();
        CLUE_TALKING = true;
        CLUE_TALKING_START_TIME = millis();
      }
      else if (cursorOverClue3()) {
        CLUE3_AUDIO.trigger();
        AUDIO_LENGTH = CLUE3_AUDIO.length();
        CLUE_TALKING = true;
        CLUE_TALKING_START_TIME = millis();
      }
      else if (cursorOverClue4()) {
        CLUE4_AUDIO.trigger();
        AUDIO_LENGTH = CLUE4_AUDIO.length();
        CLUE_TALKING = true;
        CLUE_TALKING_START_TIME = millis();
      }
    }
  }


