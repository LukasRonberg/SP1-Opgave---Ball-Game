class Ball {
  //Data
  float x;
  float y;
  float size;
  float vx;
  float vy;
  float r;
  int colour;
  boolean isClicked = false;

  //Constructor
  Ball(float x, float y, float size, int colour, int startSpeed) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.colour = colour;
    int speed = startSpeed;
    vx = random(-1, 1) * speed;
    vy = random(-1, 1) * speed;
  }

  //Methods
  //Displays the ball
  void display() {
    stroke(0);
    fill(colour);
    ellipse(x, y, size, size);
  }

  //Method that makes the ball move, checks if the ball has hit an edge and makes it move in a random direction if it has.
  void update() {
    x += vx;
    y += vy;

    if (y - size / 2 < 0) {
      y = size / 2;  
      vy = abs(vy);  
    }
    if (y + size / 2 > height) {
      y = height - size / 2;  
      vy= -abs(vy);  
    }
    if (x - size / 2 < 0) {
      x = size / 2; 
      vx = abs(vx); 
    }
    if (x + size / 2 > width) {
      x = width - size / 2; 
      vx= -abs(vx);
    }
    
    x = x + vx;
    y = y + vy;
    if (y < 120) {
      vy = vy * -1;
    }
  }

  //Method to check if the mouse is on the ball, when it is pressed
  boolean mouseOver() {
    if ((mouseX > x - size && mouseX < x + size && mouseY > y - size && mouseY < y + size)) {
      return true;
    } else {
      return false;
    }
  }
  
  //Method that is used to spawn the new balls.
  void ballSpawn() {
    ball.add(new Ball(random(width), random(120, 800), 40, color(255, 0, 0), 1));
  }
  
  //Method that checks if the ball is clicked
  void click() {
    if (!isClicked) {
      colour = color(0, 255, 0);
      this.isClicked = true;
    } else {
    }
  }
}
