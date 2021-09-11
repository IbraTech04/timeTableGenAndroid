import android.app.DialogFragment;
import android.app.DatePickerDialog;
import java.util.Calendar; //Import Calendar Functions
Calendar cal = Calendar.getInstance(); //Get calendar date
import android.content.DialogInterface;
import android.app.Activity;
import android.app.AlertDialog;
import android.text.Editable;
import android.widget.EditText;
Activity act;
import java.util.ArrayList;
import java.time.*;


String[] week = {"", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}, months = {"", "January", "February", "March", "April", "May", "June", "July", "Auguest", "September", "October", "November", "December"};
int date = cal.get(Calendar.DAY_OF_WEEK), wed = cal.get(Calendar.WEEK_OF_MONTH), period, state = 0;
String dayOfWeek = week[date], monthString = months[month()] + year();
boolean p1Online = true, p2Online = false, warningShown = false;
String[] pref;
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
ArrayList<WeekRect> rects = new ArrayList<WeekRect>();
ArrayList<ClickableText> settings = new ArrayList<ClickableText>();

Calendar viewWeek = Calendar.getInstance(); //Get calendar date

void setup() {
  loadImgs();
  frameRate(60);
  requestPermission("android.permission.READ_EXTERNAL_STORAGE", "doNothing");
  requestPermission("android.permission.WRITE_EXTERNAL_STORAGE", "downloadFile");
  background(0);
  fullScreen();
  homep[0] = loadImage("HomeL.png");
  settingsp[0] = loadImage("SettingsL.png");
  calendar[0] = loadImage("calL.png");
  weekV = loadImage("weekL.png");

  smooth();
  noStroke();
  font = createFont("ProductSans-Bold.ttf", 100); //Load the font
  for (int i = 0; i < 6; i ++) {
    settings.add(new ClickableText());
    settings.get(i).setMode("CENTER");
    settings.get(i).setSize(50);
  }
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
  try {
    checkForUpdates();
  }
  catch (Exception e) {
  }
  initWeekView();
  try {
    //reg = loadStrings("https://raw.githubusercontent.com/IbraTech04/updateServer/master/timeTableReg.txt");
  }
  catch (Exception e) {
  }
}

void draw() {
  if (updateMode) {
    background(0);
    beginUpdate();
  } else {
    tint(picCol, alpha);
    colorShift(newColors[0], newColors[1], newColors[2]);
    colorShiftBG(newBG[0], newBG[1], newBG[2]);
    colorShiftText(newText[0], newText[1], newText[2]);
    colorShiftImg(colToBe);
    sizeDeteccLegacy();
    if (isSetUp) {
      if (screenNumber == 0) {
        if (alpha <= 255) {
          alpha+=17;
        }
        if (view == 0) {
          mainScreen();
        } else {
          weekView();
        }
      } else if (screenNumber == 1) {
        background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
        fill(colors[0], colors[1], colors[2]);
        rect(0, height -  height*0.102986612, width, height, 20*displayDensity, 20*displayDensity, 0, 0); //These two are the two rectangles on the top and bottom
        rect(0, 0, width, height*0.102986612, 0, 0, 20*displayDensity, 20*displayDensity);
        guiSettings();
      } else {
        background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
        fill(colors[0], colors[1], colors[2]);
        rect(0, height -  height*0.102986612, width, height, 20*displayDensity, 20*displayDensity, 0, 0); //These two are the two rectangles on the top and bottom
        rect(0, 0, width, height*0.102986612, 0, 0, 20*displayDensity, 20*displayDensity);
        image(homep[ishift], height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
        image(calendar[ishift], width - height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
        fill(textColor[0], textColor[1], textColor[2]);
        textFont(font, 25*displayDensity); //Setting Text Font
        text("TMTimeTable Custom Date Entry", width/2, height*0.0494444444 + 25); //Top Text
        textFont(font, 20*displayDensity); //Setting Text Font
        text("Your Schedule for entered date:", width/2, height/2-200);
        text(otherCalDate + " (Week " + (weekNumOther + 1) + ")", width/2, height/2-130);
        drawTimesOther();
      }
    } else {
      if (state != 4) {
        if (alpha < 255) {
          alpha+=17;
        }
      }
      background(backGroundColor[0], backGroundColor[1], backGroundColor[2]);
      fill(colors[0], colors[1], colors[2], alpha);
      rect(0, height -  height*0.102986612, width, height, 15*displayDensity, 15*displayDensity, 0, 0); //These two are the two rectangles on the top and bottom
      rect(0, 0, width, height*0.102986612, 0, 0, 15*displayDensity, 15*displayDensity);
      textAlign(CENTER);
      fill(textColor[0], textColor[1], textColor[2], alpha);
      textFont(font, 25*displayDensity); //Setting Text Font

      text("TMTimeTable First Time Setup", width/2, height*0.0494444444 + 25); //Top Text
      if (state == 0) {
        text("Welcome to TMTimeTable V4!", width/2, sizeDetecH(135, height));
        textFont(font, 20*displayDensity); //Setting Text Font
        text("\"Where Timetables Evolve\"", width/2, sizeDetecH(185, height));
        textFont(font, 17*displayDensity); //Setting Text Font
        text("To begin, please input your period 1 Class", width/2, sizeDetecH(235, height));
        if (!isOpen1) {
          dialogBoxP1();
          isOpen1 = true;
        }
      } else if (state == 1) {
        text("Welcome to TMTimeTable V4!", width/2, sizeDetecH(135, height));
        textFont(font, 20*displayDensity); //Setting Text Font
        text("\"Where Timetables Evolve\"", width/2, sizeDetecH(185, height));
        textFont(font, 17*displayDensity); //Setting Text Font
        text("Awesome! Now type in your period 2 class", width/2, sizeDetecH(235, height));        
        if (!isOpen2) {
          dialogBoxP2();
          isOpen2 = true;
          isOpen1 = false;
        }
      } else if (state == 2) {
        text("Welcome to TMTimeTable V4!", width/2, sizeDetecH(135, height));
        textFont(font, 20*displayDensity); //Setting Text Font
        text("\"Where Timetables Evolve\"", width/2, sizeDetecH(185, height));
        textFont(font, 17*displayDensity); //Setting Text Font
        text("Great! Now type in your period 3 class", width/2, sizeDetecH(235, height));  
        if (!isOpen1) {
          dialogBoxP3();
          isOpen1 = true;
          isOpen2 = false;
        }
      } else if (state == 3) {
        text("Welcome to TMTimeTable V4!", width/2, sizeDetecH(135, height));
        textFont(font, 20*displayDensity); //Setting Text Font
        text("\"Where Timetables Evolve\"", width/2, sizeDetecH(185, height));
        textFont(font, 17*displayDensity); //Setting Text Font
        text("Last One! Now type in your period 4 class", width/2, sizeDetecH(235, height));  
        if (!isOpen2) {
          dialogBoxP4();
          isOpen2 = true;
        }
      } else if (state == 4) {
        alpha-= 15;
        if (alpha <= 0) {
          initWeekView();
          isSetUp = true;
        }
      }
    }
  }
}

void keyPressed() {
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
      isSetUp = false;
      setup();
    }
  }
}


void drawTimes() {
  translate(0, 50);
  if (noSchool()) {
    text("No School today. Reason: " + reason, width/2, height/2-105); //Drawing Prayer times
  } else {
    text("P1: " + courses[getWeekNum()][0], width/2, height/2-105); //Drawing Prayer times
    text("P2: " + courses[getWeekNum()][1], width/2, height/2-52);
  }
}
void loadData() {
  if (pref[0].equals("timeTableGenV4.1Save")) {

    courses[0][0] = split(pref[1], ':')[1];
    courses[0][1] = split(pref[2], ':')[1];
    courses[1][0] = split(pref[3], ':')[1];
    courses[1][1] = split(pref[4], ':')[1];
    Theme = split(pref[5], ':')[1];
    cScheme = split(pref[6], ':')[1];
    view = int(split(pref[7], ':')[1]);
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
  } else {
    throw null;
  }
}


void writeData() {
  String file = "pref.txt";
  String[] toWrite;
  toWrite = new String[]{"timeTableGenV4.1Save", "P1:" + courses[0][0], "P2:" + courses[0][1], "P3:" + courses[1][0], "P4:" + courses[1][1], "Theme:" + Theme, "cScheme:" + cScheme, "View:" + view};
  saveStrings(file, toWrite);
}

void guiSettings() {
  fill(textColor[0], textColor[1], textColor[2]);

  textFont(font, 27*displayDensity); //Setting Text Font
  textAlign(CENTER);

  text("TMTimeTable Settings", width/2, height*0.0494444444 + 25); //Top Text

  textAlign(LEFT);
  textFont(font, 20*displayDensity); //Setting Text Font
  textAlign(CENTER);

  settings.get(0).setText("Theme: " + Theme);
  settings.get(0).setPos(width/2, int(themPos[0]));
  settings.get(0).drawText();

  if (Theme.equals("Really Dark")) {
    settings.get(1).setText("Color Scheme: Really Light");
  } else if (Theme.equals("Really Light")) {
    settings.get(1).setText("Color Scheme: Really Light");
  } else {
    settings.get(1).setText("Color Scheme: " + cScheme);
  }

  settings.get(1).setPos(width/2, int(clrPos[0]));
  settings.get(1).drawText();

  settings.get(2).setText("Change Course One: " + courses[0][0]);
  settings.get(2).setPos(width/2, int(courseOne[0]));
  settings.get(2).drawText();

  settings.get(3).setText("Change Course Two: " + courses[0][1]);
  settings.get(3).setPos(width/2, int(courseTwo[0]));
  settings.get(3).drawText();

  settings.get(4).setText("Change Course Three: " + courses[1][0]);
  settings.get(4).setPos(width/2, int(changeCohort[0]));
  settings.get(4).drawText();
  fill(textColor[0], textColor[1], textColor[2], alpha);

  settings.get(5).setText("Change Course Four: " + courses[1][1]);
  settings.get(5).setPos(width/2, int(aniSpeed));
  settings.get(5).drawText();


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

int getWeekNum() {
  DateTime firstDay = new DateTime(2021, 9, 9, 12, 0);
  DateTime now = new DateTime();
  Weeks weeks = Weeks.weeksBetween(firstDay, now);
  return weeks.getWeeks() % 2;
}

int getWeekNum(int month, int day) {
  DateTime firstDay = new DateTime(2021, 9, 5, 12, 0);
  DateTime now = new DateTime(2021, month, day, 12, 0);
  Weeks weeks = Weeks.weeksBetween(firstDay, now);
  return weeks.getWeeks() % 2;
}

int getWeekNum(int month, int day, int year) {
  DateTime firstDay = new DateTime(2021, 9, 5, 12, 0);
  DateTime now = new DateTime(year, month, day, 12, 0);
  Weeks weeks = Weeks.weeksBetween(firstDay, now);
  return weeks.getWeeks() % 2;
}
