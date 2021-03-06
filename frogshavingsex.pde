//缝缝补补的代码
//请配合data中的frogshavingsex.mp3使用

import processing.sound.*;

SoundFile sample;
Amplitude rms;

float x = 100;
float y = 100;
float xspeed = 2.5;
float yspeed = 2.5;
float smoothingFactor = 0.2;
float sum;

public void setup() {
  size(1280, 960);

  sample = new SoundFile(this, "frogshavingsex.mp3");
  sample.loop();

  rms = new Amplitude(this);
  rms.input(sample);
}      

public void draw() {
  background(#005471);
  noStroke();
  fill(#FF0034);

  x = x + xspeed;
  y = y + yspeed;

  if ((x > width) || (x < 0)) {
    xspeed = xspeed * -1.2;
  }
  if ((y > height) || (y < 0)) {
    yspeed = yspeed * -1.2;
  }

  sum += (rms.analyze() - sum) * smoothingFactor;

  float rms_scaled = sum * (height/3) * 20;

  ellipse(x, y, rms_scaled, rms_scaled);

  int count = 8 ;
  float maxAlpha =20.0;
  float alphaUnit = maxAlpha/count;
  for (int i=1; i<=count; i++) {
    fill(255, i* alphaUnit);
    ellipse(x, y, rms_scaled*i, rms_scaled*i);
  }
}
