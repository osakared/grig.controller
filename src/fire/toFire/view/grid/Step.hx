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

package fire.toFire.view.grid;

import fire.util.Color;
import renoise.midi.Midi.MidiOutputDevice;
import renoise.Renoise;
import fire.toFire.Grid;
using lua.PairTools;

class Step
{
    public static function draw(outputDevice :MidiOutputDevice, pads :Grid, padIndex :Int) : Void
    {
        pads.clear();

        var lines = Renoise.song().selectedPatternTrack.linesInRange(1, 64);
        var hasDrawnPadIndex = false;
        var trackColor = Renoise.song().selectedTrack.color;
        var color = Color.fromTrackColor(trackColor);
        lines.ipairsEach((index, line) -> {
            var noteValue = line.noteColumn(1).noteValue;
            if(noteValue < 121) {
                //This is a pad with a value that also is the current pad.
                if(index == padIndex) {
                    pads.draw(color, index - 1);
                    hasDrawnPadIndex = true;
                }
                //This is a pad with a value.
                else {
                    pads.draw(color, index - 1);
                }
            }
        });
        //The current pad which was never drawn.
        if(!hasDrawnPadIndex) {
            pads.draw(color, padIndex - 1);
        }

        pads.render(outputDevice);
    }
}