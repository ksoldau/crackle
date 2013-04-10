PImage img;
Intro intro;
Jungle1 jungle;

int WIDTH = 960;
int HEIGHT = 650;
// int HABITAT_HEIGHT = 540; 

//setup runs once
void setup() {
  background(255);
  size(WIDTH,HEIGHT);
  
  // load image that says "Zoo guess who click here to start"
  img = loadImage("data/fdsaf");// obvs a wrong link
  image(img, 0, 0);
  
  intro = new Intro();
}

// draw is called directly after setup
// called automatically, don't mess with it
void draw() {
}

void doIntro() {
  intro.display();
}

// if mouse is pressed, do this stuff 
void mousePressed() {
if (400 < mouseX && mouseX < 560 && 500 < mouseY && mouseY < 550 && mousePressed == true) {
  doIntro();
  }
}

  
  



