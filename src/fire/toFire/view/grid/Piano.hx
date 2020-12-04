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

import renoise.midi.Midi.MidiOutputDevice;
import fire.util.Math;
import fire.util.PadNote;
import renoise.song.EffectColumn;
import renoise.Renoise;
import renoise.song.NoteColumn;
import fire.fromFire.ControllerStateReadOnly;
using lua.PairTools;

class Piano
{
    public static function draw(outputDevice :MidiOutputDevice, pads :Grid, controllerState :ControllerStateReadOnly) : Void
    {
        pads.clear();

        for(pad in PadNoteUtil.keysBlack) {
            checkPad(pads, controllerState, pad);
        }

        for(pad in PadNoteUtil.keysWhite) {
            checkPad(pads, controllerState, pad);
        }

        checkPad(pads, controllerState, PadNote.OFF);
        checkPad(pads, controllerState, PadNote.ERASE);
        checkPad(pads, controllerState, PadNote.OCTAVE_UP);
        checkPad(pads, controllerState, PadNote.OCTAVE_DOWN);
        
        pads.render(outputDevice);
    }

    private static function checkPad(pads :Grid, controllerState :ControllerStateReadOnly, pad :PadNote) : Void
    {
        var offset = controllerState.grid.isDown(pad)
            ? 60
            : 0;
        pads.drawPad(40 + offset, 80 + offset, 40, pad);
    }  
}