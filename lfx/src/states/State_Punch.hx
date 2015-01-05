package states;
import commands.Command;

/**
 * ...
 * @author ragbit
 */
class State_Punch extends State
{
	public static var ID : String = "State_Punch";
	private var direction( default, null ) : Int = 0;
	
	public function new() {
		super();
	}
	
	override public function enter( l_params : Dynamic ) : Void {
		super.enter( l_params );
		this.direction = l_params.direction;
	}
	
	override public function dispose () : Void {
		super.dispose();
	}

	override public function onAdded () : Void {
		super.onAdded();
		
		this.actor.direction = this.direction;
		this.actor.vx = 0;
		this.actor.vy = 0;
		this.actor.playAnim( Component_Actor.ANIM_PUNCH, this.actor.direction );
	}
	
	override public function onUpdate (dt :Float) : Void {
		super.onUpdate( dt );
	}
	
	override public function commandHandler( command : Command ) : Void {
		super.commandHandler( command );
	}
}