//global variable that stores the information of the current active screen
var gameScreen = 0;
// 0: Initial Screen
// 1: Game Screen
// 2: Game-over Screen

var ballX, ballY;
var ballSize = 20;
var ballSpeedHorizon = 10;
var gravity = 1;
var ballSpeedVert = 0;
var airfriction = 0.0001;
var friction = 0.1;

var racketWidth = 100;
var racketHeight = 10;
var racketBounceRate = 20;

var score = 0;
var health = 100;
var healthDecrease = 10;
var maxHealth = 100;
var healthBarWidth = 60;


function setup() {
  createCanvas(500, 500);
  ballX=width/4;
  ballY=height/5;
}

function draw() {
  // Display the contents of the current screen
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gamePlayScreen();
  } else if (gameScreen == 2) {
    gameOverScreen();
  }
}

function initScreen() {
  background(0);
  textAlign(CENTER);
  fill(255);
  text("Click to start", height/2, width/2);
}

function gamePlayScreen() {
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

function gameOverScreen() {
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text("Game Over", height/2, width/2 - 20);
  textSize(15);
  text("Click to Restart", height/2, width/2 + 10);
}

function mousePressed() {
  // if we are on the initial screen when clicked, start the game
  if (gameScreen==0) {
    startGame();
  }
  if (gameScreen==2){
    restart();
  }
}

// This method sets the necessary variables to start the game  
function startGame() {
  gameScreen=1;
}

function drawBall() {
  fill(0);
  ellipse(ballX, ballY, ballSize, ballSize);
}

function applyHorizontalSpeed(){
  ballX += ballSpeedHorizon;
  ballSpeedHorizon -= (ballSpeedHorizon * airfriction);
}
function makeBounceLeft(surface){
  ballX = surface+(ballSize/2);
  ballSpeedHorizon*=-1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}
function makeBounceRight(surface){
  ballX = surface-(ballSize/2);
  ballSpeedHorizon*=-1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}

function applyGravity() {
  ballSpeedVert += gravity;
  ballY += ballSpeedVert;
  ballSpeedVert -= (ballSpeedVert * airfriction);
}

function makeBounceBottom(surface) {
  ballY = surface-(ballSize/2);
  ballSpeedVert*=-1;
  ballSpeedVert -= (ballSpeedVert * friction);
}

function makeBounceTop(surface) {
  ballY = surface+(ballSize/2);
  ballSpeedVert*=-1;
  ballSpeedVert -= (ballSpeedVert * friction);
}

// keep ball in the screen
function keepInScreen() {
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

function drawRacket(){
  fill(0);
  rectMode(CENTER);
  rect(mouseX, mouseY, racketWidth, racketHeight,7);
}

function watchRacketBounce() {
  var overhead = mouseY - pmouseY;
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

function printScore(){
  textAlign(CENTER);
  fill(0);
  textSize(30); 
  text(score, height/2, 50);
}

function decreaseHealth(){
  health -= healthDecrease;
  healthBarWidth -= 6;
  if (health <= 0){
    gameOver();
  }
}

function gameOver() {
  gameScreen = 2;
}

function drawHealthBar() {
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

function restart() {
  score = 0;
  health = maxHealth;
  ballX=width/4;
  ballY=height/5;
  gameScreen = 1;
  healthBarWidth = 60;
}
