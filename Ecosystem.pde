public class Ecosystem{
	
	private int generationNumber;
	private Creature[] population;
	private float totalScore;
	private int fittestIndex;
	private int minStep = 1000;
	private String string1, string2;

	public Ecosystem(int n){
		population = new Creature[n];
		for(int i = 0; i < population.length; i++){
			population[i] = new Creature();
		}
		generationNumber = 0;
		string1 = "";
		string2 = "";
	}

	public void show(){
		for(Creature i:population)
			i.show();
	}

	public void update(){
		for(int i = 0; i < population.length; i++){
			if(population[i].getDNA().getBranch() > minStep){
				population[i].kill();
			}else{
				population[i].update();
			}
		}
	}

	public void checkCollision(obstacle block){
		for(int i =0; i < population.length; i++){
			population[i].checkCollision(block);
		}
	}

	public void calculateScores(){
		for(Creature i: population)
			i.calculateScore();
	}

	public boolean allDead(){
		for(int i = 0; i < population.length; i++){
			if(population[i].getLive() && !population[i].getFoundFood()){
				return(false);
			}
		}
		return(true);
	}

	public void passGenes(){
		totalScore = 0;
		//creates new array of creatures that are going to be selected based on score
		Creature[] nextGeneration = new Creature[population.length];
		
		//adds up total score of entire generation
		for(int i = 0; i < population.length; i++){
			totalScore+=population[i].getScore();
		}
		findChampion();

		nextGeneration[0] = population[fittestIndex].getBaby();
		nextGeneration[0].becomeAscended();
		for(int i = 1; i<population.length; i++){
			Creature parent = selectParent();
			nextGeneration[i] = parent.getBaby();
		}
		population = nextGeneration.clone();
		generationNumber++;
	}

	public Creature selectParent(){
		float luckyNumber = random(totalScore);
		float currentSum = 0;
		for(int i = 0; i < population.length; i++){
			currentSum += population[i].getScore();
			if(currentSum >= luckyNumber)
				return(population[i]);
		}
		return(null);
	}

	public void mutate(){
		for(int i = 1; i < population.length; i++){
			population[i].mutate();
		}
	}
	public void findChampion(){
		float check = 0;
		int champIndex = 0;
		for(int i = 0; i < population.length; i++){
			if(population[i].getScore() > check){
				check = population[i].getScore();
				champIndex = i;	
			}
		}
		fittestIndex = champIndex;
		
		if(population[fittestIndex].getFoundFood() == true){
			minStep = population[fittestIndex].getDNA().getBranch();
		}
		string1 = ("Champion's index: " + fittestIndex + " Steps: " + population[fittestIndex].getDNA().getBranch());
		string2 = ("Highest Score: " + population[fittestIndex].getScore());
	}

	public int getGenerationNumber(){return(generationNumber);}
	public Creature[] getPopulation(){return(population);}
	public int getFittestIndex(){return(fittestIndex);}
	private String gets1(){return(string1);}
	private String gets2(){return(string2);}
}