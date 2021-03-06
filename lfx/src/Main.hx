package;

import flambe.Entity;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;

class Main
{
    private static function main ()
    {
        // Wind up all platform-specific stuff
        System.init();

        // Load up the compiled pack in the assets directory named "bootstrap"
        var manifest = Manifest.fromAssets("bootstrap");
        var loader = System.loadAssetPack(manifest);
        loader.get(onSuccess);
    }

    private static function onSuccess (pack :AssetPack)
    {
		Kernel.getInstance().create( pack );
        // Add a plane that moves along the screen
        // var plane = new ImageSprite(pack.getTexture("plane"));
        // plane.x._ = 30;
        // plane.y.animateTo(200, 6);
        // System.root.addChild(new Entity().add(plane));
    }
}
