public class obstacle{
	
	private PVector position;
	private boolean on;

	public obstacle(int x, int y){
		position = new PVector(x*100,y*100);
		on = false;
	}

	public void show(){
		if(on){
			fill(135,206,250);
			rect(position.x, position.y, 100, 100);
		}
	}

	public void turnOn(){on = true;}
	public boolean getOn(){return(on);}
	public PVector getPosition(){return(position);}
}