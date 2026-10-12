// Olivia Wang | 9/16/26 | ChipmunkGame
import gifAnimation.*;
import processing.sound.*;
SoundFile file;
SoundFile bgmusic;
SoundFile snakedie;
SoundFile gameover;
ArrayList<Snake> snakes = new ArrayList<Snake>();
ArrayList<PowerUp> powerups = new ArrayList<PowerUp>();
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
Chipmunk chipmunk1;
Boss boss1;
Timer sndist, pudist, bossfreq;
int score, snakeCount, snakesPassed, laserSpeed, level;
int highscore = 0;
boolean stop = false;
boolean startScreen = true;
boolean gameOverPlayed = false;
PImage start, background;
void setup() {
  size(800, 800);
  chipmunk1 = new Chipmunk(width/2, height/2);
  file = new SoundFile(this, "explosion.mp3");
  bgmusic = new SoundFile(this, "backgroundmusic.mp3");
  snakedie = new SoundFile(this, "snakedie.mp3");
  gameover = new SoundFile(this, "gameover.mp3");
  start = loadImage("Start_screen.png");
  background = loadImage("background.png");
  start.resize(width, height);
  sndist = new Timer(6000);
  pudist = new Timer(20000);
  sndist.start();
  pudist.start();
  bossfreq = new Timer(30000);
  bossfreq.start();
  laserSpeed = 4;
  score = 0;
  level=1;
  snakeCount = 0;
  snakesPassed = 0;
  if (!stop) {
    bgmusic.play();
  }
  String[] savedScore = loadStrings("highscore.txt");
  if (savedScore != null && savedScore.length > 0) {
    highscore = int(savedScore[0]); // Load the number back into the variable
  }
}

void draw () {
  if (startScreen) {
    background(start);
    textAlign(CENTER);
    textSize(24);
    text("Click the mouse to send a missile towards the falling snakes.", width/2, height/2 - 70);
    text("Grab stars to gain health.", width /2, height/2-8);
    text("Don't let more than 9 snakes get past you!", width/2, height/2-40);
    text("High Score: " + highscore, width/2, height/2+30);
    text("Press any key to start", width/2, height/2+70);
  } else {
    background.resize(width, height);
    background(background);
    if (!stop) {
      if (chipmunk1.health<=0 || snakesPassed >= 10) {
        stop = true;
      }
      //add snakes/enemy after timer done
      if (sndist.isFinished()) {
        sndist.start();
        snakes.add(new Snake(int(random(width)), 50));
        snakeCount++;
      }
      //add powerups after timer done
      if (pudist.isFinished()) {
        powerups.add(new PowerUp(int(random(width)), 60));
        pudist.start();
      }
      chipmunk1.display();
      chipmunk1.update();
      chipmunk1.stayOnScreen();

      //projectiles overlap with enemy loop
      for (int i = 0; i <projectiles.size(); i++) {
        Projectile pr = projectiles.get(i);
        pr.display();
        pr.move();
        if (pr.isOffScreen()) {
          projectiles.remove(pr);
        }
        for (int j=0; j<snakes.size(); j++) {
          Snake s = snakes.get(j);
          if (s.isHit(pr)) {
            s.health -= 1;
            projectiles.remove(pr);
            if (s.health <= 0) {
              score += 1;
              snakes.remove(s);
              snakedie.play();
              snakeCount--;
            }
          }
        }
      }
      //powerups overlap with player loop
      for (int i = 0; i <powerups.size(); i++) {
        PowerUp pu = powerups.get(i);
        pu.display();
        pu.move();
        if (pu.isOffScreen()) {
          powerups.remove(pu);
        }
        if (pu.isHit(chipmunk1)) {
          if (pu.type == 'h') {
            chipmunk1.health++;
            powerups.remove(pu);
          } else if (pu.type == 's') {
            laserSpeed++;
            powerups.remove(pu);
          } else {
            chipmunk1.turretCount++;
            powerups.remove(pu);
          }
        }
      }
      //enemy/snake loop for displaying and collision detection
      for (int i = 0; i < snakes.size(); i++) {
        Snake s = snakes.get(i);
        s.display();
        s.move();
        //isHit
        if (chipmunk1.isHit(s)) {
          snakes.remove(s);
          chipmunk1.health--;
          snakeCount--;
        }
        if (s.isOffScreen()) {
          snakes.remove(s);
          snakeCount--;
          snakesPassed++;
        }
      }
    } else {
      if (!gameOverPlayed) {
        bgmusic.stop();
        gameover.play();
        gameOverPlayed = true;
      }
      textSize(100);
      text("GAME OVER", 80, 200);
      textSize(35);
      fill(255);
      continueGame();
    }
    infoPanel();
  }
}
void keyPressed() {
  chipmunk1.move(true);
  if (startScreen) {
    startScreen = false;
  } else if (stop) {
    if (key == 'y' || key == 'Y') {
      if (score > highscore) {
        highscore = score;
        String[] scoreToSave = { String.valueOf(highscore) };
        saveStrings("data/highscore.txt", scoreToSave); // Saves to your sketch folder
      }
      stop = false;
      gameOverPlayed = false;
      score = 0;
      snakeCount = 0;
      snakesPassed = 0;
      snakes.clear();
      projectiles.clear();
      powerups.clear();
      chipmunk1.health = 3;
      bgmusic.loop();
    } else if (key == 'n' || key == 'N') {
      exit();
    }
  } else {
    chipmunk1.move(true);
  }
}
void keyReleased() {
  chipmunk1.move(false);
}
void mousePressed() {
  if (chipmunk1.turretCount == 1) {
    projectiles.add(new Projectile(chipmunk1.x, chipmunk1.y, laserSpeed));
    if (!file.isPlaying()) {
      file.play();
    }
  } else if (chipmunk1.turretCount == 2) {
    projectiles.add(new Projectile(chipmunk1.x-30, chipmunk1.y, laserSpeed));
    projectiles.add(new Projectile(chipmunk1.x+30, chipmunk1.y, laserSpeed));
  } else if (chipmunk1.turretCount == 3) {
    projectiles.add(new Projectile(chipmunk1.x-30, chipmunk1.y, laserSpeed));
    projectiles.add(new Projectile(chipmunk1.x+30, chipmunk1.y, laserSpeed));
    projectiles.add(new Projectile(chipmunk1.x, chipmunk1.y, laserSpeed));
  }
}
void infoPanel() {
  fill(127, 127);
  rectMode(CORNER);
  rect(0, 0, width, 40);
  fill(255);
  textSize(24);
  textAlign(CORNER, CORNER);
  text("Score: " + score, 20, 35);
  text("Snake Count: " + snakeCount, 130, 35);
  text("Health: " + chipmunk1.health, 300, 35);
  text("Snakes Passed: " + snakesPassed, 410, 35);
}
void continueGame() {
  textSize(35);
  text("Final score: " + score, 40, 380);
  text("High Score: " + highscore, 80, 300);
  text("Press y to play again", 40, 500);
  text("and n to exit", 40, 560);
}
