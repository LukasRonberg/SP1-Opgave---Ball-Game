ArrayList<Ball> ball = new ArrayList<Ball>(); //<>// //<>//

Text txt = new Text();

int currentLevel;
int highscore;
boolean gameOver = false;
boolean timerCover = false;
boolean ballSpawned = false;
boolean gameStarted = false;
boolean firstPress = false;
boolean opDone = false;

void setup() {
  size(700, 800);
  background(255);
  smooth();
  cursor(CROSS);
}


void draw() {
  background(255);
  fill(60);
  line(0, 100, 800, 100);
  if (gameStarted) {
    levelChanger();
    txt.timerCountdown();
    txt.start = txt.level;
    txt.level = "Level " + Integer.toString(currentLevel);
    textSize(50);
    text(txt.start, 20, 70);
    text(txt.timer, 620, 70);
  } else {
    textSize(50);
    text(txt.start, 20, 70);
  }

  if (txt.timer == 0) {
    println("high: " + highscore);
    println("current: " + currentLevel);
    if (currentLevel >= highscore) {
      highscore = currentLevel;
    }

    gameOver = true;
    ball.clear();
  }
  if (gameOver) {
    timerCover = true;
    text("Game over!\n\nClick 'START' to try again!\n\nHighscore: Level " + highscore, 80, 200);
    txt.startBox();

    fill(0);
    textSize(60);
    text("START", 290, 55);
  } else {
    timerCover = false;
    for (int i = 0; i < ball.size(); i++) {
      ball.get(i).display();
      ball.get(i).update();
    }
  }

  if (timerCover) {
    fill(255);
    noStroke();
    rect(600, 18, 80, 80);
  }
}

//Method that runs, after the mouse has been pressed
void mouseReleased() {
  int counter = 0;

  for (int i = 0; i < ball.size(); i++) {
    if (ball.get(i).mouseOver() && !ball.get(i).isClicked) {
      ball.get(i).click();
      counter = 0;
      for (int j = 0; j < ball.size(); j++) {
        if (ball.get(j).isClicked) counter++;
        if (counter == ball.size()) {
          for (int g = 0; g < ball.size(); g++) {
            ball.get(g).isClicked = false;
            ball.get(g).colour = color(255, 0, 0);
          }
          currentLevel++;
          println(currentLevel);
          txt = new Text();
          txt.begin = millis();
          ball.get(i).ballSpawn();
        }
      }
    }
  }
}



//Method that checks if the game is over, resets the game if it is and starts it again
void mousePressed() {
  if (!firstPress) {
    gameStarted = true;
    firstPress = true;
    txt.begin = millis();
  }
  if (gameOver && txt.mouseOverBox()) {
    resetGame();
    ball.add(new Ball(random(width), random(120, 800), 40, color(255, 0, 0), 1));
  } else {
    gameStarted = true;
    if (!ballSpawned) {
      ball.add(new Ball(random(width), random(120, 800), 40, color(255, 0, 0), 1));
      ballSpawned = true;
    }
  }
}

//Method that resets the game
void resetGame() {
  gameOver = false;
  currentLevel = 0;
  txt = new Text();
  ball.clear();
}

//Method that tracks the highscore
void highscoreFunction() {
  if (currentLevel >= highscore) {
    highscore = currentLevel;
  }
}

//Method that changes what happens at different levels
void levelChanger() {
  switch(currentLevel) {
  case 0:
  case 1:
  case 2:
  case 3:
  case 4:
    for (int i = 0; i < ball.size(); i++) {
      ball.get(i).size = 100;
    }
    break;
  case 5:
    if (!opDone) {
      opDone = true;
      ball.clear();
      ball.add(new Ball(random(width), random(120, 800), 80, color(255, 0, 0), 1));
    }
    break;
  case 6:
  case 7:
  case 8:
  case 9:
    for (int i = 0; i < ball.size(); i++) {
      ball.get(i).size = 80;
    }
    opDone = false;
    break;
  case 10:
    textSize(70);
    text("BALL RUSH!!!", 215, 70);
    if (!opDone) {
      opDone = true;
      ballRush(10, 80);
    }
    break;
  case 11:
    if (opDone) {
      opDone = false;
      ball.clear();
      ball.add(new Ball(random(width), random(120, 800), 80, color(255, 0, 0), 1));
    }
  case 12:
  case 13:
  case 14:
  case 15:
    for (int i = 0; i < ball.size(); i++) {
      ball.get(i).size = 60;
    }
    opDone = false;
    break;
  case 16:
    if (!opDone) {
      opDone = true;
      ball.clear();
      ball.add(new Ball(random(width), random(120, 800), 60, color(255, 0, 0), 1));
    }
    break;
  case 17:
  case 18:
  case 19:
    for (int i = 0; i < ball.size(); i++) {
      ball.get(i).size = 60;
    }
    break;
  case 20:
    if (opDone) {
      opDone = false;
      fastBalls(5, 10);
    }
    break;
  case 21:
    if (!opDone) {
      opDone = true;
      ball.clear();
      for (int i = 0; i < 5; i++) {
        ball.add(new Ball(random(width), random(120, 800), 40, color(255, 0, 0), 1));
      }
    }
    break;
  case 22:
  case 23:
  case 24:
    break;
  case 25:
    textSize(70);
    text("BALL RUSH!!!", 215, 70);
    if (opDone) {
      opDone = false;
      ballRush(5, 30);
    }
    break;
  case 26:
    if (!opDone) {
      opDone = true;
      ball.clear();
      for (int i = 0; i < 5; i++) {
        ball.add(new Ball(random(width), random(120, 800), 40, color(255, 0, 0), 1));
      }
    }
    break;
  } // SWITCH Bracket



  if (currentLevel > 26) {
    for (int i = 0; i < ball.size(); i++) {
      ball.get(i).size = 40;
    }
  }
} //levelChanger bracket


//Method that controls the fast balls event
void fastBalls(int amount, int speed) {
  textSize(70);
  text("FAST BALLS!!", 215, 70);
  ball.clear();
  for (int i = 0; i < amount; i++) {
    ball.add(new Ball(random(width), random(120, 800), 80, color(255, 0, 0), speed));
  }
}

//Method that controls the ball rush event
void ballRush(int amount, int size) {
  for (int i = 0; i < amount; i++) {
    ball.add(new Ball(random(width), random(120, 800), 80, color(255, 0, 0), 1));
  }
  for (int i = 0; i < ball.size(); i++) {
    ball.get(i).size = size;
  }
}
