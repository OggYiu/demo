package;

import commands.Command;
import flambe.Entity;
import flambe.System;
import flambe.Component;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.swf.MovieSprite;
import flambe.display.Sprite;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.scene.Director;
import flambe.animation.Ease;
import flambe.scene.SlideTransition;
import flambe.swf.Flipbook;
import flambe.swf.Library;
import hxmath.math.Vector2;
import flambe.input.Key;
import flambe.input.PointerEvent;
import flambe.input.KeyboardEvent;
import states.State;
import types.EDirection;
import types.EFacing;
// import flambe.subsystem.import flambe.input.Key;

class Component_Actor extends Component
{
	public static var ANIM_IDLE : String = "actor1_idle";
	public static var ANIM_WALK : String = "actor1_walk";
	public static var ANIM_PUNCH : String = "actor1_punch";

	public var x( get_x, set_x ) : Float;
	public var y( get_y, set_y ) : Float;
	
	public var velocity( get_velocity, set_velocity ) : Vector2;
	public var vx( get_vx, set_vx ) : Float;
	public var vy( get_vy, set_vy ) : Float;
	
	public var direction( get_direction, set_direction ) : Int;
	public var facing( default, default ) : EFacing;
	
	private var position_ : Vector2 = new Vector2( 0, 0 );
	private var velocity_ : Vector2 = new Vector2( 0, 0 );
	private var direction_ : Int = 0;
		
	private var anims( default, null ) : Map<String, MovieSprite> = null;
	private var currentAnim( default, null ) : MovieSprite = null;
	private var states( default, null ) : Map<String, State> = null;
	private var currentState( default, null ) : State = null;
	private var nextStateName( default, null ) : String = "";
	private var nextStateParams( default, null ) : Dynamic = null;

	public function new( l_x : Float, l_y : Float ) {
		super();
		
		this.anims = new Map<String, MovieSprite>();
		this.states = new Map<String, State>();
		
		this.x = l_x;
		this.y = l_y;
	}

	public function playAnim( l_animName: String, l_direction : Int ) : Void {
		if ( this.currentAnim != null ) {
			this.currentAnim.owner.remove( this.currentAnim );
			this.currentAnim = null;
		}

		this.currentAnim = this.anims[l_animName];
		this.owner.add( this.currentAnim );
		this.currentAnim.anchorX._ = 16;
		this.currentAnim.anchorY._ = 16;
		this.currentAnim.x._ = this.position_.x;
		this.currentAnim.y._ = this.position_.y;
		
		if ( ( l_direction & EDirection.right ) != 0 ) {
			this.facing = EFacing.right;
		} else if ( ( l_direction & EDirection.left ) != 0 ){
			this.facing = EFacing.left;
		}
		
		if ( this.facing == EFacing.right ) {
			this.currentAnim.scaleX._ = -1;
		} else {
			this.currentAnim.scaleX._ = 1;
		}
		//this.currentAnim.y._ = 0;
	}
	
	private function createAnim( l_name : String ) : Void {
		this.anims[l_name] = Kernel.getInstance().lib.createMovie( l_name );
	}
	
	override public function dispose () : Void {
		super.dispose();
	}

	override public function onAdded () : Void {
		super.onAdded();
	
		createAnim( ANIM_IDLE );
		createAnim( ANIM_WALK );
		createAnim( ANIM_PUNCH );

		//playAnim( 2 );
	}

	override public function onRemoved () : Void {
		super.onRemoved();
	}

	override public function onStart () : Void {
		super.onStart();
	}

	override public function onStop () : Void {
		super.onStop();
	}

	override public function onUpdate (dt :Float) : Void {
		super.onUpdate( dt );
		
		if ( this.nextStateName != "" ) {
		trace( "going to state changed 2: " + this.nextStateName + ", params: " + this.nextStateParams );
			changeState_( this.nextStateName, this.nextStateParams );
			this.nextStateName = "";
		}
		
		this.x += dt * this.vx;
		this.y += dt * this.vy;
	}
	
	private function get_x() : Float {
		return position_.x;
	}
	
	private function set_x( l_x : Float ) : Float {
		position_.x = l_x;
		if ( this.currentAnim != null ) {
			this.currentAnim.x._ = l_x;
		}
		return position_.x;
	}
	
	private function get_y() : Float {
		return position_.y;
	}
	
	private function set_y( l_y : Float ) : Float {
		position_.y = l_y;
		if ( this.currentAnim != null ) {
			this.currentAnim.y._ = l_y;
		}
		return position_.y;
	}
	
	private function set_velocity( v : Vector2 ) : Vector2 {
		return ( velocity_ = v );
	}
	
	private function get_velocity() : Vector2 {
		return velocity_;
	}
	
	private function get_vx() : Float {
		return velocity_.x;
	}
	
	private function set_vx( v : Float ) : Float {
		return velocity_.x = v;
	}
	
	private function get_vy() : Float {
		return velocity_.y;
	}
	
	private function set_vy( v : Float ) : Float {
		return velocity_.y = v;
	}
	
	private function set_direction( v : Int ) : Int {
		return ( direction_ = v );
	}
	
	private function get_direction() : Int {
		return direction_;
	}
	
	public function addState( l_name : String, l_state : State ) : Component_Actor {
		this.states[l_name] = l_state;
		return this;
	}
	
	public function changeState( l_name : String, l_params : Dynamic = null ) : Component_Actor {
		trace( "going to state changed: " + l_name + ", params: " + l_params );
		this.nextStateName = l_name;
		this.nextStateParams = l_params;
		return this;
	}
	
	private function changeState_( l_name : String, l_params : Dynamic ) : Void {
		var t_state : State = this.states[l_name];
		if ( t_state != null ) {
			if ( this.currentState != null ) {
				this.owner.remove( this.currentState );
			}
			trace( "state changed: " + l_name + ", params: " + l_params );
			this.currentState = t_state;
			this.currentState.enter( l_params );
			this.owner.add( this.currentState );
		}
	}
	
	public function commandHandler( command : Command ) : Void {
		if ( this.currentState == null ) {
			return;
		}
		
		this.currentState.commandHandler( command );
	}
}