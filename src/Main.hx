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

import haxe.io.Output;
import renoise.PlaybackPositionObserver;
import renoise.tool.Tool.MenuEntry;
import fire.output.Grid;
import fire.output.Display;
import fire.util.Modifiers;
import fire.button.ButtonType;
import renoise.midi.Midi;
import fire.button.Buttons;
import fire.input.dial.DialType;
import fire.input.dial.Dials;
import fire.util.Text;
import renoise.Renoise;
import fire.output.button.ButtonLights;

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
            var display = new Display();
            var grid = new Grid();
            var modifiers = new Modifiers();

            
            var x = 0;
            
            buttons.initialize(modifiers, MIDI_OUT, display);
            dials.initialize(modifiers, MIDI_OUT, display);

			MIDI_IN = Midi.createInputDevice(device, (a) -> {
				var inputState = a.type();
				switch inputState {
					case BUTTON_DOWN:
                        handleButtonDown(buttons, modifiers, grid, display, MIDI_OUT, a.note());
					case BUTTON_UP:
                        handleButtonUp(buttons, modifiers, grid, display, MIDI_OUT, a.note());
                    case ROTARY:
                        var isRight = a.velocity() < 64;

                        if(isRight) {
                            x += 1;
                            if(x > 127) {
                                x = 127;
                            }
                        }
                        else {
                            x -= 1;
                            if(x < 0) {
                                x = 0;
                            }
                        }

                        draw(display, x, 20);
                        handleRotary(dials, modifiers, grid, display, MIDI_OUT, a.note(), isRight);
                    case _:
                        Renoise.app().showStatus(Std.string(a.type()));
				}
			}, (b) -> {

            });

            var playbackObserver = new PlaybackPositionObserver();
            var transport = Renoise.song().transport;
            playbackObserver.register(0, () -> {
                // grid.colorIndex(MIDI_OUT, transport.playbackPos.line - 1);
            });
		}
    }

    private static function draw(display :Display, x :Int, y :Int) : Void
    {
        display.clear();
        for(i in 0...128) {
            display.drawPixel(1, i, y);
        }
        for(i in 0...64) {
            display.drawPixel(1, x, i);
        }
        // display.drawText("Haxe", 10, 10);
        // display.drawText("With Lua Rocks", 10, 18);
        // display.drawText("The WORLD", 10, 26);
        display.render(MIDI_OUT);
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