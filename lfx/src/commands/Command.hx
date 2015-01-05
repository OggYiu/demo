package commands;
import types.ECommand;

/**
 * ...
 * @author ragbit
 */
class Command
{
	public var type( default, null ) : ECommand;
	
	public function new( l_type : ECommand ) {
		this.type = l_type;
	}
	
	public function execute() : Void {
	}
}