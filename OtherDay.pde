int periodOther, dayOfMonth;
char currentCohortOther;
boolean noSchoolOther;
String otherCalDate;
int weekNumOther;
void parseDate(String lineIn) {
  if (view == 0) {
    try {
      lineIn = lineIn.toUpperCase();
      if (lineIn.equals("TOMORROW")) {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, day()+1);
        dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
        String dayOfWeek = week[c.get(Calendar.DAY_OF_WEEK)];
        String month = months[c.get(Calendar.MONTH)+1];
        otherCalDate = dayOfWeek + " " + month + " " + c.get(Calendar.DAY_OF_MONTH) + " 2021";
        weekNumOther = getWeekNum(c.get(Calendar.MONTH) + 1, c.get(Calendar.DAY_OF_MONTH));
      } else if (lineIn.equals("TODAY")) {
        screenNumber = 0;
      } else {
        Calendar today = Calendar.getInstance();
        String[] split = split(lineIn, '/');
        Calendar c = Calendar.getInstance();
        c.set(Calendar.DAY_OF_MONTH, int(split[1]));
        c.set(Calendar.MONTH, int(split[0]) - 1);
        /*
        int ID = c.get(Calendar.DAY_OF_YEAR) - today.get(Calendar.DAY_OF_YEAR);
         getDataFromWeekView(ID);
         */
        weekNumOther = getWeekNum(c.get(Calendar.MONTH) + 1, c.get(Calendar.DAY_OF_MONTH));

        dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
        String dayOfWeek = week[c.get(Calendar.DAY_OF_WEEK)];
        String month = months[c.get(Calendar.MONTH) + 1];
        dayOfWeek = week[c.get(Calendar.DAY_OF_WEEK)];
        month = months[c.get(Calendar.MONTH) + 1];
        otherCalDate = dayOfWeek + " " + month + " " + c.get(Calendar.DAY_OF_MONTH) + " 2021";
      }
    }
    catch (Exception e) {
      warning();
      screenNumber = 0;
    }
  } else if (view == 1) {
    Calendar toView = Calendar.getInstance();
    int day = toView.get(Calendar.DAY_OF_YEAR);
    transScale = (-91.8651685*day)-(height*0.333333333) + height-720;
  }
}

void drawTimesOther() {
  parseDate(otherDay);
  pushMatrix();
  translate(0, 50);
  if (noSchoolOther) {
    text("No School today. Reason: " + reason, width/2, height/2-105); //Drawing Prayer times
  } else {
    text("P1: " + courses[getWeekNum()][0], width/2, height/2-105); //Drawing Prayer times
    text("P2: " + courses[getWeekNum()][1], width/2, height/2-52);
  }
  popMatrix();
}

boolean noSchoolOther(String weekDay, int day, int month) {
  if (weekDay == "Saturday" || weekDay == "Sunday") {
    reason = "Weekend";
    return true;
  } else if (paDayOther(day, month + 1)) {
    reason = "PA Day";
    return true;
  } else {
    return false;
  }
}
boolean paDayOther(int day, int month) {
  int[] months = {2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 6, 6};
  int[] days = {15, 2, 5, 12, 13, 14, 15, 16, 26, 27, 24, 28, 29};
  for (int i = 0; i < days.length; i++) { 
    if (day == days[i] && month == months[i]) {
      println(day, month);
      return true;
    }
  }
  return false;
}
