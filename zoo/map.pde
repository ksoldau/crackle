// Map
class Map {
  PImage background;
  
  Map() {
    this.background = loadImage("data/map.gif");
  }
  
  // display the scene
  void display() {
    img = this.background;
    image(img, 0, 0);
  }
}
    
  
