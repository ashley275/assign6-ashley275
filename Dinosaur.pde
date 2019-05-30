class Dinosaur extends Enemy {

  final float TRIGGERED_SPEED_MULTIPLIER = 5f;
  float speed = 1f;
  final int FORWARD = 1, BACKWARD = -1;
  int direction = FORWARD;
  float imageDirection = 0;

  void display(){
    pushMatrix();
    translate(x, y);
    scale(direction, 1);
    image(dinosaur, imageDirection, 0);
    popMatrix();
  }
  
  void update(){
    float currentSpeed = speed;
    
    if(y == player.y){
      if(direction == FORWARD && x + w <= player.x + player.w/2
      || direction == BACKWARD && x  >= player.x + player.w/2){
        
        currentSpeed = TRIGGERED_SPEED_MULTIPLIER;        
      }      
    }
    
    switch(direction){
      case FORWARD:
      x += currentSpeed;
      if(x >= width - w){
        direction = BACKWARD;
        imageDirection = -w;
        x = width - w;
      }
      break;
      
      case BACKWARD:
      x -= currentSpeed;
      if(x <= 0){
        direction = FORWARD;
        imageDirection = 0;
        x = 0;
      }
      break;
    }    
  }
  
  Dinosaur(float x, float y){
   super(x, y); 
  }
}
