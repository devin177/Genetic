Ecosystem world;
PVector food;
int previousChampMoves;
obstacle[][] obstacles;

void setup(){
	size(1000,1000);
	food = new PVector(width/2, 30);
	world = new Ecosystem(500);
	obstacles = new obstacle[10][10];
	for(int i = 0; i < 10; i++){
		for(int q = 0; q < 10; q++){
			obstacles[q][i] = new obstacle(q,i);
		}
	}

}

void draw(){
	background(255);

	//drawing obstacles
	strokeWeight(2);
	obstacles[8][4].turnOn();
	obstacles[3][1].turnOn();
	obstacles[4][1].turnOn();
	obstacles[5][1].turnOn();	
	obstacles[6][1].turnOn();
	obstacles[2][3].turnOn();
	obstacles[2][4].turnOn();	
	obstacles[1][5].turnOn();
	obstacles[1][6].turnOn();
	obstacles[2][7].turnOn();	
	obstacles[4][6].turnOn();
	obstacles[5][5].turnOn();
	obstacles[6][4].turnOn();	
	obstacles[7][3].turnOn();
	obstacles[7][7].turnOn();
	obstacles[8][7].turnOn();	
	obstacles[8][6].turnOn();
	obstacles[9][6].turnOn();




	for(int i = 0; i < 10; i++){
		for(int q = 0; q < 10; q++){
			obstacles[q][i].show();
		}
	}	
	//drawing food goal
	strokeWeight(1);
	fill(0,255,0);
	ellipse(food.x,food.y,30,30);

	//coloring red and drawing the world
	world.update();
	world.show();
	for(int i = 0; i < 10; i++){
		for(int q = 0; q < 10; q++){
			world.checkCollision(obstacles[q][i]);
		}
	}

	//announcements
	textSize(32);
	fill(0);
	text("Generation: " + world.getGenerationNumber(), width/4, height/2);
	text(world.gets1(), width/4, height/2 + 50);
	text(world.gets2(), width/4, height/2 + 100);
	//when everyone dies, creates a new generation
	if(world.allDead()){
		world.calculateScores();
		world.passGenes();
		world.mutate();
	}

}