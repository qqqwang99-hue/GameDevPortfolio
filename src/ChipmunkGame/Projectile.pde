class Projectile {
  int x, y, size, speed;
  PImage acorn;
  Projectile(int x, int y, int speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    size = 50;
    acorn = loadImage("missile.png");
  }
  void move() {
    y-=speed;
  }
  void display() {
    imageMode(CENTER);
    image(acorn, x, y, size, size);
  }
  boolean isOffScreen() {
    if (y<-10) {
      return true;
    } else {
      return false;
    }
  }
}
