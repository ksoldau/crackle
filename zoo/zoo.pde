PImage img;

void setup() {
  background(255);
  size(960,650);
  
  // load image that says "Zoo guess who click here to start"
  img = loadImage("data/frosty_1.png");
  image(img, 0, 0);
}
