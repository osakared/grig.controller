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

import lua.Table;
import fire.toRenoise.ToRenoise;
import renoise.Renoise;
import renoise.midi.Midi;
import renoise.tool.Tool.MenuEntry;
import fire.toRenoise.Grid as InputGrid;
import fire.fromFire.button.Buttons;
import fire.fromFire.dial.DialType;
import fire.fromFire.dial.Dials;
import fire.fromFire.button.ButtonType;
import fire.toFire.ToFire;
import fire.util.Signal1;
import fire.util.Cursor;
import fire.util.State;

class Main
{
    private static var MIDI_IN :MidiInputDevice;
    private static var MIDI_OUT :MidiOutputDevice;

    public static function main() : Void
    {
        haxe.macro.Compiler.includeFile("src/fire/_lua/util.lua");
        Renoise.tool().addMenuEntry(new MenuEntry("Main Menu:Tools:Lady Fire", Main.init));
    }

    public static function init() : Void
    {
        var device = Midi.availableInputDevices()[1];

		if(device != null && device.indexOf("FL STUDIO FIRE") == 0) {
            MIDI_OUT = Midi.createOutputDevice(device);
            var gridIndex = new Signal1(Note);
            var state = new State();
            var buttons = new Buttons(gridIndex);
            var dials = new Dials();
            var inputGrid = new InputGrid();
            new ToFire(state, MIDI_OUT, buttons, gridIndex);
            new ToRenoise(buttons, dials);

			MIDI_IN = Midi.createInputDevice(device, (a) -> {
				var inputState = a.type();
				switch inputState {
					case BUTTON_DOWN:
                        handleButtonDown(state, buttons, inputGrid, a.note());
					case BUTTON_UP:
                        handleButtonUp(state, buttons, inputGrid, a.note());
                    case ROTARY:
                        var isRight = a.velocity() < 64;
                        handleRotary(dials, cast buttons, a.note(), isRight);
                    case _:
                        Renoise.app().showStatus(Std.string(a.type()));
				}
			}, (b) -> {});
		}
    }

    public static function handleButtonDown(state :State, buttons :Buttons, grid :InputGrid, button :ButtonType) : Void
    {
        if(buttons.exists(button)) {
            buttons.get(button).value = true;
        }
        else {
            grid.down(state, button - 54);
        }
    }

    public static function handleButtonUp(state :State, buttons :Buttons, grid :InputGrid, button :ButtonType) : Void
    {
        if(buttons.exists(button)) {
            buttons.get(button).value = false;
        }
        else {
            grid.up(state, button - 54);
        }
    }

    public static function handleRotary(dials :Dials, buttons :Buttons, type :DialType, isRight :Bool) : Void
    {
        if(dials.exists(type)) {
            if(isRight) {
                dials.get(type).right.emit();
            }
            else {
                dials.get(type).left.emit();
            }
        }
    }
}