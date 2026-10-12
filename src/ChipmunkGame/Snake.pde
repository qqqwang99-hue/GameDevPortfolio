class Snake {
  int x, y, w, h, speed, health;//,damage,xp;
  boolean isHit;
  PImage snake1;
  boolean moveLeft, moveRight, moveUp, moveDown;
  Snake(int x, int y) {
    this.x = x;
    this.y = y;
    snake1 = loadImage("enemy.png");
    health = 25;
    w = int(random(20, 100));
    h = int(random(20, 100));
    speed = int(random(1, 10));
    isHit = false;
  }
  void display() {
    imageMode(CENTER);
    image(snake1, x, y);
    textSize(24);
    textAlign(CENTER, CENTER);
    text(health, x, y);
  }
  void move(){
    y+=1;
  }
  boolean isOffScreen() {
    if (y>height+h/2) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
  }
  void relocate() {
  }
  boolean isHit(Projectile p){
    float distance = dist(p.x, p.y, x, y);
    return distance < 50;
  }
}
