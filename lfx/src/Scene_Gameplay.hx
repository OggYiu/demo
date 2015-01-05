package;

import flambe.Entity;
import flambe.swf.MoviePlayer;
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
import states.State_Idle;
import states.State_Punch;
import states.State_Walk;
import types.EDirection;

class Scene_Gameplay
{
	public var scene( default, null ) : Entity;
	
	public function new( l_parent : Entity ) {
		this.scene = new Entity();
		
		spawnEntity( 100, 100 );
		
		//{
			//var entity : Entity = new Entity();
			//var player : MoviePlayer = new MoviePlayer( Kernel.getInstance().lib );
			//player.loop( "", true ).play( Component_Actor.ANIM_PUNCH, true );
			////player.play( Component_Actor.ANIM_PUNCH, false );
			//entity.add( player );
			//this.scene.addChild( entity );
		//}
		
		l_parent.addChild( this.scene );
	}
	
	public function spawnEntity( l_x : Float, l_y : Float ) : Entity {
		{
			var entity : Entity = new Entity();
			
			entity.add( new Component_Actor( l_x, l_y )
							.addState( State_Idle.ID, new State_Idle() )
							.addState( State_Walk.ID , new State_Walk() )
							.addState( State_Punch.ID , new State_Punch() )
							.changeState( State_Idle.ID, { direction : EDirection.right } ) );
			
			this.scene.addChild( entity );
			
			Kernel.getInstance().setPlayer( entity.get( Component_Actor ) );
			
			return entity;
		}
	}
}