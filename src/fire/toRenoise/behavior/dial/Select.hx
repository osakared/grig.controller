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

package fire.toRenoise.behavior.dial;

import fire.fromRenoise.RenoiseState;
import renoise.song.NoteColumn;
import fire.fromFire.ControllerStateReadOnly;
import renoise.Renoise;
import fire.util.RenoiseUtil;
using fire.util.Math;

class Select
{
    public static function handle(isLeft: Bool, softkeys :SoftKeys, controllerState :ControllerStateReadOnly, renoiseState :RenoiseState) : Void
    {
        switch controllerState.browser.value {
            case SETTINGS: {
                if(controllerState.buttons.isDown(ALT)) {
                    settingsAlt(controllerState, renoiseState, isLeft);
                }
            }
            case SEQ: {
                if(controllerState.buttons.isDown(ALT)) {
                    seqAlt(isLeft);
                }
                else {
                    seqNormal(softkeys, controllerState, renoiseState, isLeft);
                }
            }
            case INST: {
                inst(renoiseState, isLeft);
            }
        }
        
    }

    private static function settingsAlt(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, isLeft :Bool) : Void
    {
        var amount = isLeft ? -1 : 1;
        switch controllerState.settingSelection.value {
            case EDIT_STEP:
                renoiseState.editStep = renoiseState.editStep + amount;
            case BPM:
                renoiseState.bpm = renoiseState.bpm + amount;
        }
    }

    private static function inst(renoiseState :RenoiseState, isLeft :Bool) : Void
    {
        var amount = isLeft ? -1 : 1;
        var curInstIndex = renoiseState.instrumentIndex;
        renoiseState.instrumentIndex = curInstIndex + amount;
    }

    private static function seqNormal(softkeys :SoftKeys, controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, isLeft :Bool) : Void
    {
        var amount = isLeft ? -1 : 1;
        switch controllerState.input.value {
            case STEP:
                switch controllerState.grid.hasDown {
                    case true:
                        if(renoiseState.isRecording) {
                            moveNote(softkeys, amount, renoiseState);
                        }
                    case false:
                        RenoiseUtil.lineMoveBy(amount);
                }
            case NOTE:
                RenoiseUtil.lineMoveBy(amount);
            case DRUM:
                RenoiseUtil.lineMoveBy(amount);
            case PERFORM:
                RenoiseUtil.lineMoveBy(amount);
        }
    }

    private static function seqAlt(isLeft :Bool) : Void
    {
        if(isLeft) {
            Renoise.hack().moveCursorLeft();
        }
        else {
            Renoise.hack().moveCursorRight();
        }
    }

    private static function moveNote(softkeys :SoftKeys, amount :Int, renoiseState :RenoiseState) : Void
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
    }
}

