class Cabbage extends Item {

  void display(){
    if(isAlive) image(cabbage, x, y);
  }

  void checkCollision(Player player){
    if(!isAlive) return;
    
    if(player.health < player.PLAYER_MAX_HEALTH
    && isHit(x, y, w, h, player.x, player.y, player.w, player.h)){   
      player.health ++;
      isAlive = false;
    }
  }
  
  
  Cabbage(float x, float y){
   super(x, y); 
  }
}
