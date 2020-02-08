/*
*
 *
 * ULTRA SIMPLE IMPLEMENTATION OF SPOUT AND KEYSTONE LIBRARIES TOGHETHER
 *
 *
 */

import deadpixel.keystone.*;

Keystone ks;
CornerPinSurface surface;
// IMPORT THE SPOUT LIBRARY
import spout.*;
// DECLARE A SPOUT OBJECT
Spout spout;
PImage img; // Image to receive a texture



PGraphics offscreen;

void setup() {
  fullScreen(P3D);



  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20);

  // We need an offscreen buffer to draw the surface we
  // want projected
  // note that we're matching the resolution of the
  // CornerPinSurface.
  // (The offscreen buffer can be P2D or P3D)

  offscreen = createGraphics(width, height, P3D);
  // CREATE A NEW SPOUT OBJECT
  spout = new Spout(this);
  img = createImage(width, height, ARGB);
}

void draw() {

  // Convert the mouse coordinate into surface coordinates
  // this will allow you to use mouse events inside the 
  // surface from your screen. 
  PVector surfaceMouse = surface.getTransformedMouse();
  img = spout.receivePixels(img);

  // Draw the scene, offscreen
  offscreen.beginDraw();
  offscreen.background(255);
  offscreen.fill(0, 255, 0);
  offscreen.ellipse(surfaceMouse.x, surfaceMouse.y, 75, 75);
  offscreen.image(img, 0, 0, width, height);
  offscreen.endDraw();
  // most likely, you'll want a black background to minimize
  // bleeding around your projection area
  background(0);

  // render the scene, transformed using the corner pin surface
  surface.render(offscreen);
}

void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 's':
    // saves the layout
    ks.save();
    break;
  }
}
