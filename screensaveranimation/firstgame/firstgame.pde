int x = 0;


// gets executed once when the program starts
public void setup() {
  // Size of our sketch will be 800x600, 
  // and use the P2D rendering engine.
  size(800, 600, P2D);
  
  // We could have used this function instead of size()
  // fullScreen(P2D);
  
  // The background color of our sketch will be black
  // by default, unless specified otherwise
  background(0);
  
  // We could have used this to set a background image.
  // Note that size of our sketch should be the same as the image.
  // background(loadImage("test.jpg"));
  
  // Shapes and objects will be filled with red by default,
  // unless specified otherwise.
  fill(255,0,0);
  
  // Shaped and objects will have a white border by default,
  // unless specified otherwise.
  stroke(255);
  
}

// executed 60 times per second
public void draw() {
  
  x += 1;
  print(x+" ");
  
}
