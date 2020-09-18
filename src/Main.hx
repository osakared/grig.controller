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

    public static function handleButtonDown(state :State, output :MidiOutputDevice, button :ButtonType) : Void
    {
        switch button {
            case KNOB_TYPE:
                drawMsg(state, output, "down KNOB TYPE");
            case VOLUME:
                drawMsg(state, output, "down VOLUME");
            case PAN:
                drawMsg(state, output, "down PAN");
            case FILTER:
                drawMsg(state, output, "down FILTER");
            case RESONANCE:
                drawMsg(state, output, "down RESONANCE");
            case PATTERN_UP:
                drawMsg(state, output, "down PATTERN UP");
            case PATTERN_DOWN:
                drawMsg(state, output, "down PATTERN DOWN");
            case BROWSER:
                drawMsg(state, output, "down BROWSER");
            case SELECT:
                drawMsg(state, output, "down SELECT");
            case GRID_LEFT:
                drawMsg(state, output, "down GRID LEFT");
            case GRID_RIGHT:
                drawMsg(state, output, "down GRID RIGHT");
            case MUTE_SOLO_1:
                drawMsg(state, output, "down MUTE SOLO");
            case MUTE_SOLO_2:
                drawMsg(state, output, "down MUTE SOLO");
            case MUTE_SOLO_3:
                drawMsg(state, output, "down MUTE SOLO");
            case MUTE_SOLO_4:
                drawMsg(state, output, "down MUTE SOLO");
            case STEP:
                drawMsg(state, output, "down STEP");
            case NOTE:
                drawMsg(state, output, "down NOTE");
            case DRUM:
                drawMsg(state, output, "down DRUM");
            case PERFORM:
                drawMsg(state, output, "down PERFORM");
            case SHIFT:
                drawMsg(state, output, "down SHIFT");
            case ALT:
                drawMsg(state, output, "down ALT");
            case PATTERN_SONG:
                drawMsg(state, output, "down PATTERN SONG");
            case PLAY:
                drawMsg(state, output, "down PLAY");
            case STOP:
                drawMsg(state, output, "down STOP");
            case RECORD:
                drawMsg(state, output, "down RECORD");
            case _:
                state.grid.step(output);
        }
    }

    private static function drawMsg(state :State, output :MidiOutputDevice, msg :String) : Void
    {
        state.display.clear(output, 0);
        state.display.drawString(Text.make(msg));
        state.display.render(output, 0, 0, 127);
    }

    public static function handleButtonUp(state :State, output :MidiOutputDevice, button :ButtonType) : Void
    {
        switch button {
            case KNOB_TYPE:
            case VOLUME:
            case PAN:
            case FILTER:
            case RESONANCE:
            case PATTERN_UP:
            case PATTERN_DOWN:
            case BROWSER:
            case SELECT:
            case GRID_LEFT:
            case GRID_RIGHT:
            case MUTE_SOLO_1:
            case MUTE_SOLO_2:
            case MUTE_SOLO_3:
            case MUTE_SOLO_4:
            case STEP:
            case NOTE:
            case DRUM:
            case PERFORM:
            case SHIFT:
            case ALT:
            case PATTERN_SONG:
            case PLAY:
            case STOP:
            case RECORD:
        }
    }
}

@:enum
abstract InputState(Int) from Int to Int
{
    var BUTTON_DOWN = 144;
    var BUTTON_UP = 128;
}