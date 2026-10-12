class Chipmunk {
  //member variables
  int x, y, size, health,turretCount;
  PImage chipmunk1;
  boolean moveLeft, moveRight, moveUp, moveDown;


  //Constructor
  Chipmunk (int x, int y) {
    this.x = x;
    this.y = y;
    size = 100;
    chipmunk1 = loadImage("player.png");
    health = 3;
    turretCount = 1;
  }
  //member methods
  void display() {
    imageMode(CENTER);
    image(chipmunk1, x, y, size, size);
  }
  void update() {
    if (moveLeft)  x -= 10;
    if (moveRight) x += 10;
    if (moveUp)    y -= 10;
    if (moveDown)  y += 10;
  }
  void move(boolean state) {
    if ( key == 'a')  moveLeft =state;
    if ( key == 'd') moveRight = state;
    if (key == 'w')    moveUp = state;
    if ( key == 's')  moveDown = state;
  }
  void stayOnScreen() {
    if (y < 0) {
      y=0;
    } else if (y>height) {
      y=height;
    } else if (x<0) {
      x=10;
    } else if (x>width) {
      x=width;
    }
  }
  boolean isHit(Snake s) {
    float distance = dist(s.x, s.y, x, y);
    return distance < size/2;
  }
}
