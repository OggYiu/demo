package commands;

import haxe.macro.Expr.Var;
import types.ECommand;

/**
 * ...
 * @author ragbit
 */
class Command_Idle extends Command
{
	public var actor( default, null ) : Component_Actor = null;
	public var direction( default, null ) : Int;
	
	public function new( l_actor : Component_Actor, l_direction : Int ) {	
		super( ECommand.idle );
		
		this.actor = l_actor;
		this.direction = l_direction;
	}
	
	override public function execute() : Void {
		super.execute();
		this.actor.commandHandler( this );
	}
}