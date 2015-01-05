package;

import flambe.Entity;
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

class Component_Empty extends Component
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
	}
}