int[] newBG = new int[3];
int[] newColors = {0, 0, 0};
int[] newText = new int[3];
int ishift = 0;
void mousePressed() { 
  if (!isSetUp) {
  } else {
    if (screenNumber == 1) {
      if (settings.get(0).isPressed()) {
        if (Theme.equals("Dark")) {
          Theme = "Light";
          newBG[0] = 255;
          newBG[1] = 255;
          newBG[2] = 255;
          newText[0] = 0;
          newText[1] = 0;
          newText[2] = 0;
          colToBe = 0;
          if (cScheme.equals("Blue")) {
            newColors[0] = 66;
            newColors[1] = 135;
            newColors[2] = 245;
          } else if (cScheme.equals("Red")) {
            newColors[0] = 128;
            newColors[1] = 0;
            newColors[2] = 0;
          } else if (cScheme.equals("Green")) {
            newColors[0] = 98;
            newColors[1] = 153;
            newColors[2] = 107;
          } else if (cScheme.equals("Orange")) {
            newColors[0] = 252;
            newColors[1] = 134;
            newColors[2] = 33;
          } else if (cScheme.equals("Purple")) {
            newColors[0] = 117;
            newColors[1] = 121;
            newColors[2] = 231;
          } else if (cScheme.equals("Turquoise")) {
            newColors[0] = 0;
            newColors[1] = 136;
            newColors[2] = 145;
          }
        } else if (Theme.equals("Light")) {
          Theme = "Really Dark";
          newText[0] = 255;
          newText[1] = 255;
          newText[2] = 255;
          newBG[0] = 0;
          newBG[1] = 0;
          newBG[2] = 0;
          colToBe = 255;
          newColors[0] = 0;
          newColors[1] = 0;
          newColors[2] = 0;
        } else if (Theme.equals("Really Dark")) {
          Theme = "Really Light";
          newText[0] = 0;
          newText[1] = 0;
          newText[2] = 0;
          newBG[0] = 255;
          newBG[1] = 255;
          newBG[2] = 255;
          colToBe = 0;
          newColors[0] = 255;
          newColors[1] = 255;
          newColors[2] = 255;
        } else {
          Theme = "Dark";
          newBG[0] = 0;
          newBG[1] = 0;
          newBG[2] = 0;
          newText[0] = 255;
          newText[1] = 255;
          newText[2] = 255;
          colToBe = 255;
          if (cScheme.equals("Blue")) {
            newColors[0] = 66;
            newColors[1] = 135;
            newColors[2] = 245;
          } else if (cScheme.equals("Red")) {
            newColors[0] = 128;
            newColors[1] = 0;
            newColors[2] = 0;
          } else if (cScheme.equals("Green")) {
            newColors[0] = 98;
            newColors[1] = 153;
            newColors[2] = 107;
          } else if (cScheme.equals("Orange")) {
            newColors[0] = 252;
            newColors[1] = 134;
            newColors[2] = 33;
          } else if (cScheme.equals("Purple")) {
            newColors[0] = 117;
            newColors[1] = 121;
            newColors[2] = 231;
          } else if (cScheme.equals("Turquoise")) {
            newColors[0] = 0;
            newColors[1] = 136;
            newColors[2] = 145;
          }
        }
        writeData(); 
        
      } else if (settings.get(1).isPressed()) {
        if (!customTheme && !Theme.equals("Really Dark") && !Theme.equals("Really Light")) {
          if (cScheme.equals("Blue")) {
            cScheme = "Red";
            newColors[0] = 128;
            newColors[1] = 0;
            newColors[2] = 0;
          } else if (cScheme.equals("Red")) {
            cScheme = "Green";
            newColors[0] = 98;
            newColors[1] = 153;
            newColors[2] = 107;
          } else if (cScheme.equals("Green")) {
            cScheme = "Orange";
            newColors[0] = 252;
            newColors[1] = 134;
            newColors[2] = 33;
          } else if (cScheme.equals("Orange")) {
            cScheme = "Purple";
            newColors[0] = 117;
            newColors[1] = 121;
            newColors[2] = 231;
          } else if (cScheme.equals("Purple")) {
            cScheme = "Turquoise";
            newColors[0] = 0;
            newColors[1] = 136;
            newColors[2] = 145;
          } else if (cScheme.equals("Turquoise")) {
            cScheme = "Blue";
            newColors[0] = 60;
            newColors[1] = 135;
            newColors[2] = 245;
          }
        }
        writeData(); 
        ;
      } else if (settings.get(2).isPressed()) {
        dialogBoxP1();
        writeData(); 

        initWeekView();
      } else if (settings.get(3).isPressed()) {
        dialogBoxP2();
        writeData(); 

        initWeekView();
      } else if (settings.get(4).isPressed()) {
        dialogBoxP3();
        writeData(); 

        initWeekView();
      } else if (settings.get(5).isPressed()) {
        dialogBoxP4();
        writeData(); 

        initWeekView();
      } else {
        verCounter ++;
      }
    }
    if (mouseY >= height -  height*0.102986612 && mouseX <=height*0.102986612) {
      if (screenNumber == 0) {
        screenNumber = 1;
      } else {
        screenNumber = 0;
      }
    } else if (mouseY >= height -  height*0.102986612 && mouseX >=width - height*0.102986612) {
      dialogBoxOtherDay();
    } else if (mouseY >= height -  height*0.102986612 && mouseX <= width/2 + height*0.102986612/2 && mouseX >= width/2 - height*0.102986612/2) {
      if (screenNumber == 0) {
        if (view == 0) {
          view = 1;
        } else {
          view = 0;
        }
        writeData();
      }
    }
  }
}
float sizeDetecW(float input, float divisor) {
  float toReturn;
  toReturn = input/1280;
  return toReturn*divisor;
}
float sizeDetecH(float input, float divisor) {
  float toReturn;
  toReturn = input/720;
  return toReturn*divisor;
}
void colorShift(int r, int g, int b) {
  if (colors[0] > r) {
    colors[0]-=transSpeed;
  } else if (colors[0] < r) {
    colors[0]+=transSpeed;
  }
  if (colors[1] > g) {
    colors[1]-=transSpeed;
  } else if (colors[1] < g) {
    colors[1]+=transSpeed;
  }
  if (colors[2] > b) {
    colors[2]-=transSpeed;
  } else if (colors[2] < b) {
    colors[2]+=transSpeed;
  }
}
void colorShiftBG(int r, int g, int b) {
  if (backGroundColor[0] > r) {
    backGroundColor[0]-=transSpeed;
  } else if (backGroundColor[0] < r) {
    backGroundColor[0]+=transSpeed;
  }
  if (backGroundColor[1] > g) {
    backGroundColor[1]-=transSpeed;
  } else if (backGroundColor[1] < g) {
    backGroundColor[1]+=transSpeed;
  }
  if (backGroundColor[2] > b) {
    backGroundColor[2]-=transSpeed;
  } else if (backGroundColor[2] < b) {
    backGroundColor[2]+=transSpeed;
  }
}
void colorShiftText(int r, int g, int b) {
  if (textColor[0] > r) {
    textColor[0]-=transSpeed;
  } else if (textColor[0] < r) {
    textColor[0]+=transSpeed;
  }
  if (textColor[1] > g) {
    textColor[1]-=transSpeed;
  } else if (textColor[1] < g) {
    textColor[1]+=transSpeed;
  }
  if (textColor[2] > b) {
    textColor[2]-=transSpeed;
  } else if (textColor[2] < b) {
    textColor[2]+=transSpeed;
  }
}

void colorShiftImg(int r) {
  if (picCol > r) {
    picCol-=transSpeed;
  } else if (picCol < r) {
    picCol+=transSpeed;
  }
}
