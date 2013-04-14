// Map
class Map {
  PImage background;
  
  Map() {
    this.background = loadImage("data/map.gif");
  }
  
  // display the scene
  void display() {
    image(background, 0, 0);
  }
}
    
  
