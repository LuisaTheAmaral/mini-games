int circleWidth = 50;
int circleHeight = 50;
float R, G, B;
float circleX, circleY;
float speedX, speedY;


// gets executed once when the program starts
public void setup() {
  
  // use the P2D rendering engine.
  size(800, 800); 
  width = 800;
  height = 800;
  circleX = random(0, 800- circleWidth/2);
  circleY = random(0, 800 - circleHeight/2);
  speedX = random(1, 10);
  speedY = random(1, 10);
}

// executed 60 times per second
public void draw() {
  background(0);
  drawCircle();
  move();
  detectCollision();
  
}

public void drawCircle() {
 fill(R, G, B);
 ellipse(circleX, circleY, circleWidth, circleHeight);
}

public void move() {
 circleX += speedX;
 circleY += speedY;
}

public void detectCollision() {
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

public void randColor() {
 R = random(0, 255);
 G = random(0, 255);
 B = random(0, 255);
}
