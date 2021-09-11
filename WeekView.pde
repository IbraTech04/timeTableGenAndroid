int toSubtract;
void mouseDragged() {    
  toSubtract = pmouseY-mouseY;
}

void mouseReleased() {
  toSubtract += (toSubtract)*1.2;
}
void weekView() {
  transScale -= toSubtract;
  if (toSubtract > 0) {
    if (toSubtract > 250) {
      toSubtract-=15;
    } else {
      toSubtract-=2.5;
    }
    if (toSubtract < 0) {
      toSubtract = 0;
    }
  } else if (toSubtract < 0) {
    if (toSubtract < -250) {
      toSubtract+=15;
    } else {
      toSubtract+=2.5;
    }
  }
  if (transScale > 250) {
    toSubtract -=7;
  }
  if (transScale > 150) {
    toSubtract -=5;
  }
  if (transScale > 0) {
    transScale = 0;
  } 
  if (transScale < (-200*daysLeft)-((height*0.102986612)*2) + height - 50) {
    transScale = (-200*daysLeft)-((height*0.102986612)*2) + height - 50;
    toSubtract = 0;
  } 
  background(backGroundColor[0], backGroundColor[1], backGroundColor[2], alpha);
  textAlign(CENTER);
  fill(colors[0], colors[1], colors[2], alpha);
  pushMatrix();
  translate(0, height*0.145833333);
  translate(0, transScale);
  for (int i = 0; i < daysLeft; i++) {
    rects.get(i).drawRect();
    translate(0, 200);
  }
  noStroke();
  popMatrix();
  fill(colors[0], colors[1], colors[2], alpha);
  rect(0, height -  height*0.102986612, width, height, 15*displayDensity, 15*displayDensity, 0, 0); //These two are the two rectangles on the top and bottom
  rect(0, 0, width, height*0.102986612, 0, 0, 15*displayDensity, 15*displayDensity);  
  imageMode(CENTER);
  image(settingsp[0], height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(calendar[0], width - height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(weekV, width/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  fill(textColor[0], textColor[1], textColor[2], alpha);
  textFont(font, 25*displayDensity); //Setting Text Font
  textAlign(CENTER);
  text("TMTimeTable WeekView\u2122 Beta", width/2, height*0.0494444444 + 25); //Top Text
}

void mouseWheel(MouseEvent event) {
  if (view == 1 && screenNumber == 0) {
    float e = event.getCount();
    transScale -= e*60;
    if (transScale > 0) {
      transScale = 0;
    }
  }
}
void initWeekView() {
  rects.clear();
  viewWeek.set(Calendar.MONTH, 5);
  viewWeek.set(Calendar.DAY_OF_MONTH, 29);
  viewWeek.set(Calendar.YEAR, 2022);
    int toAdd = 365;
  if (cal.get(Calendar.YEAR) == 2022){
     toAdd = 0;
  }
  daysLeft = ((viewWeek.get(Calendar.DAY_OF_YEAR) + toAdd) - cal.get(Calendar.DAY_OF_YEAR)) + 1;

  for (int i = cal.get(Calendar.DAY_OF_YEAR); i <= viewWeek.get(Calendar.DAY_OF_YEAR) + toAdd; i++) {
    Calendar temp = Calendar.getInstance();
    int year = 2021;
    int integer = i;
    if (i > 365){
       integer -= 365;
       temp.set(Calendar.YEAR, 2022);
       year = 2022;
    }
    temp.set(Calendar.DAY_OF_YEAR, integer);
    String arg = str(temp.get(Calendar.MONTH) + 1) + "/" + str(temp.get(Calendar.DAY_OF_MONTH));
    rects.add(new WeekRect(i));
  }
}

boolean noSchoolWeek(String weekDay, int day, int month) {
  if (weekDay == "Saturday" || weekDay == "Sunday") {
    reason = "Weekend";
    return true;
  } else if (paDayOther(day, month)) {
    reason = "PA Day";
    return true;
  } else {
    return false;
  }
}
