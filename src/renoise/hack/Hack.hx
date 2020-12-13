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

package renoise.hack;

import fire.util.Signal1;
import fire.util.Signal1ReadOnly;

class Hack
{
    public var cursor (get, never):Signal1ReadOnly<Cursor>;

    public function new() : Void
    {
        _cursor = new Signal1(NOTE);
        this.init();
    }

    public function moveCursorLeft() : Void
    {
        switch _cursor.value {
            case NOTE:
                if(Renoise.song().selectedNoteColumnIndex > 1) {
                    Renoise.song().selectedNoteColumnIndex -= 1;
                    _cursor.value = VOL;
                }
            case INST:
                _cursor.value = NOTE;
            case VOL:
                _cursor.value = INST;
            case FX_NUM:
                if(Renoise.song().selectedEffectColumnIndex > 1) {
                    Renoise.song().selectedEffectColumnIndex -= 1;
                    _cursor.value = FX_AMOUNT;
                }
                else {
                    Renoise.song().selectedNoteColumnIndex = Renoise.song().selectedTrack.visibleNoteColumns;
                    _cursor.value = VOL;
                }
            case FX_AMOUNT:
                _cursor.value = FX_NUM;
        }
    }

    public function moveCursorRight() : Void
    {
        switch _cursor.value {
            case NOTE:
                _cursor.value = INST;
            case INST:
                _cursor.value = VOL;
            case VOL:
                if(Renoise.song().selectedNoteColumnIndex < Renoise.song().selectedTrack.visibleNoteColumns) {
                    Renoise.song().selectedNoteColumnIndex += 1;
                    _cursor.value = NOTE;
                }
                else if(Renoise.song().selectedTrack.visibleEffectColumns != 0) {
                    Renoise.song().selectedEffectColumnIndex = 1;
                    _cursor.value = FX_NUM;
                }
            case FX_NUM:
                _cursor.value = FX_AMOUNT;
            case FX_AMOUNT:
                if(Renoise.song().selectedEffectColumnIndex < Renoise.song().selectedTrack.visibleEffectColumns) {
                    Renoise.song().selectedEffectColumnIndex += 1;
                    _cursor.value = FX_NUM;
                }
        }
    }

    private function init() : Void
    {
        var disposeLastObserved = observeTrackColumns();
        Renoise.song().selectedTrackIndexObservable.addNotifier(() -> {
            disposeLastObserved();
            disposeLastObserved = observeTrackColumns();
        });
        Renoise.song().selectedPatternTrackObservable.addNotifier(setTrackCursor);
        setTrackCursor();
    }

    private function setTrackCursor() : Void
    {
        if(Renoise.song().selectedNoteColumnIndex != 0) {
            _cursor.value = NOTE;
        }
        else {
            _cursor.value = FX_NUM;
        }
    }

    private function observeTrackColumns() {
        function effect() {
            if(Renoise.song().selectedTrack.visibleEffectColumns == 0) {
                if(Renoise.song().selectedNoteColumnIndex == 0) {
                    Renoise.song().selectedNoteColumnIndex = Renoise.song().selectedTrack.visibleNoteColumns;
                    _cursor.value = NOTE;
                }
            }
            else {
                _cursor.value = _cursor.value;
            }
        }
        function note() {
            _cursor.value = _cursor.value;
        }
        var track = Renoise.song().selectedTrack;

        track.visibleEffectColumnsObservable.addNotifier(effect);
        track.visibleNoteColumnsObservable.addNotifier(note);
        return () -> {
            track.visibleEffectColumnsObservable.removeNotifier(effect);
            track.visibleNoteColumnsObservable.removeNotifier(note);
        };
    }

    private inline function get_cursor() : Signal1ReadOnly<Cursor>
    {
        return _cursor;
    }

    private var _cursor :Signal1<Cursor>;
}

@:enum
abstract Cursor(Int)
{
    var NOTE = 0;
    var INST = 1;
    var VOL = 2;
    var FX_NUM = 3;
    var FX_AMOUNT = 4;
}