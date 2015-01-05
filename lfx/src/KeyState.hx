package ;
import flambe.input.Key;
import haxe.Timer;

/**
 * ...
 * @author ragbit
 */
class KeyState
{
	public var key( default, default ) : Key;
	public var isDown( get_isDown, set_isDown ) : Bool;
	public var isJustDown( get_isJustDown, null ) : Bool;
	public var isJustUp( get_isJustUp, null ) : Bool;
	
	private var isDown_ : Bool = false;
	private var wasDown_ : Bool = false;
	private var isJustDown_ : Bool = false;
	private var isJustUp_ : Bool = false;
	private var startTime_ : Float = 0;
	private var endTime_ : Float = 0;
	
	public function new( l_key : Key ) {
		this.key = l_key;
	}
	
	public function get_isDown() : Bool {	
		return this.isDown_;
	}
	
	public function set_isDown( v : Bool ) : Bool {
		if ( v && !this.isDown_ ) {
			startTime_ = Date.now().getTime();
		} else if ( !v && this.isDown_ ) {
			endTime_ = Date.now().getTime();
		}
		this.isDown_ = v;
		
		//trace( "key " + this.key + ( this.isDown_? " is down " : " is up " ) );
		//trace( "start time : " + startTime_ + ", end time: " + endTime_ + ", duration: " + ( endTime_ - startTime_ ) );
		
		return this.isDown_;
	}
	
	public function get_isJustDown() : Bool {
		return isJustDown_;
	}
	
	public function get_isJustUp() : Bool {
		return isJustUp_;
	}
	
	public function update( dt : Float ) : Void {
		this.isJustDown_ = ( this.isDown_ && !this.wasDown_ );
		this.isJustUp_ = ( !this.isDown_ && this.wasDown_ );
		//trace( "info: " + this.isDown_ + ", " + this.wasDown_ );
		this.wasDown_ = this.isDown_;
		
		//if ( this.isJustDown_ ) {
			//trace( "just down!" );
		//}
		//if ( this.isJustUp_ ) {
			//trace( "just up!" );
		//}
	}
}