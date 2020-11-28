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

package fire.toRenoise;

import renoise.Renoise;
import fire.util.PadNote;
import fire.util.RenoiseUtil;
import fire.fromFire.ControllerStateReadOnly;

class Grid
{
    public function new(softkeys :SoftKeys) : Void
    {
        _softKeys = softkeys;
    }

    public function down(controllerState :ControllerStateReadOnly, pad :Int) : Void
    {
        switch controllerState.input.value {
            case STEP: {
                RenoiseUtil.setLine(pad + 1, 64);
            }
            case NOTE: {
                var note = PadNote.getNote(pad);
                if(note != -1) {
                    _softKeys.playNote(true, note);
                }
            }
            case DRUM:
            case PERFORM:
        }
    }

    public function up(controllerState :ControllerStateReadOnly, pad :Int) : Void
    {
        switch controllerState.input.value {
            case STEP: {
                var oldValue = Renoise.song().selectedLine.noteColumn(1).noteValue;
                _softKeys.playNote(false, oldValue);
            }
            case NOTE: {
                var note = PadNote.getNote(pad);
                if(note != -1) {
                    _softKeys.playNote(false, note);
                }
            }
            case DRUM:
            case PERFORM:
        }
    }

    private var _softKeys :SoftKeys;
}

