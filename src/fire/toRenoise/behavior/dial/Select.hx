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

package fire.toRenoise.behavior.dial;

import renoise.song.NoteColumn;
import fire.fromFire.ControllerStateReadOnly;
import renoise.Renoise;
import fire.util.RenoiseUtil;
using fire.util.Math;

class Select
{
    public static function handle(isLeft: Bool, softkeys :SoftKeys, state :ControllerStateReadOnly) : Void
    {
        if(isLeft) {
            onLeft(softkeys, state);
        }
        else {
            onRight(softkeys, state);
        }
    }

    private static function onLeft(softkeys :SoftKeys, controllerState :ControllerStateReadOnly) : Void
    {
        switch controllerState.input.value {
            case STEP:
                switch controllerState.grid.hasDown {
                    case true:
                        moveNote(softkeys, -1);
                    case false:
                        RenoiseUtil.lineMoveBy(-1);
                }
            case NOTE:
                RenoiseUtil.lineMoveBy(-1);
            case DRUM:
                RenoiseUtil.lineMoveBy(-1);
            case PERFORM:
                RenoiseUtil.lineMoveBy(-1);
        }
    }

    private static function onRight(softkeys :SoftKeys, controllerState :ControllerStateReadOnly) : Void
    {
        switch controllerState.input.value {
            case STEP:
                switch controllerState.grid.hasDown {
                    case true:
                        moveNote(softkeys, 1);
                    case false:
                        RenoiseUtil.lineMoveBy(1);
                }
            case NOTE:
                RenoiseUtil.lineMoveBy(1);
            case DRUM:
                RenoiseUtil.lineMoveBy(1);
            case PERFORM:
                RenoiseUtil.lineMoveBy(1);
        }
    }

    private static function moveNote(softkeys :SoftKeys, amount :Int) : Void
    {
        var oldValue = Renoise.song().selectedLine.noteColumn(1).noteValue;
        var newValue = switch oldValue {
            case NoteColumn.NOTE_EMPTY:
                NoteColumn.MIDDLE_C;
            case NoteColumn.NOTE_OFF:
                NoteColumn.MIDDLE_C;
            case _:
                (Renoise.song().selectedLine.noteColumn(1).noteValue + amount).clamp(0, 119);
        }
        var noteColumn = Renoise.song().selectedNoteColumnIndex;
        Renoise.song().selectedLine.noteColumn(noteColumn).noteValue = newValue;
        softkeys.playNote(false, oldValue);
        softkeys.playNote(true, newValue);
    }
}

