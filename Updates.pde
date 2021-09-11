String[] nversionFromServer;

void loadImgs() {
  new Thread(new Runnable() {
    public void run() {
      for (int i = 0; i < 75; i++) {
        String imageName = "image" + nf(i, 3) + ".png";
        loadingAnimation[i] = loadImage(imageName);
      }
    }
  }
  ).start();
}

void checkForUpdates() {
  new Thread(new Runnable() {
    public void run() {
      nversionFromServer = loadStrings("https://raw.githubusercontent.com/IbraTech04/updateServer/master/Vers.txt");
      if (isGreater(nversionFromServer[0])) {
        if (nversionFromServer[1].equals("URGENT")) {
          urgentUpdate();
        } else {
          update();
        }
      }
    }
  }
  ).start();
}

void downloadUpdate() {
  new Thread(new Runnable() {
    public void run() {
      test = loadBytes("https://github.com/IbraTech04/updateServer/raw/master/timetablegenandroidv2_release_signed_aligned.apk");
      File theDir = new File(Environment.getExternalStorageDirectory() + "/TMTimeTable");
      if (!theDir.exists()) {
        theDir.mkdirs();
      }
      saveBytes(Environment.getExternalStorageDirectory() + "/TMTimeTable/tmtimetable" + nversionFromServer[0] + ".apk", test);
      updateState++;
    }
  }
  ).start();
}

import android.content.Intent;
import android.net.Uri;
import android.os.Environment;
import android.content.Context;

void doNothing(boolean granted) {
}

void downloadFile(boolean granted) {
}
byte[] test;

float integer;
int frameNum = 0;

void beginUpdate() {
  frameRate(30);
  colorMode(HSB, 360, 100, 100);
  integer += 0.5;
  if (integer == 255) {
    integer = 0;
  }
  imageMode(CENTER);
  if (updateState == 0) {
    background(color(integer, 255, 255));
    image(loadingAnimation[frameNum], width/2, height/2 - 100*displayDensity, 400, 400);
    frameNum ++;
    if (frameNum == 74) {
      frameNum = 0;
    }
    textAlign(CENTER);
    textFont(font, 25*displayDensity); //Setting Text Font
    text("Updating TMTimeTable", width/2, height/2-26*displayDensity);
    textFont(font, 12*displayDensity); //Setting Text Font
    text("Preparing to Update", width/2, height/2);
    text("Please do not close this \napp until this process is complete", width/2, height/2+13*displayDensity);
    downloadUpdate();
    updateState++;
  } else if (updateState == 1) {
    background(color(integer, 255, 255));
    image(loadingAnimation[frameNum], width/2, height/2 - 100*displayDensity, 400, 400);
    frameNum ++;
    if (frameNum == 74) {
      frameNum = 0;
    }
    textFont(font, 25*displayDensity); //Setting Text Font
    text("Updating TMTimeTable", width/2, height/2-26*displayDensity);
    textFont(font, 12*displayDensity); //Setting Text Font
    text("Downloading Update Files", width/2, height/2);
    text("Please do not close this \nwindow until this process is complete", width/2, height/2+26*displayDensity);
  } else if (updateState == 2) {
    background(0);
    textFont(font, 12*displayDensity); //Setting Text Font
    text("File Downloaded. \nNavigate to Internal Storage > TMTimeTable \nand select the latest APK", width/2, height/2+30);
    updateState++;
  } else if (updateState == 3) {
    delay(10000); 
    //updateMode = false;
  }
}
boolean isGreater(String version) {
  String ver1 = ver + ".0.0";
  String[] ww = split(version, '.');
  String[] w = split(ver1, '.');
  try { 

    if (int(ww[0]) > int(w[0])) {
      return true;
    } else if (int(ww[1]) > int(w[1]) && int(ww[0]) == int(w[0])) {
      return true;
    } else if (int(ww[2]) > int(w[2]) && int(ww[1]) == int(w[1]) && int(ww[0]) == int(w[0])) {
      return true;
    }
  } 
  catch (Exception e) {
    return true;
  }
  return false;
}
