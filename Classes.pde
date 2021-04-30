class WeekRect {
  String day;
  String dayPt2;
  String P1Class;
  String P2Class;
  boolean noSchool;
  public WeekRect(String[] args) {
    day = args[0];
    dayPt2 = args[1];
    if (args[2].equals("true")) {
      noSchool = true;
    } else {
      noSchool = false;
    }
    if (cohort == 'A') {
      if (args[3].equals("A1")) {
        P1Class = p1Class + " In School";
        P2Class = p2Class + " At Home";
      } else if (args[3].equals("A2")) {
        P1Class = p2Class + " In School";
        P2Class = p1Class + " At Home";
      } else if (args[3].equals("B1")) {
        P1Class = p1Class + " At Home";
        P2Class = p2Class + " At Home";
      } else if (args[3].equals("B2")) {
        P1Class = p2Class + " At Home";
        P2Class = p1Class + " At Home";
      }
    } else if (cohort == 'B') {
      if (args[3].equals("A1")) {
        P1Class = p1Class + " At Home";
        P2Class = p2Class + " At Home";
      } else if (args[3].equals("A2")) {
        P1Class = p2Class + " At Home";
        P2Class = p1Class + " At Home";
      } else if (args[3].equals("B1")) {
        P1Class = p1Class + " In School";
        P2Class = p2Class + " At Home";
      } else if (args[3].equals("B2")) {
        P1Class = p2Class + " In School";
        P2Class = p1Class + " At Home";
      }
    } else {
      if (args[3].equals("A1")) {
        P1Class = p1Class + " At Home";
        P2Class = p2Class + " At Home";
      } else if (args[3].equals("A2")) {
        P1Class = p2Class + " At Home";
        P2Class = p1Class + " At Home";
      } else if (args[3].equals("B1")) {
        P1Class = p1Class + " At Home";
        P2Class = p2Class + " At Home";
      } else if (args[3].equals("B2")) {
        P1Class = p2Class + " At Home";
        P2Class = p1Class + " At Home";
      }
    }
  }

  public void drawRect() {
    if (noSchool) {
      fill(colors[0], colors[1], colors[2], alpha);
      rect(10, 10, width-20, 180, 15*displayDensity, 15*displayDensity, 15*displayDensity, 15*displayDensity);
      fill(textColor[0], textColor[1], textColor[2], alpha);
      textAlign(LEFT);
      textSize(50);
      text(day + "\n" + dayPt2, 20, 70);
      textSize(70);
      text("No School", 335, 125);
    } else {
      fill(colors[0], colors[1], colors[2], alpha);
      rect(10, 10, width-20, 180, 15*displayDensity, 15*displayDensity, 15*displayDensity, 15*displayDensity);
      fill(textColor[0], textColor[1], textColor[2], alpha);
      textAlign(LEFT);
      textFont(font, 50); //Setting Text Font
      text(day + "\n" + dayPt2, 20, 70);
      textFont(font, 60); //Setting Text Font
      text("P1: " + P1Class, 335, 85);
      text("P2: " + P2Class, 335, 165);
    }
  }
}

public class ClickableText {
  String text;
  int textPosX;
  int textPosY;
  int textSize;
  boolean isCenter = false;
  public boolean isPressed() {
    if (isCenter) {
      if (mouseX >= textPosX - ((text.length())*textSize/2)/2 && mouseX <= textPosX + ((text.length())*textSize/2)/2 && mouseY >= textPosY-textSize && mouseY <= textPosY) {
        println("here");
        return true;
      }
      return false;
    } else {
      if (mouseX >= textPosX && mouseX <= (text.length())*textSize/2 && mouseY >= textPosY-textSize && mouseY <= textPosY) {
        return true;
      } else {
        return false;
      }
    }
  }
  public void drawText() {
    if (isCenter) {
      textAlign(CENTER);
    } else {
      textAlign(LEFT);
    }
    text(text, textPosX, textPosY);
  }
  public void setText(String tempText) {
    text = tempText;
  }
  public void setSize(int size) {
    textSize = size;
  }
  public void setPos(int x, int y) {
    textPosX = x;
    textPosY = y;
  }

  public void setMode(String mode) {
    if (mode.toUpperCase().equals("CENTER")) {
      isCenter = true;
    } else {
      isCenter = false;
    }
  }
  public int getTextSize() {
    return textSize;
  }
  public int getTextX() {
    return textPosX;
  }
  public int getTextY() {
    return textPosY;
  }
  public String getText() {
    return text;
  }
}
