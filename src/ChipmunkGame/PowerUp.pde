

class PowerUp {
  int x, y, size, speed, health;//,damage,xp;
  char type;
  boolean isHit;
  PImage pu1;

  PowerUp(int x, int y) {
    this.x = x;
    this.y = y;
    pu1 = loadImage("powerup.png");
    size = int(random(20, 100));
    speed = int(random(1, 10));
    isHit = false;
    if (random(3)>2.0){
      type = 'h';
    } else if (random(2) > 1.0){
      type = 't';
    } else {
      type = 's';
    }
  }
  void display() {
    imageMode(CENTER);
    image(pu1, x, y);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(type, x, y);
  }
  void move() {
    y +=1 ;
  }
  void update() {
  }
  void reset() {
  }
  void relocate() {
  }
  boolean isOffScreen() {
    if (y>height+size/2) {
      return true;
    } else {
      return false;
    }
  }
  boolean isHit(Chipmunk c) {
    float distance = dist(c.x, c.y, x, y);
    return distance < size/2;
  }
}
