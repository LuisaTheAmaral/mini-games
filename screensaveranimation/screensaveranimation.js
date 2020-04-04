var circleWidth = 50;
var circleHeight = 50;
var R, G, B;
var circleX, circleY;
var speedX, speedY;


// gets executed once when the program starts
function setup() {
  
  // use the P2D rendering engine.
  createCanvas(1900, 900); 
  width = 1900;
  height = 900;
  circleX = random(0, width- circleWidth/2);
  circleY = random(0, height - circleHeight/2);
  speedX = random(1, 10);
  speedY = random(1, 10);
}

// executed 60 times per second
function draw() {
  background(0);
  drawCircle();
  move();
  detectCollision();
  
}

function drawCircle() {
 fill(R, G, B);
 ellipse(circleX, circleY, circleWidth, circleHeight);
}

function move() {
 circleX += speedX;
 circleY += speedY;
}

function detectCollision() {
  if(circleX + circleWidth/2 >= width ) {
    speedX*=-1;
    randColor();
  }
  if(circleX - circleWidth/2 <= 0) {
    speedX*=-1;
    randColor();
  }
  if(circleY + circleHeight/2 >= height) {
    speedY*=-1;
    randColor();
  }
  if(circleY - circleHeight/2 <= 0) {
    speedY*=-1;
    randColor();
    
  }
  
}

function randColor() {
 R = random(0, 255);
 G = random(0, 255);
 B = random(0, 255);
}