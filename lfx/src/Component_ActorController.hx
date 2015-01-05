package ;

import commands.Command_Idle;
import commands.Command_Punch;
import commands.Command_Walk;
import flambe.Entity;
import flambe.input.Key;
import flambe.System;
import flambe.Component;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.Sprite;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.scene.Director;
import flambe.animation.Ease;
import flambe.scene.SlideTransition;
import flambe.swf.Flipbook;
import flambe.swf.Library;
import hxmath.math.Vector2;
import flambe.input.PointerEvent;
import types.EControlCommand;
import types.EDirection;

class Component_ActorController extends Component
{
	public function new() {
		super();
	}
	
	override public function dispose () : Void {
		super.dispose();
	}

	override public function onAdded () : Void {
		super.onAdded();
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
		
		var keyHandler : Component_KeyHandler = Kernel.getInstance().keyHandler;
		var player = Kernel.getInstance().player;
				
		if ( keyHandler.isAnyKeyJustDown ) {
			if (	keyHandler.isCommandKeyJustDown( EControlCommand.WALK_DOWN ) ||
					keyHandler.isCommandKeyJustDown( EControlCommand.WALK_UP ) ||
					keyHandler.isCommandKeyJustDown( EControlCommand.WALK_LEFT ) ||
					keyHandler.isCommandKeyJustDown( EControlCommand.WALK_RIGHT ) ) {
				sendWalkCommand();
			}
			
			if ( keyHandler.isCommandKeyJustDown( EControlCommand.PUNCH ) ) {
				( new Command_Punch( player, player.direction ) ).execute();
			}
		}
		
		if ( keyHandler.isAnyKeyJustUp ) {
			if (	keyHandler.isCommandKeyJustUp( EControlCommand.WALK_DOWN ) ||
					keyHandler.isCommandKeyJustUp( EControlCommand.WALK_UP ) ||
					keyHandler.isCommandKeyJustUp( EControlCommand.WALK_LEFT ) ||
					keyHandler.isCommandKeyJustUp( EControlCommand.WALK_RIGHT ) ) {
				sendWalkCommand();
			}
		}
	}
	
	private function sendWalkCommand() : Void {
		var direction : Int = 0;
		
		var keyHandler : Component_KeyHandler = Kernel.getInstance().keyHandler;
		
		direction |= keyHandler.isCommandKeyDown( EControlCommand.WALK_LEFT )? EDirection.left : direction;
		direction |= keyHandler.isCommandKeyDown( EControlCommand.WALK_RIGHT )? EDirection.right : direction;
		direction |= keyHandler.isCommandKeyDown( EControlCommand.WALK_UP )? EDirection.up : direction;
		direction |= keyHandler.isCommandKeyDown( EControlCommand.WALK_DOWN )? EDirection.down : direction;
		
		var player = Kernel.getInstance().player;
		
		if ( direction != 0 ) {
			( new Command_Walk( player, direction ) ).execute();
		} else { 
			( new Command_Idle( player, player.direction ) ).execute();
		}
	}
}