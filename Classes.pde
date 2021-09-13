class WeekRect {
  String day;
  String dayPt2;
  String P1Class;
  String P2Class;
  boolean noSchool;
  int weekNum;
  public WeekRect(int dayOfYear) {
    cal.set(Calendar.DAY_OF_YEAR, dayOfYear);
    weekNum = getWeekNum(cal.get(Calendar.MONTH)+1, cal.get(Calendar.DAY_OF_MONTH), cal.get(Calendar.YEAR));
    if (week[cal.get(Calendar.DAY_OF_WEEK)].equals("Sunday") || week[cal.get(Calendar.DAY_OF_WEEK)].equals("Saturday")) {
      noSchool = true;
    } else if (paDay(cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH), cal.get(Calendar.YEAR))) {
      noSchool = true;
    }

    day = week[cal.get(Calendar.DAY_OF_WEEK)];
    dayPt2 = months[cal.get(Calendar.MONTH) + 1] + " " + cal.get(Calendar.DAY_OF_MONTH) + " " + cal.get(Calendar.YEAR);
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
      text("No School", 420, 125);
    } else {
      fill(colors[0], colors[1], colors[2], alpha);
      rect(10, 10, width-20, 180, 15*displayDensity, 15*displayDensity, 15*displayDensity, 15*displayDensity);
      fill(textColor[0], textColor[1], textColor[2], alpha);
      textAlign(LEFT);
      textFont(font, 50); //Setting Text Font
      text(day + "\n" + dayPt2, 20, 70);
      textFont(font, 60); //Setting Text Font
      text("P1: " + courses[weekNum][0], 420, 85);
      text("P2: " + courses[weekNum][1], 420, 165);
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
