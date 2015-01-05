package ;

/**
 * ...
 * @author ragbit
 */
class Helper
{
	public static function assert( cond : Bool, msg : String ) : Void {
		if ( !cond ) {
			throw msg;
		}
	}
}