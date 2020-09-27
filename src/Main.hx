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

import renoise.Renoise;
import renoise.song.SubColumn;
import renoise.midi.Midi;
import renoise.tool.Tool.MenuEntry;
import fire.input.Grid as InputGrid;
import fire.input.button.Buttons;
import fire.input.dial.DialType;
import fire.input.dial.Dials;
import fire.input.button.ButtonType;
import fire.output.Output;
import fire.util.Modifiers;

class Main
{
    private static var MIDI_IN :MidiInputDevice;
    private static var MIDI_OUT :MidiOutputDevice;

    public static inline function getType(value :Dynamic) : String
    {
        return lua.Lua.type(value);
    }

    public static function main() : Void
    {
        // trace(Renoise.)
        var x__ = SubColumn.NOTE;
        trace(x__);
        haxe.macro.Compiler.includeFile("src/fire/_lua/util.lua");
        Renoise.tool().addMenuEntry(new MenuEntry("Main Menu:Tools:Lady Fire", Main.init));
    }

    public static function init() : Void
    {
        var device = Midi.availableInputDevices()[1];

		if(device != null && device.indexOf("FL STUDIO FIRE") == 0) {
            MIDI_OUT = Midi.createOutputDevice(device);
            var buttons = new Buttons();
            var dials = new Dials();
            var inputGrid = new InputGrid();
            var modifiers = new Modifiers();
            new Output(MIDI_OUT, modifiers);

			MIDI_IN = Midi.createInputDevice(device, (a) -> {
				var inputState = a.type();
				switch inputState {
					case BUTTON_DOWN:
                        handleButtonDown(buttons, inputGrid, modifiers, a.note());
					case BUTTON_UP:
                        handleButtonUp(buttons, inputGrid, modifiers, a.note());
                    case ROTARY:
                        var isRight = a.velocity() < 64;
                        handleRotary(dials, modifiers, a.note(), isRight);
                    case _:
                        Renoise.app().showStatus(Std.string(a.type()));
				}
			}, (b) -> {});
		}
    }

    public static function handleButtonDown(buttons :Buttons, grid :InputGrid, modifiers :Modifiers, button :ButtonType) : Void
    {
        if(buttons.exists(button)) {
            buttons.get(button).down(modifiers);
        }
        else {
            grid.down(modifiers, button - 54);
        }
    }

    public static function handleButtonUp(buttons :Buttons, grid :InputGrid, modifiers :Modifiers, button :ButtonType) : Void
    {
        if(buttons.exists(button)) {
            buttons.get(button).up(modifiers);
        }
        else {
            grid.up(modifiers, button - 54);
        }
    }

    public static function handleRotary(dials :Dials, modifiers :Modifiers, type :DialType, isRight :Bool) : Void
    {
        if(dials.exists(type)) {
            if(isRight) {
                dials.get(type).right(modifiers);
            }
            else {
                dials.get(type).left(modifiers);
            }
        }
    }
}