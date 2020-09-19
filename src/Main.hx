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

import renoise.PlaybackPositionObserver;
import renoise.tool.Tool.MenuEntry;
import fire.Grid;
import fire.Display;
import fire.Modifiers;
import fire.button.ButtonType;
import renoise.midi.Midi;
import fire.button.Buttons;
import fire.dial.DialType;
import fire.dial.Dials;
import fire.Text;
import renoise.Renoise;

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
        haxe.macro.Compiler.includeFile("src/fire/util.lua");

        Renoise.tool().addMenuEntry(new MenuEntry("Main Menu:Tools:Lady Fire", Main.init));
		
    }

    public static function init() : Void
    {
        var device = Midi.available_input_devices()[1];

		if(device != null && device.indexOf("FL STUDIO FIRE") == 0) {
			MIDI_OUT = Midi.create_output_device(device);
            var buttons = new Buttons();
            var dials = new Dials();
            var display = new Display();
            var grid = new Grid();
            var modifiers = new Modifiers();
            
            buttons.initialize(modifiers, MIDI_OUT, display);
            dials.initialize(modifiers, MIDI_OUT, display);
            display.initialize(modifiers, MIDI_OUT, display);
            grid.initialize(modifiers, MIDI_OUT, display);

			MIDI_IN = Midi.create_input_device(device, (a) -> {
				var inputState = a.type();
				switch inputState {
					case BUTTON_DOWN:
						handleButtonDown(buttons, modifiers, grid, display, MIDI_OUT, a.note());
					case BUTTON_UP:
                        handleButtonUp(buttons, modifiers, grid, display, MIDI_OUT, a.note());
                    case ROTARY:
                        var isRight = a.velocity() < 64;
                        handleRotary(dials, modifiers, grid, display, MIDI_OUT, a.note(), isRight);
                    case _:
                        Renoise.app().showStatus(Std.string(a.type()));
				}
			}, (b) -> {

            });

            var playbackObserver = new PlaybackPositionObserver();
            var transport = Renoise.song().transport;
            playbackObserver.register(0, () -> {
                grid.colorIndex(MIDI_OUT, transport.playbackPos.line - 1);
            });
		}
    }

    public static function drawMsg(display :Display, output :MidiOutputDevice, msg :String) : Void
    {
        display.clear(output, 0);
        display.drawString(Text.make(msg));
        display.render(output, 0, 0, 127);
    }

    public static function handleButtonDown(buttons :Buttons, modifiers :Modifiers, grid :Grid, display :Display, output :MidiOutputDevice, button :ButtonType) : Void
    {
        if(buttons.exists(button)) {
            buttons.get(button).down(modifiers, output, display);
        }
    }

    public static function handleButtonUp(buttons :Buttons, modifiers :Modifiers, grid :Grid, display :Display, output :MidiOutputDevice, button :ButtonType) : Void
    {
        if(buttons.exists(button)) {
            buttons.get(button).up(modifiers, output, display);
        }
        else {
            grid.handleButtonIndex(output, button);
        }
    }

    public static function handleRotary(dials :Dials, modifiers :Modifiers, grid :Grid, display :Display, output :MidiOutputDevice, type :DialType, isRight :Bool) : Void
    {
        if(dials.exists(type)) {
            if(isRight) {
                dials.get(type).right(modifiers, output, display);
            }
            else {
                dials.get(type).left(modifiers, output, display);
            }
        }
    }
}