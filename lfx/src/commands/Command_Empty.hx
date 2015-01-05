package commands;

import types.ECommand;

/**
 * ...
 * @author ragbit
 */
class Command_Empty extends Command
{
	public function new() {
		super( ECommand.unknown );
	}
	
	override public function execute() : Void {
		super.execute();
		this.actor.commandHandler( this );
	}
}