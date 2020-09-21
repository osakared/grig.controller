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

package fire.input.dial;

import fire.util.Modifiers;
import renoise.Renoise;
import renoise.midi.Midi.MidiOutputDevice;
import renoise.RenoiseUtil;
import fire.output.Display;

class Select implements Dial
{
    public var type : DialType;

    public function new(type :DialType) : Void
    {
        this.type = type;
    }

    public function initialize(modifiers :Modifiers, output :MidiOutputDevice, display :Display) : Void
    {
    }

    public function left(modifiers :Modifiers, output :MidiOutputDevice, display :Display) : Void
    {
        if(modifiers.selectDown) {
            if(modifiers.altDown) {

            }
            else {
                var noteValue = Renoise.song().selectedLine.noteColumn(1).noteValue - 1;
                if(noteValue < 0) {
                    noteValue = 0;
                }
                Renoise.song().selectedLine.noteColumn(1).noteValue = noteValue;
            }
        }
        else {
            RenoiseUtil.setLine(Renoise.song().transport.playbackPos.line - 1, 64);
        }
    }

    public function right(modifiers :Modifiers, output :MidiOutputDevice, display :Display) : Void
    {
        if(modifiers.selectDown) {
            if(modifiers.altDown) {

            }
            else {
                var noteValue = Renoise.song().selectedLine.noteColumn(1).noteValue + 1;
                if(noteValue > 119) {
                    noteValue = 119;
                }
                Renoise.song().selectedLine.noteColumn(1).noteValue = noteValue;
            }
        }
        else {
            RenoiseUtil.setLine(Renoise.song().transport.playbackPos.line + 1, 64);
        }
    }
}

