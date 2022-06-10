class UI{
  float platform_height;
  HScrollbar center_of_mass, gravity, starting_angle, rolling_friction;
  StringList events;
  PImage protractor;
  Button play_pause;
  Button exit;
  Doll doll;
  int protractor_yoffset = 11; //how many pixels the center of the measuring thingy is from the bottom of image
  ArrayList<Button> ButtonList;
  ArrayList<HScrollbar> ScrollbarList;
  UI(float platform_height, Doll doll){
    ButtonList = new ArrayList<Button>();
    ScrollbarList = new ArrayList<HScrollbar>();
    events = new StringList();
    this.platform_height = platform_height;
    this.doll = doll;
    //min value, 
    // not quite sure what to do with this: suggestionss touching base, max, top of structure
    center_of_mass = new HScrollbar(2*width /3, (height - platform_height) * .3 + platform_height, round(.25 * width), 16, 16, 0, 1);
    //min value, 0 no gravity, max ~3 times earth gravity
    gravity = new HScrollbar(2*width /3, (height - platform_height) * .6 + platform_height, round(.25 * width), 16, 16, 0, 3 * 9.81);
    starting_angle = new HScrollbar(width /3, (height - platform_height) * .3 + platform_height, round(.25 * width), 16, 16, 0 , 180); 
    // not sure start with 0 and twice the rollingFrictionConstant that the doll starts with
    rolling_friction = new HScrollbar(width /3, (height - platform_height) * .6 + platform_height, round(.25 * width), 16, 16, 0, doll.rollingFrictionConstant *2);   
    ScrollbarList.add(center_of_mass);
    ScrollbarList.add(gravity);
    ScrollbarList.add(starting_angle);
    ScrollbarList.add(rolling_friction);
    //min max values for sliders
    
    
    //draw stop/play functions
    play_pause = new Button(150, 50, "go", "reset");
    play_pause.normal = loadImage("play.png");
    play_pause.toggled = loadImage("reset.png");
    ButtonList.add(play_pause);
    protractor = loadImage("protractor (2).png");
    int margin = 10;
    exit = new Button("NE", width, 0, "exit", "exit", margin);
    exit.normal = loadImage("exit.png");
    exit.toggled = loadImage("exit.png");
    ButtonList.add(exit);
  }
  
  void reset_events(){
    events = new StringList();
  }
  
  void draw(float time){
    push();
    //draw platform
    fill(0);
    rect(0, platform_height, width, height);
    
    
    //draw time
    fill(0);
    textSize(30);
    time = float(int(time * 1000))/1000;
    textAlign(LEFT,TOP);
    text(str(time), 0, 0);
    pop();
    for(int i=0; i < ButtonList.size(); i ++){
      ButtonList.get(i).update();
    }
  }
  
  void draw_background(String status){
    if (status == "setup"){
      draw_setupUI();
    }
  }
  
  void draw_setupUI(){
    push();
    fill(0);
    imageMode(CENTER);
    image(protractor, width/2, platform_height - doll.protractor_radius/2 - protractor_yoffset, 2*doll.protractor_radius, doll.protractor_radius);
    for(int i=0; i < ScrollbarList.size(); i ++){
      //draw sliders for variables
      ScrollbarList.get(i).update();
      ScrollbarList.get(i).display();
    }
    //set angle of doll using slider
    doll.angle = starting_angle.value * PI / 180;

    pop();
  }
  
  void testClick(){
    for(int i=0; i < ButtonList.size(); i ++){
      ButtonList.get(i).isPressed(events);
    }
  }
}
