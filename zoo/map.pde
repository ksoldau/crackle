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
    
  
