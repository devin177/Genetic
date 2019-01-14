public class Creature{
	private PVector position, velocity, acceleration;
	private DNA genetics;
	private boolean live;
	private float score;
	private boolean foundFood;
	private boolean ascended;
	private boolean diedToWall;

	public Creature(){
		live = true;
		position = new PVector(width/2, height-20);
		velocity = new PVector(0,0);
		acceleration = new PVector(0,0);
		genetics = new DNA(1000);
		score = 0;
		ascended = false;
		foundFood = false;
		diedToWall = false;
	}

	public void show(){
		if(ascended){
			fill(0,0,255);
			ellipse(position.x, position.y, 20, 20);
		}else{
			fill(255,0,0);
			ellipse(position.x, position.y, 10,10);
		}	
	}
	
	public void move(){
		position.add(velocity);
		velocity.add(acceleration);
		velocity.limit(10);
		if(genetics.getForces().length > genetics.getBranch()){
			acceleration = genetics.getForces()[genetics.getBranch()];
			genetics.setBranch(1);
		}else{
			live = false;
		}
	}

	public void update(){
		if(live && !foundFood)
			move();
		if(position.x < 5 || position.x > width-5 || position.y < 5 || position.y > height-5)
			live = false;
		if(dist(position.x,position.y,food.x,food.y) <= 20){
			foundFood = true;
		}
	}

	public void checkCollision(obstacle block){
		if(block.getOn() && position.x > block.getPosition().x && position.x < block.getPosition().x + 100 && position.y > block.getPosition().y && position.y < block.getPosition().y +100){
			kill();
			diedToWall = true;
		}
	}
	public void calculateScore(){
		float separation = dist(position.x,position.y,food.x,food.y);
		if(foundFood){
			score = 1000/((float)genetics.getBranch());
		}else if(diedToWall){
			score = 0.01 * (1.0/(separation*separation));
		}else{
		score = 1.0/(separation*separation);
		}
	}

	public Creature getBaby(){
		Creature baby = new Creature();
		baby.setDNA(genetics.clone());
		return(baby);
	}

	public void mutate(){
		float mutateChance = .05;
		for(int temp = 0; temp < genetics.getForces().length; temp++){
			float luckOfTheDraw = random(1);
			if(luckOfTheDraw <= mutateChance){
				float angle = random(2*PI);
				genetics.setForces(temp, PVector.fromAngle(angle));
			}
		}
	}

	public void becomeAscended(){
		ascended = true;
	}

	public boolean getFoundFood(){return(foundFood);}
	public boolean getLive(){return(live);}
	public float getScore(){return(score);}
	public DNA getDNA(){return(genetics);}
	public void setDNA(DNA genes){genetics = genes;}
	public void kill(){live = false;}
}
