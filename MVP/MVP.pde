//set global variables_
Doll doll;
float frames_per_sec = 60;
float exponential_decay_constant = .002/8;
UI ui;
boolean paused = true;
HScrollbar test;
void setup(){
  //testing scroll bar
    
    size(1500, 1000);//set processing settings
    float platform_height = height * 2/3;
    frameRate(frames_per_sec);
    fill(255);
 //initiate global variables
    ui = new UI(platform_height);
    doll = new Doll(width/2, height * 2/3, platform_height, exponential_decay_constant);
    
 
    doll.angle = PI;
    doll.rollingFrictionConstant = exponential_decay_constant;
}

void draw(){
    background(255);
    ui.draw(doll.time);
    
    if (paused){
      doll.test_held(); 
    }else{
      doll.move(4 / frames_per_sec); // doubled time to make it look pretty, omg we need to fix this later -- JASON XIAOSHEN DONT IGNORE THIS IT WILL BE THE END OF UR GRADES SADGE
    }
    doll.render();
    
    ////respond to all events
    for (int i=0; i < ui.events.size(); i++){
      switch (ui.events.get(i)){
        case "pause":
          paused = true;
          println("pause");
          break;
        case "go":
          paused = false;
          println("go");
          break;
        default:
          println("None");
          break;
      }
    }
    // reset all events
    ui.reset_events();
    //println(mouseX +" , "+ mouseY);
}
void mouseClicked(){
  //println("click");
   ui.testClick();
}
