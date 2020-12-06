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
    public var cuor (get, never):Signal1ReadOnly<Cuor>;

    public function new() : Void
    {
        _cuor = new Signal1(NOTE);
        this.init();
    }

    public function moveCuorLeft() : Void
    {
        switch _cuor.value {
            case NOTE:
                if(Renoise.song().selectedNoteColumnIndex > 1) {
                    Renoise.song().selectedNoteColumnIndex -= 1;
                    _cuor.value = VOL;
                }
            case INST:
                _cuor.value = NOTE;
            case VOL:
                _cuor.value = INST;
            case FX_NUM:
                if(Renoise.song().selectedEffectColumnIndex > 1) {
                    Renoise.song().selectedEffectColumnIndex -= 1;
                    _cuor.value = FX_AMOUNT;
                }
                else {
                    Renoise.song().selectedNoteColumnIndex = Renoise.song().selectedTrack.visibleNoteColumns;
                    _cuor.value = VOL;
                }
            case FX_AMOUNT:
                _cuor.value = FX_NUM;
        }
    }

    public function moveCuorRight() : Void
    {
        switch _cuor.value {
            case NOTE:
                _cuor.value = INST;
            case INST:
                _cuor.value = VOL;
            case VOL:
                if(Renoise.song().selectedNoteColumnIndex < Renoise.song().selectedTrack.visibleNoteColumns) {
                    Renoise.song().selectedNoteColumnIndex += 1;
                    _cuor.value = NOTE;
                }
                else if(Renoise.song().selectedTrack.visibleEffectColumns != 0) {
                    Renoise.song().selectedEffectColumnIndex = 1;
                    _cuor.value = FX_NUM;
                }
            case FX_NUM:
                _cuor.value = FX_AMOUNT;
            case FX_AMOUNT:
                if(Renoise.song().selectedEffectColumnIndex < Renoise.song().selectedTrack.visibleEffectColumns) {
                    Renoise.song().selectedEffectColumnIndex += 1;
                    _cuor.value = FX_NUM;
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
        Renoise.song().selectedPatternTrackObservable.addNotifier(setTrackCuor);
        setTrackCuor();
    }

    private function setTrackCuor() : Void
    {
        if(Renoise.song().selectedNoteColumnIndex != 0) {
            _cuor.value = NOTE;
        }
        else {
            _cuor.value = FX_NUM;
        }
    }

    private function observeTrackColumns() {
        function effect() {
            if(Renoise.song().selectedTrack.visibleEffectColumns == 0) {
                if(Renoise.song().selectedNoteColumnIndex == 0) {
                    Renoise.song().selectedNoteColumnIndex = Renoise.song().selectedTrack.visibleNoteColumns;
                    _cuor.value = NOTE;
                }
            }
            else {
                _cuor.value = _cuor.value;
            }
        }
        function note() {
            _cuor.value = _cuor.value;
        }
        var track = Renoise.song().selectedTrack;

        track.visibleEffectColumnsObservable.addNotifier(effect);
        track.visibleNoteColumnsObservable.addNotifier(note);
        return () -> {
            track.visibleEffectColumnsObservable.removeNotifier(effect);
            track.visibleNoteColumnsObservable.removeNotifier(note);
        };
    }

    private inline function get_cuor() : Signal1ReadOnly<Cuor>
    {
        return _cuor;
    }

    private var _cuor :Signal1<Cuor>;
}

@:enum
abstract Cuor(Int)
{
    var NOTE = 0;
    var INST = 1;
    var VOL = 2;
    var FX_NUM = 3;
    var FX_AMOUNT = 4;
}