package dev;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxSave;
import flixel.util.FlxColor;
#if desktop
import Discord.DiscordClient;
#end

class StateTester extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	private var grpControls:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = ['Song 1 Dialogue State', 'Back'];

	override function create()
	{
		#if desktop
		DiscordClient.changePresence("A dev is testing out states!", null, null, true);
		#end

		var menuBG:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		// controlsStrings = CoolUtil.coolTextFile('assets/data/controls.txt');
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...menuItems.length)
		{
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			controlLabel.screenCenter();
			controlLabel.y = (100 * i) + 70;
			// controlLabel.isMenuItem = true;
			// controlLabel.targetY = i;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		changeSelection();

		var devmenutext1:FlxText = new FlxText(5, FlxG.height - 24, 0, "Welcome to the State Tester", 12);
		devmenutext1.scrollFactor.set();
		devmenutext1.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(devmenutext1);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.SPACE)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{
				case "Song 1 Dialogue State":
					FlxG.switchState(new dialogue.mainweek.Song1()); // Reminder to turn this into a substate
				case "Back":
					FlxG.switchState(new dev.DevMenu());
			}
		}

		if (controls.BACK #if android || FlxG.android.justReleased.BACK #end)
		{
			FlxG.switchState(new MainMenuState());
		}

		if (controls.UI_UP_P)
			changeSelection(-1);
		if (controls.UI_DOWN_P)
			changeSelection(1);
	}

	function changeSelection(change:Int = 0)
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
				item.color = 0xFF00ff00; // Green color
			}
			else
			{
				// Set the color back to red for other items
				item.color = 0xFFff0000; // Red color
			}			
		}
	}

	override function closeSubState()
	{
		super.closeSubState();
	}
}