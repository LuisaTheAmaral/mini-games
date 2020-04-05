//global variable that stores the information of the current active screen
int gameScreen = 0;
// 0: Initial Screen
// 1: Game Screen
// 2: Game-over Screen

float ballX, ballY;
int ballSize = 20;
int ballColor = color(0);
float ballSpeedHorizon = 10;
float gravity = 1;
float ballSpeedVert = 0;
float airfriction = 0.0001;
float friction = 0.1;
color racketColor = color(0);
float racketWidth = 100;
float racketHeight = 10;
int racketBounceRate = 20;
int score = 0;
int health = 100;
int healthDecrease = 10;
int maxHealth = 100;
int healthBarWidth = 60;


void setup() {
  size(500, 500);
  ballX=width/4;
  ballY=height/5;
}

void draw() {
  // Display the contents of the current screen
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  } else if (gameScreen == 2) {
    gameOverScreen();
  }
}

void initScreen() {
  background(0);
  textAlign(CENTER);
  text("Click to start", height/2, width/2);
}

void gameScreen() {
  background(234, 247, 255);
  drawRacket();
  watchRacketBounce();
  drawBall();
  applyHorizontalSpeed();
  applyGravity();
  keepInScreen();
  printScore();
  drawHealthBar();
}

void gameOverScreen() {
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text("Game Over", height/2, width/2 - 20);
  textSize(15);
  text("Click to Restart", height/2, width/2 + 10);
}

public void mousePressed() {
  // if we are on the initial screen when clicked, start the game
  if (gameScreen==0) {
    startGame();
  }
  if (gameScreen==2){
    restart();
  }
}

// This method sets the necessary variables to start the game  
void startGame() {
  gameScreen=1;
}

void drawBall() {
  fill(ballColor);
  ellipse(ballX, ballY, ballSize, ballSize);
}

void applyHorizontalSpeed(){
  ballX += ballSpeedHorizon;
  ballSpeedHorizon -= (ballSpeedHorizon * airfriction);
}
void makeBounceLeft(float surface){
  ballX = surface+(ballSize/2);
  ballSpeedHorizon*=-1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}
void makeBounceRight(float surface){
  ballX = surface-(ballSize/2);
  ballSpeedHorizon*=-1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}

void applyGravity() {
  ballSpeedVert += gravity;
  ballY += ballSpeedVert;
  ballSpeedVert -= (ballSpeedVert * airfriction);
}

void makeBounceBottom(float surface) {
  ballY = surface-(ballSize/2);
  ballSpeedVert*=-1;
  ballSpeedVert -= (ballSpeedVert * friction);
}

void makeBounceTop(float surface) {
  ballY = surface+(ballSize/2);
  ballSpeedVert*=-1;
  ballSpeedVert -= (ballSpeedVert * friction);
}

// keep ball in the screen
void keepInScreen() {
  // ball hits floor
  if (ballY+(ballSize/2) > height) { 
    makeBounceBottom(height);
    decreaseHealth();
  }
  // ball hits ceiling
  if (ballY-(ballSize/2) < 0) {
    makeBounceTop(0);
  }
  //ball hits right wall
  if (ballX-(ballSize/2) < 0){
    makeBounceLeft(0);
  }
  //ball hits left wall
  if (ballX+(ballSize/2) > width){
    makeBounceRight(width);
  }
}

void drawRacket(){
  fill(racketColor);
  rectMode(CENTER);
  rect(mouseX, mouseY, racketWidth, racketHeight,7);
}

void watchRacketBounce() {
  float overhead = mouseY - pmouseY;
  if ((ballX+(ballSize/2) > mouseX-(racketWidth/2)) && (ballX-(ballSize/2) < mouseX+(racketWidth/2))) {
    if (dist(ballX, ballY, ballX, mouseY)<=(ballSize/2)+abs(overhead)) {
      makeBounceBottom(mouseY);
      ballSpeedHorizon = (ballX - mouseX)/5; //hitting the edges gives more speed
      // racket moving up
      if (overhead<0) { 
        score++;
        ballY+=overhead;
        ballSpeedVert+=overhead; //the faster the racket hits the ball, the higher and faster it will move up
      }
    }
  }
}

void printScore(){
  textAlign(CENTER);
  fill(0);
  textSize(30); 
  text(score, height/2, 50);
}

void decreaseHealth(){
  health -= healthDecrease;
  healthBarWidth -= 6;
  if (health <= 0){
    gameOver();
  }
}

void gameOver() {
  gameScreen = 2;
}

void drawHealthBar() {
  noStroke();
  //fill(189, 195, 199);
  //rectMode(CORNER);
  //rect(ballX-(healthBarWidth/2), ballY - 30, healthBarWidth, 5);
  if (health > 60) {
    fill(46, 204, 113);
  } else if (health > 30) {
    fill(230, 126, 34);
  } else {
    fill(231, 76, 60);
  }
  rectMode(CORNER);
  rect(ballX-(healthBarWidth/2), ballY - 30, healthBarWidth, 5);
}

void restart() {
  score = 0;
  health = maxHealth;
  ballX=width/4;
  ballY=height/5;
  gameScreen = 1;
  healthBarWidth = 60;
}
