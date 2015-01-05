package;

import flambe.Entity;
import flambe.input.Key;
import flambe.input.KeyboardEvent;
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
import flambe.util.SignalConnection;
import hxmath.math.Vector2;
import flambe.input.PointerEvent;

class Kernel
{
	public var pack( default, null ) : AssetPack;
	public var director( default, null ) : Director;
	public var lib( default, null ) : Library;
	public var sceneLayer( default, null ) : Entity;
	public var player( default, null ) : Component_Actor;
	public var isDebugConsoleEnabled( default, null ) : Bool = false;
	private var disposer( default, null ) : Array<SignalConnection> = null;

	public var keyHandler( default, null ) : Component_KeyHandler = null;
	
	public function new() {
	}
	
	public function create( l_pack : AssetPack ) : Void {
		Console.start();
		
        // Add a solid color background
        var background = new FillSprite(0x202020, System.stage.width, System.stage.height);
        System.root.addChild(new Entity().add(background));

		this.pack = l_pack;
		
        this.director = new Director();
        System.root.add(director);

		System.root.addChild ( ( new Entity() )
			.add( this.keyHandler = new Component_KeyHandler() ) );
			
		System.root.addChild( ( new Entity() )
			.add( new Component_ActorController() ) );
		
		this.sceneLayer = new Entity();
		System.root.addChild( this.sceneLayer );

        this.lib = Library.fromFlipbooks([
            new Flipbook( "actor1_idle", pack.getTexture( "images/actor1_idle" ).split( 1 ) ).setDuration(1),
            new Flipbook( "actor1_walk", pack.getTexture( "images/actor1_walk" ).split( 4 ) ).setDuration(1),
            new Flipbook( "actor1_punch", pack.getTexture( "images/actor1_punch" ).split( 3 ) ).setDuration(0.5),			
        ]);
		
		new Scene_Gameplay( this.sceneLayer );
		
		this.disposer = new Array<SignalConnection>();
		this.disposer.push( System.keyboard.up.connect( onKeyUp ) );
	}
	
	public function removeKeyboardEventListener() {
		for ( signal in this.disposer ) {
			signal.dispose();
		}
		this.disposer = null;
	}

	private function onKeyUp( event : KeyboardEvent ) : Void {
		trace( event.key );
		
		if ( event.key == Key.Backquote ) {
			this.toggleDebugConsole();
		}
	}
	
	public function toggleDebugConsole() : Void {
		this.isDebugConsoleEnabled = !this.isDebugConsoleEnabled;
			
		trace( "toggle" );
		if ( this.isDebugConsoleEnabled ) {
			trace( "attached" );
			Console.defaultPrinter.attach();
		} else {
			trace( "removed" );
			Console.defaultPrinter.remove();
		}
	}
	
	public function setPlayer( l_player : Component_Actor ) : Void {
		this.player = l_player;
	}
	
	private static var s_instance = null;
	public static function getInstance() {
		if ( s_instance == null ) {
			s_instance = new Kernel();
		}

		return s_instance;
	}
}