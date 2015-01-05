package states ;
import commands.Command;
import commands.Command_Punch;
import commands.Command_Walk;
import flambe.input.Key;
import flambe.input.KeyboardEvent;
import flambe.util.SignalConnection;
import types.ECommand;

/**
 * ...
 * @author ragbit
 */
class State_Idle extends State
{
	public static var ID : String = "State_Idle";
	public var direction( default, null ) : Int = 0;
	
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
		this.actor.playAnim( Component_Actor.ANIM_IDLE, this.direction );
	}
	
	override public function onUpdate (dt :Float) : Void {
		super.onUpdate( dt );
	}
	
	override public function commandHandler( l_command : Command ) : Void {
		super.commandHandler( l_command );
		
		switch( l_command.type ) {
			case ECommand.walk:
				{
					var command : Command_Walk = cast( l_command, Command_Walk );
					this.actor.changeState( State_Walk.ID, { direction : command.direction } );
				}
			case ECommand.punch:
				{
					var command : Command_Punch = cast( l_command, Command_Punch );
					this.actor.changeState( State_Punch.ID, { direction : this.actor.direction } );
				}
			default:
		}
	}
}