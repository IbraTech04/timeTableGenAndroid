import java.util.Calendar; //Import Calendar Functions
Calendar cal = Calendar.getInstance(); //Get calendar date
import android.content.DialogInterface;
import android.app.Activity;
import android.app.AlertDialog;
import android.text.Editable;
import android.widget.EditText;
Activity act;

String[] week = {"", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}, months = {"", "January", "February", "March", "April", "May", "June", "July", "Auguest", "September", "October", "November", "December"};
int date = cal.get(Calendar.DAY_OF_WEEK), wed = cal.get(Calendar.WEEK_OF_MONTH), period, state = 0;
String dayOfWeek = week[date], p1Class = "", p2Class = "", monthString = months[month()] + year();
boolean p1Online = true, p2Online = false, warningShown = false;
char cohort, currentCohort;
String[] wedDates, pref;
PFont font;
String Theme = "", cScheme = "", reason = "";
boolean isSetUp = true, customTheme;
PImage[] homep = new PImage[2], settingsp = new PImage[2], calendar = new PImage[2];
int picCol = 255, colToBe = 255;

int shiftRegister = 0, screenNumber = 0;
boolean isOpen1 = false, isOpen2 = false, isRemindedOfAd = false;
String calDate = week[date] + " " + months[month()] + " " + day() + " " + year();
String otherDay;
float alpha = 0;

void setup() {
  background(0);
  fullScreen();
  homep[0] = loadImage("HomeL.png");
  settingsp[0] = loadImage("SettingsL.png");
  calendar[0] = loadImage("calL.png");
  smooth();
  noStroke();
  font = createFont("Product Sans Bold.ttf", 100); //Load the font
  wedDates = loadStrings("Wed1.txt");
  try {
    pref = loadStrings("pref.txt");
    loadData();
  }
  catch (Exception e) {
    isSetUp = false;
    backGroundColor[0] = 0;
    backGroundColor[1] = 0;
    backGroundColor[2] = 0;
    textColor[0] = 255;
    textColor[1] = 255;
    textColor[2] = 255;
    newBG[0] = 0;
    newBG[1] = 0;
    newBG[2] = 0;
    newText[0] = 255;
    newText[1] = 255;
    newText[2] = 255;
    colors[0] = 66;
    colors[1] = 135;
    colors[2] = 245;
    newColors[0] = 66;
    newColors[1] = 135;
    newColors[2] = 245;
    Theme = "Dark";
    cScheme = "Blue";
  }
  calculateClasses();
  checkForUpdates();
}

void draw() {
  tint(picCol, alpha);
  colorShift(newColors[0], newColors[1], newColors[2]);
  colorShiftBG(newBG[0], newBG[1], newBG[2]);
  colorShiftText(newText[0], newText[1], newText[2]);
  colorShiftImg(colToBe);
  sizeDeteccLegacy();
  calculateClasses();
  if (isSetUp) {
    if (screenNumber == 0) {
      if (alpha <= 255) {
        alpha+=17;
      }
      mainScreen();
    } else if (screenNumber == 1) {
      background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
      fill(colors[0], colors[1], colors[2]);
      rect(0, height -  height*0.102986612, width, height); //These two are the two rectangles on the top and bottom
      rect(0, 0, width, height*0.102986612);
      guiSettings();
    } else {
      background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
      fill(colors[0], colors[1], colors[2]);
      rect(0, height -  height*0.102986612, width, height); //These two are the two rectangles on the top and bottom
      rect(0, 0, width, height*0.102986612);
      image(homep[ishift], height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
      image(calendar[ishift], width - height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
      fill(textColor[0], textColor[1], textColor[2]);
      textFont(font, 25*displayDensity); //Setting Text Font
      text("TMTimeTable Custom Date Entry", width/2, height*0.0494444444 + 25); //Top Text
      textFont(font, 20*displayDensity); //Setting Text Font
      text("Your Schedule for entered date:", width/2, height/2-200);
      text(otherCalDate + " (Day " + periodOther + ")", width/2, height/2-130);
      drawTimesOther();
    }
  } else {
    if (state != 3) {
      if (alpha < 255) {
        alpha+=17;
      }
    }
    background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
    fill(colors[0], colors[1], colors[2], alpha);
    rect(0, height -  height*0.102986612, width, height); //These two are the two rectangles on the top and bottom
    rect(0, 0, width, height*0.102986612);
    textAlign(CENTER);
    fill(textColor[0], textColor[1], textColor[2], alpha);
    textFont(font, 25*displayDensity); //Setting Text Font

    text("TMTimeTable First Time Setup", width/2, height*0.0494444444 + 25); //Top Text
    if (state == 0) {
      text("Type your cohort (A, B, or C)", width/2, height/2-225);
    } else if (state == 1) {
      text("First Period Class?", width/2, height/2-225);
      if (!isOpen1) {
        dialogBoxP1();
        isOpen1 = true;
      }
    } else if (state == 2) {
      if (!isOpen2) {
        dialogBoxP2();
        isOpen2 = true;
      }
    } else if (state == 3) {
      alpha-= 15;
      if (alpha <= 0) {
        isSetUp = true;
      }
    }
  }
}


void keyPressed() {
  if (!isSetUp) {
    if (state == 0) {
      if (str(key).toUpperCase().equals("A") || str(key).toUpperCase().equals("B") || str(key).toUpperCase().equals("C")) {
        String temp = str(key).toUpperCase();
        cohort = temp.charAt(0);
        state++;
      }
    } else if (state == 1) {
      /*if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22 && keyCode!=86) {
       p1Class +=key;
       } else  if (keyCode == 67) {
       p1Class = p1Class.substring(0, max(0, p1Class.length() - 1));
       } else if (key == ENTER) {
       state++;
       }*/
    } else if (state == 2) {
      /* if (key != ENTER && key != CODED && key != '`' && key != BACKSPACE && key != 22 && keyCode!=86) {
       p2Class +=key;
       } else  if (keyCode == 67) {
       p2Class = p2Class.substring(0, max(0, p2Class.length() - 1));
       } else if (key == ENTER) {
       isSetUp = true;
       writeData();
       }
       */
    }
  } else {
    if (screenNumber == 1) {
      if (key == 'f' || key == 'F') {
        colors[0] = 66;
        colors[1] = 135;
        colors[2] = 245;
        textColor[0] = 255;
        textColor[1] = 255;
        textColor[2] = 255;
        backGroundColor[0] = 0;
        backGroundColor[1] = 0;
        backGroundColor[2] = 0;
        state = 0;
        p1Class = "";
        p2Class = "";
        isSetUp = false;
        setup();
      }
    }
  }
}

void drawTimes() {
  translate(0, 50);
  if (noSchool()) {
    text("No School today. Reason: " + reason, width/2, height/2-105); //Drawing Prayer times
  } else {
    if (currentCohort == 'A' && period == 1 && cohort == 'A') {
      if (!warningShown && hour() <= 9) {
        remind();
        warningShown = true;
      }
      text("P1: " + p1Class + " In Class", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p2Class + " At home", width/2, height/2-45);
    } else if (currentCohort == 'B' && period == 1 && cohort == 'A') {
      text("P1: " + p1Class + " At Home", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p2Class + " At home", width/2, height/2-45);
    } else if (currentCohort == 'A' && period == 2 && cohort == 'A') {
      if (!warningShown && hour() <= 9) {
        remind();
        warningShown = true;
      }
      text("P1: " + p2Class + " In Class", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p1Class + " At home", width/2, height/2-45);
    } else if (currentCohort == 'B' && period == 2 && cohort == 'A') {
      text("P1: " + p2Class + " At Home", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p1Class + " At home", width/2, height/2-45);
    } else if (currentCohort == 'A' && period == 1 && cohort == 'B') {
      text("P1: " + p1Class + " At Home", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p2Class + " At home", width/2, height/2-45);
    } else if (currentCohort == 'B' && period == 1 && cohort == 'B') {
      if (!warningShown && hour() <= 9) {
        remind();
        warningShown = true;
      }
      text("P1: " + p1Class + " In Class", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p2Class + " At home", width/2, height/2-45);
    } else if (currentCohort == 'A' && period == 2 && cohort == 'B') {
      text("P1: " + p2Class + " At Home", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p1Class + " At home", width/2, height/2-45);
    } else if (currentCohort == 'B' && period == 2 && cohort == 'B') {
      if (!warningShown && hour() <= 9) {
        remind();
        warningShown = true;
      }
      text("P1: " + p2Class + " In Class", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p1Class + " At home", width/2, height/2-45);
    } else   if (currentCohort == 'A' && period == 1 && cohort == 'C') {
      text("P1: " + p1Class + " At Home", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p2Class + " At home", width/2, height/2-45);
    } else if (currentCohort == 'B' && period == 1 && cohort == 'C') {
      text("P1: " + p1Class + " At Home", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p2Class + " At home", width/2, height/2-45);
    } else if (currentCohort == 'A' && period == 2 && cohort == 'C') {
      text("P1: " + p2Class + " At Home", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p1Class + " At home", width/2, height/2-45);
    } else if (currentCohort == 'B' && period == 2 && cohort == 'C') {
      text("P1: " + p2Class + " At Home", width/2, height/2-105); //Drawing Prayer times
      text("P2: " + p1Class + " At home", width/2, height/2-45);
    }
  }
}
void calculateClasses() {
  if (dayOfWeek.equals("Monday")) {
    currentCohort = 'A';
    period = 1;
  } else if (dayOfWeek.equals("Tuesday")) {
    currentCohort = 'A';
    period = 2;
  } else if (dayOfWeek.equals("Thursday")) {
    currentCohort = 'B';
    period = 1;
  } else if (dayOfWeek.equals("Friday")) {
    currentCohort = 'B';
    period = 2;
  } else {
    checkWed();
  }
}
void checkWed() {
  for (int i = 0; i < wedDates.length; i++) { //Until you find the entry with todays date continue the loop
    String temp = wedDates[i];
    if (temp.equals(monthString)) {
      loadWed(i);
      break;
    }
  }
}

void loadWed(int i) {
  for (int j = i; j < wedDates.length; j++) { //Until you find the entry with todays date continue the loop
    String temp = wedDates[j];
    if (temp.equals(str(day()))) {
      if (wedDates[j+1].equals("A1")) {
        currentCohort = 'A';
        period = 1;
      } else if (wedDates[j+1].equals("B1")) {
        currentCohort = 'B';
        period = 1;
      } else if (wedDates[j+1].equals("A2")) {
        currentCohort = 'A';
        period = 2;
      } else if (wedDates[j+1].equals("B2")) {
        currentCohort = 'B';
        period = 2;
      }
      break;
    }
  }
}

void loadData() {
  String[] temp = (split(pref[0], ':'));
  cohort = temp[1].charAt(0);
  p1Class = split(pref[1], ':')[1];
  p2Class = split(pref[2], ':')[1];
  Theme = split(pref[3], ':')[1];
  cScheme = split(pref[4], ':')[1];
  if (Theme.equals("Dark")) {
    backGroundColor[0] = 0;
    backGroundColor[1] = 0;
    backGroundColor[2] = 0;
    textColor[0] = 255;
    textColor[1] = 255;
    textColor[2] = 255;
    newBG[0] = 0;
    newBG[1] = 0;
    newBG[2] = 0;
    newText[0] = 255;
    newText[1] = 255;
    newText[2] = 255;
    colToBe = 255;
    picCol = 255;
  } else if (Theme.equals("Light")) {
    backGroundColor[0] = 255;
    backGroundColor[1] = 255;
    backGroundColor[2] = 255;
    textColor[0] = 0;
    textColor[1] = 0;
    textColor[2] = 0;
    newBG[0] = 255;
    newBG[1] = 255;
    newBG[2] = 255;
    newText[0] = 0;
    newText[1] = 0;
    newText[2] = 0;
    colToBe = 0;
    picCol = 0;
  } else if (Theme.equals("Really Dark")) {
    newText[0] = 255;
    newText[1] = 255;
    newText[2] = 255;
    textColor[0] = 255;
    textColor[1] = 255;
    textColor[2] = 255;
    backGroundColor[0] = 0;
    backGroundColor[1] = 0;
    backGroundColor[2] = 0;
    newBG[0] = 0;
    newBG[1] = 0;
    newBG[2] = 0;
    colors[0] = 0;
    colors[1] = 0;
    colors[2] = 0;
    newColors[0] = 0;
    newColors[1] = 0;
    newColors[2] = 0;
    colToBe = 255;
    picCol = 255;
  } else if (Theme.equals("Really Light")) {
    newText[0] = 0;
    newText[1] = 0;
    newText[2] = 0;
    newBG[0] = 255;
    newBG[1] = 255;
    newBG[2] = 255;
    newColors[0] = 255;
    newColors[1] = 255;
    newColors[2] = 255;
    colors[0] = 255;
    colors[1] = 255;
    colors[2] = 255;
    textColor[0] = 0;
    textColor[1] = 0;
    textColor[2] = 0;
    backGroundColor[0] = 255;
    backGroundColor[1] = 255;
    backGroundColor[2] = 255;
    colToBe = 0;
    picCol = 0;
  }
  if (!customTheme && !Theme.equals("Really Dark") && !Theme.equals("Really Light")) {
    if (cScheme.equals("Blue")) {
      colors[0] = 66;
      colors[1] = 135;
      colors[2] = 245;
      newColors[0] = 66;
      newColors[1] = 135;
      newColors[2] = 245;
    } else if (cScheme.equals("Red")) {
      colors[0] = 128;
      colors[1] = 0;
      colors[2] = 0;
      newColors[0] = 128;
      newColors[1] = 0;
      newColors[2] = 0;
    } else if (cScheme.equals("Green")) {
      colors[0] = 92;
      colors[1] = 153;
      colors[2] = 107;
      newColors[0] = 92;
      newColors[1] = 153;
      newColors[2] = 107;
    } else if (cScheme.equals("Orange")) {
      newColors[0] = 252;
      newColors[1] = 134;
      newColors[2] = 33;
      colors[0] = 252;
      colors[1] = 134;
      colors[2] = 33;
    } else if (cScheme.equals("Purple")) {
      newColors[0] = 117;
      newColors[1] = 121;
      newColors[2] = 231;
      colors[0] = 117;
      colors[1] = 121;
      colors[2] = 231;
    } else if (cScheme.equals("Turquoise")) {
      newColors[0] = 0;
      newColors[1] = 136;
      newColors[2] = 145;
      colors[0] = 0;
      colors[1] = 136;
      colors[2] = 145;
    }
  }
  try {
    transSpeed = float(split(pref[5], ':')[1]);
  }
  catch (Exception e) {
    updatedFile();
    writeData();
  }
}


void writeData() {
  String file = "pref.txt";
  String[] toWrite = {"Cohort:" + str(cohort), "P1:" + p1Class, "P2:" + p2Class, "Theme:" + Theme, "cScheme:" + cScheme, "Animation Speed:" + transSpeed};
  saveStrings(file, toWrite);
}

void guiSettings() {
  fill(textColor[0], textColor[1], textColor[2]);

  textFont(font, 25*displayDensity); //Setting Text Font
  textAlign(CENTER);

  text("TMTimeTable Settings", width/2, height*0.0494444444 + 25); //Top Text

  textAlign(LEFT);
  textFont(font, 20*displayDensity); //Setting Text Font
  textAlign(CENTER);

  text("Theme: " + Theme, width/2, themPos[0]);
  if (Theme.equals("Really Dark")) {
    text("Color Scheme: Really Dark", width/2, clrPos[0]);
  } else if (Theme.equals("Really Light")) {
    text("Color Scheme: Really Light", width/2, clrPos[0]);
  } else {
    text("Color Scheme: " + cScheme, width/2, clrPos[0]);
  }

  text("Change Course One: " + p1Class, width/2, courseOne[0]);
  text("Change Course Two: " + p2Class, width/2, courseTwo[0]);

  text("Change Cohort: " + cohort, width/2, changeCohort[0]);
  text("Animation Speed: " + transSpeed, width/2, aniSpeed);

  fill(128, 128, 128);

  textFont(font, 20);
  image(homep[ishift], height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(calendar[ishift], width - height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  if (verCounter >= 5) {
    fill(textColor[0], textColor[1], textColor[2], alpha);
    textAlign(LEFT);
    text("Version: " + ver, width-200, height - height*0.102986612);
  }
}
boolean noSchool() {
  if (dayOfWeek == "Saturday" || dayOfWeek == "Sunday") {
    reason = "Weekend";
    return true;
  } else if (paDay()) {
    reason = "PA Day";
    return true;
  } else {
    return false;
  }
}
boolean paDay() {
  int[] months = {2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5};
  int[] days = {15, 2, 5, 12, 13, 14, 15, 16, 26, 27, 24};
  for (int i = 0; i < days.length; i++) { 
    if (day() == days[i] && month() == months[i]) {
      return true;
    }
  }
  return false;
}
