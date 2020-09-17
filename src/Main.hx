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
import renoise.Midi.MidiInputDevice;
import renoise.Midi.MidiOutputDevice;
import renoise.Midi;
import fire.State;
import fire.Text;

class Main
{
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
		}
    }

    public static function handleButtonDown(state :State, output :MidiOutputDevice, button :ButtonType) : Void
    {
        switch button {
            case KNOB_TYPE:
                trace("down: KNOB_TYPE");
            case VOLUME:
                trace("down: VOLUME");
            case PAN:
                trace("down: PAN");
            case FILTER:
                trace("down: FILTER");
            case RESONANCE:
                trace("down: RESONANCE");
            case PATTERN_UP:
                state.display.clear(output, 0, 0, 127);
                state.display.drawString(Text.make("Up"));
                state.display.render(output, 0, 0, 127);
                state.display.drawString(Text.make("Line Two cool"));
                state.display.render(output, 1, 0, 127);
            case PATTERN_DOWN:
                state.display.clear(output, 0, 0, 127);
                state.display.drawString(Text.make("Down"));
                state.display.render(output, 0, 0, 127);
            case BROWSER:
                trace("down: BROWSER");
            case SELECT:
                trace("down: SELECT");
            case GRID_LEFT:
                trace("down: GRID_LEFT");
            case GRID_RIGHT:
                trace("down: GRID_RIGHT");
            case MUTE_SOLO_1:
                trace("down: MUTE_SOLO_1");
            case MUTE_SOLO_2:
                trace("down: MUTE_SOLO_2");
            case MUTE_SOLO_3:
                trace("down: MUTE_SOLO_3");
            case MUTE_SOLO_4:
                trace("down: MUTE_SOLO_4");
            case STEP:
                trace("down: STEP");
            case NOTE:
                trace("down: NOTE");
            case DRUM:
                trace("down: DRUM");
            case PERFORM:
                trace("down: PERFORM");
            case SHIFT:
                trace("down: SHIFT");
            case ALT:
                trace("down: ALT");
            case PATTERN_SONG:
                trace("down: PATTERN_SONG");
            case PLAY:
                trace("down: PLAY");
            case STOP:
                trace("down: STOP");
            case RECORD:
                trace("down: RECORD");
            case _:
                state.grid.step(output);
        }
    }

    public static function handleButtonUp(state :State, output :MidiOutputDevice, button :ButtonType) : Void
    {
        switch button {
            case KNOB_TYPE:
                state.knobType.step(output);
            case VOLUME:
                state.volume.step(output);
            case PAN:
                state.pan.step(output);
            case FILTER:
                state.filter.step(output);
            case RESONANCE:
                state.resonance.step(output);
            case PATTERN_UP:
                state.patternUp.step(output);
            case PATTERN_DOWN:
                state.patternDown.step(output);
            case BROWSER:
                state.browser.step(output);
            case SELECT:
                state.select.step(output);
            case GRID_LEFT:
                state.gridLeft.step(output);
            case GRID_RIGHT:
                state.gridRight.step(output);
            case MUTE_SOLO_1:
                state.muteSolo1.step(output);
            case MUTE_SOLO_2:
                state.muteSolo2.step(output);
            case MUTE_SOLO_3:
                state.muteSolo3.step(output);
            case MUTE_SOLO_4:
                state.muteSolo4.step(output);
            case STEP:
                state.step.step(output);
            case NOTE:
                state.note.step(output);
            case DRUM:
                state.drum.step(output);
            case PERFORM:
                state.perform.step(output);
            case SHIFT:
                state.shift.step(output);
            case ALT:
                state.alt.step(output);
            case PATTERN_SONG:
                state.patternSong.step(output);
            case PLAY:
                state.play.step(output);
            case STOP:
                state.stop.step(output);
            case RECORD:
                state.record.step(output);
        }
    }
}

@:enum
abstract InputState(Int) from Int to Int
{
    var BUTTON_DOWN = 144;
    var BUTTON_UP = 128;
}