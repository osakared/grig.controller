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

package fire.fromFire.dial;

import renoise.song.NoteColumn;
import fire.fromFire.button.ButtonsReadOnly;
import renoise.Renoise;
import fire.util.RenoiseUtil;
using fire.util.Math;

class Select implements Dial
{
    public var type : DialType;

    public function new(type :DialType) : Void
    {
        this.type = type;
    }

    public function left(buttons :ButtonsReadOnly) : Void
    {
        if(buttons.select.isDown.value) {
            if(buttons.alt.isDown.value) {
                handleAlt(true);
            }
            else {
                moveNote(-1);
            }
        }
        else {
            moveLine(-1);
        }
    }

    public function right(buttons :ButtonsReadOnly) : Void
    {
        if(buttons.select.isDown.value) {
            if(buttons.alt.isDown.value) {
                handleAlt(false);
            }
            else {
                moveNote(1);
            }
        }
        else {
            moveLine(1);
        }
    }

    private function handleAlt(isLeft :Bool) : Void
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

    private function moveNote(amount :Int) : Void
    {
        var noteValue = (Renoise.song().selectedLine.noteColumn(1).noteValue + amount).clamp(0, 119);
        Renoise.song().selectedLine.noteColumn(1).noteValue = noteValue;
    }

    private function moveLine(amount :Int) : Void
    {
        RenoiseUtil.setLine(Renoise.song().transport.playbackPos.line + amount, 64);
    }
}

