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

import fire.Display;
import fire.button.*;
import renoise.Midi;
import fire.State;
import fire.Text;
import renoise.Song;

class Main
{
    public static inline function getType(value :Dynamic) : String
    {
        return lua.Lua.type(value);
    }

    public static function main() : Void
    {
        haxe.macro.Compiler.includeFile("src/fire/util.lua");
		var device = Midi.available_input_devices()[1];

		if(device != null && device.indexOf("FL STUDIO FIRE") == 0) {
			var output :MidiOutputDevice = Midi.create_output_device(device);
			var state = new State();
			state.initialize(output);
			Midi.create_input_device(device, (a) -> {
				var inputState :InputState = a.isOn();
				switch inputState {
					case BUTTON_DOWN:
						handleButtonDown(state, output, a.note());
					case BUTTON_UP:
						handleButtonUp(state, output, a.note());
				}
			}, (b) -> {

            });
            
            Renoise.song().transport.playingObservable.addNotifier(() -> {
                // trace(Renoise.song().transport.playing);
            });
		}
    }

    public static function drawMsg(display :Display, output :MidiOutputDevice, msg :String) : Void
    {
        display.clear(output, 0);
        display.drawString(Text.make(msg));
        display.render(output, 0, 0, 127);
    }

    public static function handleButtonDown(state :State, output :MidiOutputDevice, button :ButtonType) : Void
    {
        if(state.buttons.exists(button)) {
            state.buttons.get(button).down(output, state.display);
        }
        else {
            state.grid.step(output);
        }
    }

    public static function handleButtonUp(state :State, output :MidiOutputDevice, button :ButtonType) : Void
    {
        if(state.buttons.exists(button)) {
            state.buttons.get(button).up(output, state.display);
        }
    }
}

@:enum
abstract InputState(Int) from Int to Int
{
    var BUTTON_DOWN = 144;
    var BUTTON_UP = 128;
}