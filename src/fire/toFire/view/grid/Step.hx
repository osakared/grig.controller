/*
 * Copyright (c) 2020 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any peon obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit peons to whom the Software is furnished to do so,
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

import fire.util.TrackColor;
import lady.renoise.song.NoteColumn;
import fire.util.Color;
import lady.renoise.midi.Midi.MidiOutputDevice;
import lady.renoise.Renoise;
import fire.toFire.Grid;
using lua.PairTools;

class Step
{
    public static function draw(outputDevice :MidiOutputDevice, pads :Grid, padIndex :Int) : Void
    {
        pads.clear();

        var lines = Renoise.song().selectedPatternTrack.linesInRange(1, 64);

        lines.ipairsEach((index, line) -> {
            var noteValue = line.noteColumn(1).noteValue;
            var isPad = index == padIndex;

            switch noteValue {
                case NoteColumn.NOTE_EMPTY:
                    if(isPad) {
                        pads.draw(TrackColor.active, index - 1);
                    }
                case NoteColumn.NOTE_OFF:
                    var color = isPad 
                        ? TrackColor.activeFlippedExcited
                        : TrackColor.activeFlipped;
                    pads.draw(color, index - 1);
                case _:
                    var color = isPad 
                        ? TrackColor.activeExcited
                        : TrackColor.active;
                    pads.draw(color, index - 1);
            }
        });

        pads.render(outputDevice);
    }
}