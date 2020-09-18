/*
 * Copyright (c) 2020 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import renoise.tool.Tool.MenuEntry;
import fire.Grid;
import fire.Display;
import fire.button.*;
import renoise.midi.Midi;
import fire.button.Buttons;
import fire.Text;
import renoise.Renoise;

class Main
{
    public static inline function getType(value :Dynamic) : String
    {
        return lua.Lua.type(value);
    }

    public static function main() : Void
    {
        haxe.macro.Compiler.includeFile("src/fire/util.lua");

        Renoise.tool().addMenuEntry(new MenuEntry("Main Menu:Tools:Lady Fire", Main.init));
		
    }

    public static function init() : Void
    {
        var device = Midi.available_input_devices()[1];

		if(device != null && device.indexOf("FL STUDIO FIRE") == 0) {
			var output :MidiOutputDevice = Midi.create_output_device(device);
            var buttons = new Buttons();
            var display = new Display();
            var grid = new Grid();
			buttons.initialize(output, display);
			Midi.create_input_device(device, (a) -> {
				var inputState :InputState = a.isOn();
				switch inputState {
					case BUTTON_DOWN:
						handleButtonDown(buttons, grid, display, output, a.note());
					case BUTTON_UP:
						handleButtonUp(buttons, grid, display, output, a.note());
				}
			}, (b) -> {

            });
		}
    }

    public static function drawMsg(display :Display, output :MidiOutputDevice, msg :String) : Void
    {
        display.clear(output, 0);
        display.drawString(Text.make(msg));
        display.render(output, 0, 0, 127);
    }

    public static function handleButtonDown(buttons :Buttons, grid :Grid, display :Display, output :MidiOutputDevice, button :ButtonType) : Void
    {
        if(buttons.exists(button)) {
            buttons.get(button).down(output, display);
        }
        else {
            grid.step(output);
        }
    }

    public static function handleButtonUp(buttons :Buttons, grid :Grid, display :Display, output :MidiOutputDevice, button :ButtonType) : Void
    {
        if(buttons.exists(button)) {
            buttons.get(button).up(output, display);
        }
    }
}

@:enum
abstract InputState(Int) from Int to Int
{
    var BUTTON_DOWN = 144;
    var BUTTON_UP = 128;
}