package states;

import commands.Command;

/**
 * ...
 * @author ragbit
 */
class State_Empty extends State
{
	public static var ID : String = "State_Empty";
	
	public function new() {
		super();
	}
	
	override public function enter( l_params : Dynamic ) : Void {
		super.enter( l_params );
	}
	
	override public function dispose () : Void {
		super.dispose();
	}

	override public function onAdded () : Void {
		super.onAdded();
	}
	
	override public function onUpdate (dt :Float) : Void {
		super.onUpdate( dt );
	}
	
	override public function commandHandler( command : Command ) : Void {
		super.commandHandler( command );
	}
}