class Text {
  String start = """How to play:

  Click each circle, until they
    are all green, to gain a level.
    If you dont click all the
    circles before the timer runs
    out, you lose!
    Click anywhere to START!

    GOOD LUCK!
    """ ;
  String level = "" + currentLevel;
  int timer = 20;
  int duration = 20;
  int begin = millis();
  String tryAgain = "START";

//Empty constructor
  Text() {
  }

//Method that controls the timer and shows it.
  void timerCountdown() {
    if (gameStarted) {
      if (timer > 0) {
        timer = duration - (millis() - begin)/1000;
        textSize(50);
        text(timer, 620, 70);
      } else {
        timer = -1;
      }
    }
  }

  private int x = 275;
  private int y = 10;

//Method that makes the start box
  void startBox() {
    fill(255);
    stroke(0);
    rect(x, y, 190, 50);
  }

//Method to check if the mouse is over the START box
  boolean mouseOverBox() {
    float leftEdge = x;
    float rightEdge = x + 190;
    float topEdge = y;
    float bottomEdge = y + 50;

    if ((mouseX > leftEdge && mouseX < rightEdge && mouseY > topEdge && mouseY < bottomEdge)) {
      return true;
    } else {
      return false;
    }
  }
}
