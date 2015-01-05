package states;
import commands.Command;
import commands.Command_Idle;
import commands.Command_Punch;
import commands.Command_Walk;
import haxe.Constraints.FlatEnum;
import types.ECommand;
import types.EDirection;

/**
 * ...
 * @author ragbit
 */
class State_Walk extends State
{
	public static var ID : String = "State_Walk";
	
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
		this.actor.playAnim( Component_Actor.ANIM_WALK, this.direction );
		
		this.setVelocityWithDirection( this.direction );
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
					setVelocityWithDirection( command.direction );
					this.actor.direction = command.direction;
					this.actor.playAnim( Component_Actor.ANIM_WALK, command.direction );
				}
			case ECommand.idle:
				{
					//trace( "command idle recieved" );
					var command : Command_Idle = cast( l_command, Command_Idle );
					this.actor.changeState( State_Idle.ID, { direction : this.actor.direction } );
				}
			case ECommand.punch:
				{
					var command : Command_Punch = cast( l_command, Command_Punch );
					this.actor.changeState( State_Punch.ID, { direction : this.actor.direction } );
				}
			default:
		}
	}
	
	private function setVelocityWithDirection( l_direction : Int ) : Void {		
		var vx : Float = 0;
		var vy : Float = 0;
		var speed : Float = 100;
		
		
		if ( ( l_direction & EDirection.right ) != 0 ) {
			vx = speed;
		} else if ( ( l_direction & EDirection.left ) != 0 ) { 
			vx = -speed;
		}
		
		if ( ( l_direction & EDirection.down ) != 0 ) {
			vy = speed;
		} else if ( ( l_direction & EDirection.up ) != 0 ) {
			vy = -speed;
		}
		
		this.actor.vx = vx;
		this.actor.vy = vy;
	}
}