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

package fire.toRenoise.dial;

import renoise.song.NoteColumn;
import fire.fromFire.ControllerStateReadOnly;
import renoise.Renoise;
import fire.util.RenoiseUtil;
using fire.util.Math;

class Select
{
    public static function onLeft(controllerState :ControllerStateReadOnly) : Void
    {
        switch controllerState.input.value {
            case STEP:
                switch controllerState.grid.hasDown {
                    case true:
                        moveNote(-1);
                    case false:
                        moveLine(-1);
                }
            case NOTE:
                moveLine(-1);
            case DRUM:
                moveLine(-1);
            case PERFORM:
                moveLine(-1);
        }
    }

    public static function onRight(controllerState :ControllerStateReadOnly) : Void
    {
        switch controllerState.input.value {
            case STEP:
                switch controllerState.grid.hasDown {
                    case true:
                        moveNote(1);
                    case false:
                        moveLine(1);
                }
            case NOTE:
                moveLine(1);
            case DRUM:
                moveLine(1);
            case PERFORM:
                moveLine(1);
        }
    }

    private static function handleAlt(isLeft :Bool) : Void
    {
        var noteValue = Renoise.song().selectedLine.noteColumn(1).noteValue;
        Renoise.song().selectedLine.noteColumn(1).noteValue = switch [isLeft, noteValue] {
            case [true, NoteColumn.NOTE_EMPTY]: NoteColumn.MIDDLE_C;
            case [true, NoteColumn.NOTE_OFF]: NoteColumn.NOTE_EMPTY;
            case [true, _]: NoteColumn.NOTE_OFF;

            case [false, NoteColumn.NOTE_EMPTY]: NoteColumn.NOTE_OFF;
            case [false, NoteColumn.NOTE_OFF]: NoteColumn.MIDDLE_C;
            case [false, _]: NoteColumn.NOTE_EMPTY;
        }
    }

    private static function moveNote(amount :Int) : Void
    {
        var noteValue = Renoise.song().selectedLine.noteColumn(1).noteValue;
        Renoise.song().selectedLine.noteColumn(1).noteValue = switch noteValue {
            case NoteColumn.NOTE_EMPTY:
                NoteColumn.MIDDLE_C;
            case NoteColumn.NOTE_OFF:
                NoteColumn.MIDDLE_C;
            case _:
                (Renoise.song().selectedLine.noteColumn(1).noteValue + amount).clamp(0, 119);
        }
    }

    private static function moveLine(amount :Int) : Void
    {
        RenoiseUtil.setLine(Renoise.song().transport.playbackPos.line + amount, 64);
    }
}

