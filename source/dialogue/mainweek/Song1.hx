// I do be taking code from FX Engine for dis! (Shhh....)
package dialogue.mainweek;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSubState;
import flixel.FlxObject;
import flixel.FlxCamera;
import dialogue.shaders.ColorSwapShader;
import openfl.filters.ShaderFilter;
import flixel.addons.display.FlxBackdrop;

class Song1 extends FlxState
{
	public var camHUD:FlxCamera;
    var colorShader:ColorSwapEffect;

    override public function create()
    {
        swagShader = new ColorSwapShader();

		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.add(camHUD);
		FlxCamera.defaultCameras = [camHUD];

        var titlestatebg:FlxBackdrop = new FlxBackdrop(Paths.image('dialoguestates/bg/loading'), 0.2, 0, true, true);
		titlestatebg.velocity.set(200, 110);
		titlestatebg.updateHitbox();
		titlestatebg.alpha = 0.5;
		titlestatebg.screenCenter();
		add(titlestatebg);
		titlestatebg.shader = colorShader.shader;

        colorShader = new ColorSwapEffect();

        super.create();
    }

    var swagShader:ColorSwapShader = null;

    override public function update(elapsed:Float)
    {
        if (FlxG.keys.justPressed.ENTER)
        {
            MusicBeatState.switchState(new PlayState());
        }    
        super.update(elapsed);
    }
}