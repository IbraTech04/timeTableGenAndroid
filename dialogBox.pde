void dialogBoxP1() {
  act = this.getActivity();
  act.runOnUiThread(new Runnable() {
    public void run() {
      AlertDialog.Builder builder = new AlertDialog.Builder(act);
      final EditText input = new EditText(act); 
      builder.setView(input); 
      builder.setTitle("Enter your P1 Class:");
      builder.setPositiveButton("Done", new DialogInterface.OnClickListener() { 
        public void onClick(DialogInterface dialog, int whichButton) { 
          String value = input.getText().toString().trim(); 
          p1Class = value;
          if (!isSetUp) {
            state++;
          } else {
            writeData();
          }
        }
      }
      );
      builder.setNegativeButton("Cancel", new DialogInterface.OnClickListener() { 
        public void onClick(DialogInterface dialog, int whichButton) { 
          dialog.cancel();
        }
      }
      ); 
      builder.show();
    }
  }
  );
}
void dialogBoxP2() {
  act = this.getActivity();
  act.runOnUiThread(new Runnable() {
    public void run() {
      AlertDialog.Builder builder = new AlertDialog.Builder(act);
      final EditText input = new EditText(act); 
      builder.setView(input); 
      builder.setTitle("Enter your P2 Class:");
      builder.setPositiveButton("Done", new DialogInterface.OnClickListener() { 
        public void onClick(DialogInterface dialog, int whichButton) { 
          String value = input.getText().toString().trim(); 
          p2Class = value;
          if (!isSetUp) {
            writeData();
            state = 3;
            closeKeyboard();
          } else {
            writeData();
          }
        }
      }
      );
      builder.setNegativeButton("Cancel", new DialogInterface.OnClickListener() { 
        public void onClick(DialogInterface dialog, int whichButton) { 
          dialog.cancel();
        }
      }
      ); 
      builder.show();
    }
  }
  );
}

void dialogBoxOtherDay() {
  act = this.getActivity();
  act.runOnUiThread(new Runnable() {
    public void run() {
      AlertDialog.Builder builder = new AlertDialog.Builder(act);
      final EditText input = new EditText(act); 
      builder.setView(input);     
      builder.setTitle("Enter the date you would like to check (mm/dd):");
      builder.setPositiveButton("Done", new DialogInterface.OnClickListener() { 
        public void onClick(DialogInterface dialog, int whichButton) { 
          String value = input.getText().toString().trim(); 
          otherDay = value;
          if (otherDay != null) {
            screenNumber = 3;
            parseDate(otherDay);
          }
        }
      }
      );
      builder.setNegativeButton("Cancel", new DialogInterface.OnClickListener() { 
        public void onClick(DialogInterface dialog, int whichButton) { 
          dialog.cancel();
        }
      }
      ); 
      builder.show();
    }
  }
  );
}

import processing.core.PApplet;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.Color;
import android.widget.TextView;
import android.view.Gravity;

TextView msg;
int msgId;

void warning() {
  act = this.getActivity();

  final TextView msg = new TextView(act); 
  msg.setBackgroundColor(Color.WHITE);
  msg.setTextSize(20);
  msg.setGravity(Gravity.CENTER_HORIZONTAL); 
  msg.setText("Invalid date entered. Would you like to try again?"); 
  act.runOnUiThread(new Runnable() {
    public void run() {
      AlertDialog.Builder builder = new AlertDialog.Builder(act);
      builder.setView(msg);
      builder.setTitle("Error");
      builder.setPositiveButton("No", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
        }
      }
      );
      builder.setNegativeButton("Yes", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
          dialogBoxOtherDay();
        }
      }
      )
      .show();
    }
  }
  );
}

void remind() {
  act = this.getActivity();

  final TextView msg = new TextView(act); 
  msg.setBackgroundColor(Color.WHITE);
  msg.setTextSize(20);
  msg.setGravity(Gravity.CENTER_HORIZONTAL); 
  msg.setText("Remember to do your COVID screening before going to school"); 
  act.runOnUiThread(new Runnable() {
    public void run() {
      AlertDialog.Builder builder = new AlertDialog.Builder(act);
      builder.setView(msg);
      builder.setTitle("Reminder");
      builder.setPositiveButton("Okay I will", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
          link("https://covid-19.ontario.ca/school-screening/");
        }
      }
      );
      builder.setNegativeButton("No Screw you Ibrahim", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
        }
      }
      )
      .show();
    }
  }
  );
}
void updatedFile() {
  act = this.getActivity();

  final TextView msg = new TextView(act); 
  msg.setBackgroundColor(Color.WHITE);
  msg.setTextSize(20);
  msg.setGravity(Gravity.CENTER_HORIZONTAL); 
  msg.setText("Your save file has been updated to be compliant with TMTimeTable V" + ver); 
  act.runOnUiThread(new Runnable() {
    public void run() {
      AlertDialog.Builder builder = new AlertDialog.Builder(act);
      builder.setView(msg);
      builder.setTitle("Update");
      builder.setPositiveButton("Okay", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
        }
      }
      );
      builder.setNegativeButton("Close", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
        }
      }
      )
      .show();
    }
  }
  );
}

void update() {
  act = this.getActivity();

  final TextView msg = new TextView(act); 
  msg.setBackgroundColor(Color.WHITE);
  msg.setTextSize(20);
  msg.setGravity(Gravity.CENTER_HORIZONTAL); 
  msg.setText("A new version is availible. Would you like to update?"); 
  act.runOnUiThread(new Runnable() {
    public void run() {
      AlertDialog.Builder builder = new AlertDialog.Builder(act);
      builder.setView(msg);
      builder.setTitle("Time to update!");
      builder.setPositiveButton("Sure", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
          link("https://github.com/IbraTech04/timeTableGenAndroid/releases");
        }
      }
      );
      builder.setNegativeButton("Screw you and your update Ibrahim", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
        }
      }
      )
      .show();
    }
  }
  );
}
void urgentUpdate() {
  act = this.getActivity();

  final TextView msg = new TextView(act); 
  msg.setBackgroundColor(Color.WHITE);
  msg.setTextSize(20);
  msg.setGravity(Gravity.CENTER_HORIZONTAL); 
  msg.setText("An urgent update is availible. We highly suggest you update"); 
  act.runOnUiThread(new Runnable() {
    public void run() {
      AlertDialog.Builder builder = new AlertDialog.Builder(act);
      builder.setView(msg);
      builder.setTitle("Urgent Update");
      builder.setPositiveButton("Okay", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
          link("https://github.com/IbraTech04/timeTableGenAndroid/releases");
        }
      }
      );
      builder.setNegativeButton("Screw you and your update Ibrahim", 
        new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialog, 
          int which) {
        }
      }
      )
      .show();
    }
  }
  );
}
