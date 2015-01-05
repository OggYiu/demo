package states ;
import commands.Command;
import flambe.Component;
import flambe.input.KeyboardEvent;
import flambe.util.SignalConnection;
import flambe.System;

/**
 * ...
 * @author ragbit
 */
class State extends Component
{
	private var actor( get_actor, null ) : Component_Actor;
	
	public function new() {
	}
	
	public function enter( l_params : Dynamic ) : Void {	
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
	
	private function get_actor() : Component_Actor {
		return this.owner.get( Component_Actor );
	}
	
	public function commandHandler( command : Command ) : Void {
	}
}