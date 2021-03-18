void checkForUpdates() {
  String[] nversionFromServer = loadStrings("https://raw.githubusercontent.com/IbraTech04/updateServer/master/Vers.txt");
  if (!nversionFromServer[0].equals(ver)) {
    if (nversionFromServer[1].equals("URGENT")) {
      urgentUpdate();
    } else {
      update();
    }
  }
}
