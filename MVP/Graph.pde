class Graph{
  // needs access to doll, doll doesnt need access to graph
  float time_elapsed = 0;
  ArrayList<Float> values;
  ArrayList<Float> times;
  float max_value, min_value;
  float margin = 5;
  float plot_size = 2;
  color plotColor;
  String title;
  Graph(String title, color plotColor){
    reset();
    this.title = title;
    this.plotColor = plotColor;
  }
 void reset(){
    values = new ArrayList<Float>();
    times = new ArrayList <Float>();
    max_value =0;
    min_value = 0 ;
 }
  
  void plot(float value, float delta_time){
    time_elapsed += delta_time;
    if (value > max_value){
      max_value = value;
    }
    if (value < min_value){
      max_value = value;
    }
    values.add(value);
    times.add(delta_time);
  }
  void render(float x1, float y1, float x2, float y2){
    push();
    //fill background with grey
    fill(125);
    rectMode(CORNERS);
    rect(x1, y1, x2, y2);
    //fill center with white
    fill(225);
    x1 += margin;
    y1 += margin;
    x2 -= margin;
    y2 -= margin;
    float rectHeight = max_value - min_value; 
    rect(x1, y1, x2, y2);
    fill(0);
    // create + display scale
    textAlign(LEFT, CENTER);
    text('-'+str(max_value), x1, y1);
    text('-'+str(min_value), x1, y2);
    // display title
    textAlign(CENTER);
    text(title, (x1 + x2)/2, y1 + margin *2);
    //draw points
    fill(plotColor);
    float cur_index_time = 0;
    for (int i = 0; i < values.size(); i++){
      float ploty = (values.get(i) - min_value) / (max_value - min_value) * rectHeight;
      cur_index_time += times.get(i);
      push();
      translate(x1, y1); // offset to the center of the graph, cause pos + neg
      float plotx = ((cur_index_time / time_elapsed) * (x2 - x1));
      rectMode(CENTER);
      rect(plotx, ploty, plot_size, plot_size);
      pop();
    }
    
    
    pop();
  }
}
