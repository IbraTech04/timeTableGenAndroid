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
      rect(10, 10, width-20, 180, 10, 10, 10, 10);
      fill(textColor[0], textColor[1], textColor[2], alpha);
      textAlign(LEFT);
      textSize(50);
      text(day + "\n" + dayPt2, 20, 70);
      textSize(70);
      text("No School", 335, 125);
    } else {
      fill(colors[0], colors[1], colors[2], alpha);
      rect(10, 10, width-20, 180, 10, 10, 10, 10);
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
