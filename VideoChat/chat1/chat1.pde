import processing.video.*;

import java.io.*;
import java.awt.image.*;
import javax.imageio.*;
import processing.video.*;
import hypermedia.net.*;

final String IP = "localhost";
//final String IP = "192.168.0.7";
final int PORT = 6000;

UDP udp;
Capture cam;

void setup() {
  size(640, 480);

  udp = new UDP(this, 6100);

  cam = new Capture(this, Capture.list()[0]);
  cam.start();
}

void draw() {
  image(cam, 0, 0);

  if (cam.available()) {
    cam.read();
    broadcast(cam);
  }
}

void broadcast(PImage img) {
  img.loadPixels();

  BufferedImage bimg = new BufferedImage(img.width, img.height, BufferedImage.TYPE_INT_RGB);
  bimg.setRGB(0, 0, img.width, img.height, img.pixels, 0, img.width);

  ByteArrayOutputStream baos = new ByteArrayOutputStream();

  try {
    ImageIO.write(bimg, "jpg", new BufferedOutputStream(baos));
  }
  catch (IOException e) {
    e.printStackTrace();
  }

  udp.send(baos.toByteArray(), IP, PORT);
}
