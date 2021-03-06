// stolen from https://processing.org/examples/scrollbar.html
class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  float value;
  float min_value;
  float max_value; 
  String title;
  int text_yoffset = 5;
  int title_yoffset = 20; // yoffset putting the title above the current value
  int num_of_decimals = 2; // how accurate the value should be
  
  HScrollbar (float xp, float yp, int sw, int sh, int l, float min_value, float max_value, float starting_value, String title) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
    this.min_value = min_value;
    this.max_value = max_value;
    
    this.title = title;
    setCurrentValue(starting_value);
  }
  void setCurrentValue(float x){
    //given default value and min max, find percentage of value that it represents, assign spos
    spos = sposMin + (x*(sposMax- sposMin))/(max_value - min_value);
    newspos = spos;
  }
  void drawText() {
    push();
    translate(0, -text_yoffset);
    push();
    fill(255);
    // draw min value
     text(str(min_value), xpos, ypos);
    // draw max_value
    push();
    textAlign(RIGHT);
    text(str(max_value), xpos + swidth, ypos);
    pop();
    //draw curr value
    //round to nearest power of 10
    float rounded_value = float(floor(value*pow(10, num_of_decimals))) / pow(10, num_of_decimals);
    text(str(rounded_value), xpos + swidth/2, ypos);
    
    //draw title
    translate(0, -title_yoffset);
    text(title, xpos + swidth/2, ypos);
    pop();
    pop();
  }
  
  void calcValue(){
    value = min_value + ((max_value - min_value) * (spos - sposMin) / (sposMax - sposMin));
    
}
  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
    calcValue();
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    push();
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
    pop();
    //draw text
    drawText();
    // returns percentage for UI to change doll paramaters
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
