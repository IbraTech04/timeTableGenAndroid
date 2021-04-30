void mainScreen() {
  background(backGroundColor[0], backGroundColor[1], backGroundColor[2], alpha);
  fill(colors[0], colors[1], colors[2], alpha);
  rect(0, height -  height*0.102986612, width, height, 15*displayDensity, 15*displayDensity, 0, 0); //These two are the two rectangles on the top and bottom
  rect(0, 0, width, height*0.102986612, 0, 0, 15*displayDensity, 15*displayDensity);
  textAlign(CENTER);
  fill(textColor[0], textColor[1], textColor[2], alpha);
  textFont(font, 25*displayDensity); //Setting Text Font
  text("TMTimeTable Home", width/2, height*0.0494444444 + 25); //Top Text
  textFont(font, 20*displayDensity); //Setting Text Font
  text("Your Schedule for today:", width/2, height/2-200);
  text(calDate + " (Day " + period + ")", width/2, height/2-130);
  imageMode(CENTER);
  image(settingsp[ishift], height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(calendar[ishift], width - height*0.102986612/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);
  image(weekV, width/2, height - height*0.102986612/2, height*0.102986612/2, height*0.102986612/2);

  pushMatrix();
  drawTimes();
  popMatrix();
}
