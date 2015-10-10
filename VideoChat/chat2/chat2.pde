
import java.io.*;
import java.awt.image.*;
import javax.imageio.*;
import hypermedia.net.*;

import java.net.URLEncoder;

import jp.nyatla.nyar4psg.*;  // ARToolKit
import processing.video.*;    // ビデオライブラリ
import saito.objloader.*;     // objローダ

Capture     cam;   // キャプチャ
MultiMarker ar;    // ARマーカに関する処理をするオブジェクト
int         id;    // マーカに割り当てられるID番号
OBJModel model0; // 3Dモデル 
OBJModel model1;
OBJModel model2;
OBJModel model3;

final int PORT = 6000;

UDP udp;
PImage video;

PFont font;
int day = 0;
//↓相対パスだと動作しなかったので絶対パスにしました．パスの設定をお願いいたします．
//全部で4箇所あります．
String[] lines = loadStrings("C:/webserver/htdocs/CMPhappyou/OpenWeather/owResult.txt");
String typing = "";
String saved = "";

PrintWriter writer;

int f=0;
void setup() {
  //こちらもパスの設定をよろしくお願いいたします．
  writer = createWriter("C:/webserver/htdocs/CMPhappyou/OpenWeather/chat.txt");

  for (int i = 0; i < lines.length; i++) {
    println(lines[i]);
  }
  if (lines[day].equals("sky is clear") == true) {
    f = 0;
  }
  if (lines[day].indexOf("cloud") >= 0) {
    f = 1;
  }
  if (lines[day].indexOf("rain") >= 0) {
    f = 2;
  }
  if (lines[day].indexOf("snow") >= 0) {
    f = 3;
  }
  //f=int(random(4));
  size(640, 480, P3D);

  ar = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  ar.addNyIdMarker(0, 30);

  udp = new UDP(this, PORT);
  udp.listen(true);

  video = createImage(640, 480, RGB);

  model0 = new OBJModel(this, "sun.obj", "absolute", POLYGON);
  model0.scale(20);
  model0.translateToCenter();
  model1 = new OBJModel(this, "cloud.obj", "absolute", POLYGON);
  model1.scale(30);
  model1.translateToCenter();
  model2 = new OBJModel(this, "rain.obj", "absolute", POLYGON);
  model2.scale(25);
  model2.translateToCenter();
  model3 = new OBJModel(this, "snow.obj", "absolute", POLYGON);
  model3.scale(40);
  model3.translateToCenter();
  noStroke();
  println(f);

  font = createFont("MSゴシック", 16, true);

  try {
    println(sketchPath);
    //パスの設定をよろしくお願いいたします．
    FileWriter output = new FileWriter("C:/webserver/htdocs/CMPhappyou/OpenWeather/chat.txt", true);
    output.write("\n");
    output.flush();
    output.close();
  }
  catch(IOException e) {
    println("It broke!!!");
    e.printStackTrace();
  }
}

void draw() {
  image(video, 0, 0);
  //cam.read();                           // カメラ画像の読み込み
  background(0);                        // 画面の初期化
  ar.drawBackground(video);               // 背景画像の描画
  ar.detect(video);                       // マーカ認識

  lights(); // ライティング
  if ( ar.isExistMarker(id) ) {
    ar.beginTransform(id);
    translate(0, 0, 20);  // 3Dオブジェクトの表示位置の調整
    rotateX(radians(-90));
    //box(40);
    if (f==0) {
      model0.draw();
    }
    if (f==1) {
      model1.draw();
    }
    if (f==2) {
      model2.draw();
    }
    if (f==3) {
      model3.draw();
    }// 3Dオブジェクトの描画
    ar.endTransform();
  }

  //noStroke();
  fill(255, 255, 255, 100);
  rect(20, height-80, width-40, 60);
  fill(180, 180, 255);
  for (int i=0; i<4; i++) {
    ellipse(50+60*i, height-50, 50, 50);
  }
  textSize(30);
  textAlign(CENTER, CENTER);
  if (day == 0) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  text("1", 50, height-50);
  if (day == 1) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  text("2", 50+60*1, height-50);
  if (day == 6) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  text("7", 50+60*2, height-50);
  if (day == 13) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  text("14", 50+60*3, height-50);
  textAlign(LEFT, CENTER);
  text(typing, 300, height-50);
}

void mousePressed() {
  if (dist(mouseX, mouseY, 50, height-50)<=25) {
    day = 0;
    if (lines[day].equals("sky is clear") == true) {
      f = 0;
    }
    if (lines[day].indexOf("cloud") >= 0) {
      f = 1;
    }
    if (lines[day].indexOf("rain") >= 0) {
      f = 2;
    }
    if (lines[day].indexOf("snow") >= 0) {
      f = 3;
    }
  }
  if (dist(mouseX, mouseY, 110, height-50)<=25) {
    day = 1;
    if (lines[day].equals("sky is clear") == true) {
      f = 0;
    }
    if (lines[day].indexOf("cloud") >= 0) {
      f = 1;
    }
    if (lines[day].indexOf("rain") >= 0) {
      f = 2;
    }
    if (lines[day].indexOf("snow") >= 0) {
      f = 3;
    }
  }
  if (dist(mouseX, mouseY, 170, height-50)<=25) {
    day = 6;
    if (lines[day].equals("sky is clear") == true) {
      f = 0;
    }
    if (lines[day].indexOf("cloud") >= 0) {
      f = 1;
    }
    if (lines[day].indexOf("rain") >= 0) {
      f = 2;
    }
    if (lines[day].indexOf("snow") >= 0) {
      f = 3;
    }
  }
  if (dist(mouseX, mouseY, 230, height-50)<=25) {
    day = 13;
    if (lines[day].equals("sky is clear") == true) {
      f = 0;
    }
    if (lines[day].indexOf("cloud") >= 0) {
      f = 1;
    }
    if (lines[day].indexOf("rain") >= 0) {
      f = 2;
    }
    if (lines[day].indexOf("snow") >= 0) {
      f = 3;
    }
  }
}

void keyPressed() {
  if (key == '\n' ) {
    saved = typing;
    try {
      println(sketchPath);
      //パスの設定をよろしくお願いいたします．
      FileWriter output = new FileWriter("C:/webserver/htdocs/CMPhappyou/OpenWeather/chat.txt", true);
      output.write(saved + "<br>");
      output.flush();
      output.close();
    }
    catch(IOException e) {
      println("It broke!!!");
      e.printStackTrace();
    }
    typing = "";
  } else if (key == '\b') {
    int len = typing.length();
    if (typing.equals("")) {
      typing = "";
    } else {
      typing = typing.substring(0, len-1);
    }
  } else {
    typing = typing + key;
  }
}

void receive(byte[] data) {
  video.loadPixels();

  ByteArrayInputStream bais = new ByteArrayInputStream(data);

  try {
    ImageIO.read(bais).getRGB(0, 0, video.width, video.height, video.pixels, 0, video.width);
  }
  catch (Exception e) {
    e.printStackTrace();
  }

  video.updatePixels();
}

