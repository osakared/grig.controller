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

package fire.toRenoise;

import fire.fromRenoise.RenoiseState;
import renoise.song.NoteColumn;
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

    public function down(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, pad :Int) : Void
    {
        switch controllerState.input.value {
            case STEP: {
                RenoiseUtil.setPos(pad + 1, 64);
            }
            case NOTE: {
                hitNote(pad, true, renoiseState);
            }
            case DRUM:
            case PERFORM:
        }
    }

    public function up(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, pad :Int) : Void
    {
        switch controllerState.input.value {
            case STEP: {
                var oldValue = Renoise.song().selectedLine.noteColumn(1).noteValue;
                _softKeys.playNote(false, oldValue, renoiseState.instrumentIndex, renoiseState.trackIndex);
            }
            case NOTE: {
                hitNote(pad, false, renoiseState);
            }
            case DRUM:
            case PERFORM:
        }
    }

    private function hitNote(pad :PadNote, isDown :Bool, renoiseState :RenoiseState) : Void
    {
        var note = PadNote.getNote(pad);
        if(note != -1) {
            _softKeys.playNote(isDown, note, renoiseState.instrumentIndex, renoiseState.trackIndex);

            if(!isDown && RenoiseUtil.isRecording()) {
                RenoiseUtil.lineMoveBy(renoiseState.editStep);
            }
        }
        else if(!isDown && RenoiseUtil.isRecording()) {
            switch [pad, renoiseState.trackColumn.value] {
                case [OFF, TrackNote(index)]:
                    Renoise.song().selectedLine.noteColumn(index).noteValue = NoteColumn.NOTE_OFF;
                    if(RenoiseUtil.isRecording()) {
                        RenoiseUtil.lineMoveBy(renoiseState.editStep);
                    }
                case [ERASE, TrackNote(index)]:
                    Renoise.song().selectedLine.noteColumn(index).noteValue = NoteColumn.NOTE_EMPTY;
                    if(RenoiseUtil.isRecording()) {
                        RenoiseUtil.lineMoveBy(renoiseState.editStep);
                    }
                case [OCTAVE_UP, TrackNote(index)]:
                case [OCTAVE_DOWN, TrackNote(index)]:
                case _:
            }
        }
    }

    private var _softKeys :SoftKeys;
}

