String[] nversionFromServer;
void checkForUpdates() {
  nversionFromServer = loadStrings("https://raw.githubusercontent.com/IbraTech04/updateServer/master/Vers.txt");
  if (!nversionFromServer[0].equals(ver)) {
    if (nversionFromServer[1].equals("URGENT")) {
      urgentUpdate();
    } else {
      update();
    }
  }
}

import android.content.Intent;
import android.net.Uri;
import android.os.Environment;
import android.content.Context;

void doNothing(boolean granted) {
}

void downloadFile(boolean granted) {
  if (granted) {
    println("worked");
  } else {
    println("no");
  }
}
byte[] test;
void beginUpdate() {
  if (updateState == 0) {
    textAlign(CENTER);
    textFont(font, 25*displayDensity); //Setting Text Font
    text("Updating TMTimeTable", width/2, height/2-26*displayDensity);
    textFont(font, 12*displayDensity); //Setting Text Font
    text("Stage One: Downloading Update Files", width/2, height/2);
    text("Please do not close this \nwindow until this process is complete", width/2, height/2+13*displayDensity);
    updateState++;
  } else if (updateState == 1) {
    test = loadBytes("https://github.com/IbraTech04/updateServer/raw/master/timetablegenandroidv2_release_signed_aligned.apk");
    updateState++;
  } else if (updateState == 2) {
    background(0);
    textFont(font, 25*displayDensity); //Setting Text Font
    text("Updating TMTimeTable", width/2, height/2-26*displayDensity);
    textFont(font, 12*displayDensity); //Setting Text Font
    text("Stage Two: Applying Update", width/2, height/2);
    text("Please do not close this \nwindow until this process is complete", width/2, height/2+26*displayDensity);
    updateState++;
  } else if (updateState == 3) {
    File theDir = new File(Environment.getExternalStorageDirectory() + "/TMTimeTable");
    if (!theDir.exists()) {
      theDir.mkdirs();
    }
    saveBytes(Environment.getExternalStorageDirectory() + "/TMTimeTable/tmtimetable" + nversionFromServer[0] + ".apk", test);
    delay(2000);
    updateState++;
  } else if (updateState == 4) {
    background(0);
    textFont(font, 12*displayDensity); //Setting Text Font
    text("File Downloaded. \nNavigate to Internal Storage > TMTimeTable \nand select the latest APK", width/2, height/2+30);
    updateState++;
  } else if (updateState == 5) {
    delay(10000); 
    updateMode = false;
  }
}
