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

void beginUpdate() {
  if (updateState == 0) {
    textAlign(CENTER);
    textSize(29);
    text("Updating... \nPlease do not close this window until this process is complete", width/2, height/2+30);
    text("Stage One: Downloading Update Files", width/2, height/2);
    updateState++;
  } else if (updateState == 1) {
    background(0);
    byte[] test = loadBytes("https://github.com/IbraTech04/updateServer/raw/master/timetablegenandroidv2_release_signed_aligned.apk");
    saveBytes(Environment.getExternalStorageDirectory() + "/download/" + "tmtimetable" + nversionFromServer[0] + ".apk", test);
    updateState++;
  } else if (updateState == 2) {
    background(0);
    text("File Downloaded. Navigate to your downloads directory to install the APK \n Do not use the Downloads category in your file manager \n Manually naviagte to Internal Storage > Downloads", width/2, height/2+30);
    updateState++;
  } else if (updateState == 3) {
    delay(10000); 
    updateMode = false;
  }
}
