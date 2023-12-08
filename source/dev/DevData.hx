package dev;

import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;

class DevData
{
	public static function initSave()
	{
		if (FlxG.save.data.perfectmode == null)
			FlxG.save.data.perfectmode = false;

		if (FlxG.save.data.infhealth == null)
			FlxG.save.data.infhealth = false;
	}

	@:keep public static inline function framerateAdjust(input:Float):Float
	{
		return FlxG.elapsed * 60 * input;
	}
}