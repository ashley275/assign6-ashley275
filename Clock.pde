class Clock extends Item {

  void display(){
    if(isAlive) image(clock, x, y, w, h);
  }

  void checkCollision(Player player){
    if(!isAlive) return;
    
    if(isHit(x, y, w, h, player.x, player.y, player.w, player.h)){         
      addTime(CLOCK_BONUS_SECONDS);
      isAlive = false;
    }
    
  }
  
  Clock(float x, float y){
   super(x, y); 
  }
}
