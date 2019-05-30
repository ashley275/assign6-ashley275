class Robot extends Enemy {

  final int PLAYER_DETECT_RANGE_ROW = 2;
  final int LASER_COOLDOWN = 180;
  final int HAND_OFFSET_Y = 37;
  final int HAND_OFFSET_X_FORWARD = 64;
  final int HAND_OFFSET_X_BACKWARD = 16;

  float speed = 2f;  
  float currentSpeed = speed;
  boolean checkX = false, checkY = false;
  int laserTimer = LASER_COOLDOWN;
  
  final int FORWARD = 1, BACKWARD = -1;
  int direction = FORWARD;
  float imageDirection = 0;
  int handOffsetX = HAND_OFFSET_X_FORWARD;
  
  Laser laser;
  
  void checkCollision(Player player){
    super.checkCollision(player);
    laser.checkCollision(player);
  }

  void display(){
    pushMatrix();
    translate(x, y);
    scale(direction, 1);
    image(robot, imageDirection, 0);
    popMatrix();
    
    laser.display();
  }
  
  void update(){
    checkX = ((direction == FORWARD && x + HAND_OFFSET_X_FORWARD <= player.x) ||
              (direction == BACKWARD && x + HAND_OFFSET_X_BACKWARD >= player.x)) ? true : false;
    
    checkY = (y / SOIL_SIZE + PLAYER_DETECT_RANGE_ROW >= player.row && 
              y / SOIL_SIZE - PLAYER_DETECT_RANGE_ROW <= player.row) ? true : false;
    
    if(checkX && checkY){      
      currentSpeed = 0;
      
      if(laserTimer == LASER_COOLDOWN){
        laser.fire(x + handOffsetX, y + HAND_OFFSET_Y, player.x + w/2, player.y + h/2);
        laserTimer--;
      }else if(laserTimer > 0) laserTimer--;
      else if(laserTimer == 0) laserTimer = LASER_COOLDOWN;
        
    }else{
      currentSpeed = speed;
      laserTimer = LASER_COOLDOWN;
    }
    laser.update();
    
    switch(direction){
      case FORWARD:
      x += currentSpeed;
      if(x >= width - w){
        direction = BACKWARD;
        imageDirection = -w;
        handOffsetX = HAND_OFFSET_X_BACKWARD;
        x = width - w;
      }
      break;
      
      case BACKWARD:
      x -= currentSpeed;
      if(x <= 0){
        direction = FORWARD;
        imageDirection = 0;
        handOffsetX = HAND_OFFSET_X_FORWARD;
        x = 0;
      }
      break;
    }    
  }
  
  Robot(float x, float y){
   super(x, y);
   laser = new Laser();
  }
}
