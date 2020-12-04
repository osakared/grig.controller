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

import fire.toRenoise.ToRenoise;
import renoise.Renoise;
import renoise.midi.Midi;
import renoise.tool.Tool.MenuEntry;
import fire.fromFire.ControllerState;
import fire.fromFire.dial.DialType;
import fire.fromFire.button.ButtonType;
import fire.toFire.ToFire;
import fire.util.Signal1;

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
            var controllerState = new ControllerState();
            new ToFire(MIDI_OUT, controllerState);
            new ToRenoise(controllerState);

			MIDI_IN = Midi.createInputDevice(device, (a) -> {
				var inputState = a.type();
				switch inputState {
					case BUTTON_DOWN:
                        handleButtonDown(controllerState, a.note());
					case BUTTON_UP:
                        handleButtonUp(controllerState, a.note());
                    case ROTARY:
                        var isRight = a.velocity() < 64;
                        handleRotary(cast controllerState, a.note(), isRight);
                    case _:
                        Renoise.app().showStatus(Std.string(a.type()));
				}
			}, (b) -> {});
		}
    }

    public static function handleButtonDown(controllerState :ControllerState, button :ButtonType) : Void
    {
        if(controllerState.buttons.isButton(button)) {
            controllerState.buttons.down(button);
        }
        else {
            controllerState.grid.down(button - 54);
        }
    }

    public static function handleButtonUp(controllerState :ControllerState, button :ButtonType) : Void
    {
        if(controllerState.buttons.isButton(button)) {
            controllerState.buttons.up(button);
        }
        else {
            controllerState.grid.up(button - 54);
        }
    }

    public static function handleRotary(controllerState :ControllerState, type :DialType, isRight :Bool) : Void
    {
        if(isRight) {
            controllerState.dials.right(type);
        }
        else {
            controllerState.dials.left(type);
        }

        Renoise.app().showStatus(Std.string(Renoise.hack().cursor));
    }
}