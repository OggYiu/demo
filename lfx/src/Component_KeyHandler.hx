package ;
import flambe.Component;
import flambe.Disposer;
import flambe.input.Key;
import flambe.input.KeyboardEvent;
import flambe.System;
import flambe.util.SignalConnection;
import types.EControlCommand;

/**
 * ...
 * @author ragbit
 */
class Component_KeyHandler extends Component
{
	//private var actor( get_actor, null ) : Component_Actor = null;
	//private var signal( default, null ) : SignalConnection = null;
	private var disposer( default, null ) : Array<SignalConnection> = null;
	private var keyStates( default, null ) : Map<Key, KeyState> = null;
	private var keySettings( default, null ) : Map<String, Array<Key>> = null;
	public var isAnyKeyJustDown( get_isAnyKeyJustDown, null ) : Bool;
	public var isAnyKeyJustUp( get_isAnyKeyJustUp, null ) : Bool;
	
	private var isAnyKeyJustDown_ : Bool = false;
	private var isAnyKeyJustUp_ : Bool = false;
	
	public function new() {
		super();
		
		this.disposer = new Array<SignalConnection>();
		this.keyStates = new Map<Key, KeyState>();
		this.keySettings = new Map<String, Array<Key>>();
		
		this.addKeySettings( EControlCommand.WALK_LEFT, [Key.Left, Key.A] );
		this.addKeySettings( EControlCommand.WALK_RIGHT, [Key.Right, Key.D] );
		this.addKeySettings( EControlCommand.WALK_UP, [Key.Up, Key.W] );
		this.addKeySettings( EControlCommand.WALK_DOWN, [Key.Down, Key.S] );
		this.addKeySettings( EControlCommand.PUNCH, [Key.Space] );
	}
	
	private function addKeySettings( l_name : String, l_keys : Array<Key> ) {
		this.keySettings[l_name] = l_keys;
	}
	
	override public function onAdded() : Void {
		super.onAdded();	
		
		this.disposer.push( System.keyboard.up.connect( onKeyUp ) );
		this.disposer.push( System.keyboard.down.connect( onKeyDown ) );
	}
	
	override public function dispose() {
		super.dispose();
		
		for ( signal in this.disposer ) {
			signal.dispose();
		}
		this.disposer = null;
	}
	
	override public function onUpdate(dt:Float) : Void {
		super.onUpdate(dt);
	
		isAnyKeyJustDown_ = false;
		isAnyKeyJustUp_ = false;
		
		for ( state in this.keyStates ) {
			state.update( dt );
			
			if ( state.isJustDown ) {
				isAnyKeyJustDown_ = true;
			}
			
			if ( state.isJustUp ) {
				isAnyKeyJustUp_ = true;
			}
		}
	}

	private function onKeyUp( event : KeyboardEvent ) : Void {
		var keyState : KeyState = this.keyStates[event.key];
		if ( keyState == null ) {
			keyState = this.keyStates[event.key] = new KeyState( event.key );
		}
		keyState.isDown = false;
		
		// release
		//this.keyStates.remove( event.key );
	}

	private function onKeyDown( event : KeyboardEvent ) : Void {
		var keyState : KeyState = this.keyStates[event.key];
		if ( keyState == null ) {
			keyState = this.keyStates[event.key] = new KeyState( event.key );
		}
		keyState.isDown = true;
	}
	
	public function isKeyDown( key : Key ) : Bool {
		var keyState : KeyState = this.keyStates[key];
		if ( keyState == null ) {
			return false;
		}
		return keyState.isDown;
	}
	
	public function isKeyJustDown( key : Key ) : Bool {
		var keyState : KeyState = this.keyStates[key];
		if ( keyState == null ) {
			return false;
		}
		return keyState.isJustDown;
	}
	
	public function isKeyJustUp( key : Key ) : Bool {
		var keyState : KeyState = this.keyStates[key];
		if ( keyState == null ) {
			return false;
		}
		return keyState.isJustUp;
	}
	
	public function isCommandKeyJustDown( l_name : String ) : Bool {
		var keys : Array<Key> = this.keySettings[l_name];
		if ( keys == null ) {
			return false;
		}
		for ( key in keys ) {
			var keyState : KeyState = this.keyStates[key];
			if ( keyState == null ) {
				continue;
			}
			if ( keyState.isJustDown ) {
				return true;
			}
		}
		
		return false;
	}
	
	public function isCommandKeyJustUp( l_name : String ) : Bool {
		var keys : Array<Key> = this.keySettings[l_name];
		if ( keys == null ) {
			return false;
		}
		for ( key in keys ) {
			var keyState : KeyState = this.keyStates[key];
			if ( keyState == null ) {
				continue;
			}
			if ( keyState.isJustUp ) {
				return true;
			}
		}
		
		return false;
	}
	
	public function isCommandKeyDown( l_name : String ) : Bool {
		var keys : Array<Key> = this.keySettings[l_name];
		if ( keys == null ) {
			return false;
		}
		for ( key in keys ) {
			var keyState : KeyState = this.keyStates[key];
			if ( keyState == null ) {
				continue;
			}
			if ( keyState.isDown ) {
				return true;
			}
		}
		
		return false;
	}
	
	private function get_isAnyKeyJustDown() : Bool {	
		return isAnyKeyJustDown_;
	}
	
	private function get_isAnyKeyJustUp() : Bool {
		return isAnyKeyJustUp_;
	}
}