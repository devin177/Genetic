public class DNA{
	
	private PVector[] forces;
	private int branch = 0;

	//Constructor for DNA where it makes an array with size chosen thru parameter, and fills each index of the array with a random Vector
	public DNA(int weight){
		forces = new PVector[weight];
		fillSequence();

	}

	//turns random angle into vector for all of this DNA's forces
	public void fillSequence(){
		for(int i = 0; i < forces.length; i++){
			float nextAngle = random(2*PI);
			forces[i] = PVector.fromAngle(nextAngle);
		}
	}

	public DNA clone(){
		DNA clone = new DNA(forces.length);
		for(int i = 0; i < forces.length; i++){
			clone.forces[i] = forces[i].copy();
		}
		return(clone);
	}

	//all getter and setter methods
	public int getBranch(){return(branch);}
	public void setBranch(int n){branch+=n;}
	public PVector[] getForces(){return(forces);}
	public void setForces(int i, PVector n){forces[i] = n;}
}