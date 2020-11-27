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

package fire.toFire;

import fire.toFire.button.Buttons;
import renoise.song.EffectColumn;
import fire.util.Signal1;
import fire.util.Cursor;
import fire.util.Math;
import renoise.Renoise;
import renoise.song.NoteColumn;
import renoise.midi.Midi.MidiOutputDevice;
import fire.toFire.Display;
import fire.toFire.button.ButtonLights;
import fire.toFire.Grid;
import renoise.LineChaneObserver;
import fire.fromFire.button.ButtonsReadOnly;
import fire.util.State;
using lua.PairTools;

class ToFire
{
    public function new(state :State, outputDevice :MidiOutputDevice, buttonInputs :ButtonsReadOnly, gridIndex :Signal1<Cursor>) : Void
    {
        _outputDevice = outputDevice;
        _gridIndex = gridIndex;
        _display = new Display();
        _pads = new Grid(_outputDevice);
        _buttons = new ButtonLights();
        _transport = new Buttons(state, _buttons, buttonInputs, _outputDevice);
        this.initializeListeners(state);
        makeDrawCalls(state);
    }

    private function lineString(line :Int) : String
    {
        var lineStr = "" + line;
        return lineStr.length == 1
            ? "0" + lineStr
            : lineStr;
    }

    private function initializeListeners(state :StateReadOnly) : Void
    {
        var lineObserver = new LineChaneObserver();
        lineObserver.register(0, makeDrawCalls.bind(state));
        _gridIndex.addListener((_, _) -> {
            makeDrawCalls(state);
        });
        state.input.addListener((_, _) -> {
            makeDrawCalls(state);
        });
        Renoise.song().selectedPatternTrackObservable.addNotifier(makeDrawCalls.bind(state));
    }

    private function makeDrawCalls(state :StateReadOnly) : Void
    {
        if(Renoise.song().selectedNoteColumnIndex != 0 || Renoise.song().selectedEffectColumnIndex != 0) {
            var transport = Renoise.song().transport;
            var padIndex = transport.playbackPos.line;
            drawPads(state, padIndex);
            drawDisplay(padIndex);
        }
    }

    private function drawPads(state :StateReadOnly, padIndex :Int) : Void
    {
        _pads.clear();

        switch state.input.value {
            case STEP:
                drawPadsStep(padIndex);
            case NOTE:
                drawPadsNote();
            case DRUM:
            case PERFORM:
        }
        
        _pads.render(_outputDevice);
    }

    private function drawPadsStep(padIndex :Int) : Void
    {
        var lines = Renoise.song().selectedPatternTrack.linesInRange(1, 64);
        var hasDrawnPadIndex = false;
        lines.ipairsEach((index, line) -> {
            var noteValue = line.noteColumn(1).noteValue;
            if(noteValue < 120) {
                if(index == padIndex) {
                    _pads.drawPad(90, 0, 30, index - 1);
                    hasDrawnPadIndex = true;
                }
                else {
                    _pads.drawPad(40, 0, 40, index - 1);
                }
            }
        });
        if(!hasDrawnPadIndex) {
            _pads.drawPad(90,0,0, padIndex - 1);
        }
    }

    private function drawPadsNote() : Void
    {
        //octave1
        _pads.drawPad(0, 90, 30, 1);
        _pads.drawPad(0, 90, 30, 2);
        _pads.drawPad(0, 90, 30, 4);
        _pads.drawPad(0, 90, 30, 5);
        _pads.drawPad(0, 90, 30, 6);
        //
        _pads.drawPad(90, 0, 30, 16);
        _pads.drawPad(90, 0, 30, 17);
        _pads.drawPad(90, 0, 30, 18);
        _pads.drawPad(90, 0, 30, 19);
        _pads.drawPad(90, 0, 30, 20);
        _pads.drawPad(90, 0, 30, 21);
        _pads.drawPad(90, 0, 30, 22);

        //octave2
        _pads.drawPad(0, 90, 30, 8);
        _pads.drawPad(0, 90, 30, 9);
        _pads.drawPad(0, 90, 30, 11);
        _pads.drawPad(0, 90, 30, 12);
        _pads.drawPad(0, 90, 30, 13);
        //
        _pads.drawPad(90, 0, 30, 23);
        _pads.drawPad(90, 0, 30, 24);
        _pads.drawPad(90, 0, 30, 25);
        _pads.drawPad(90, 0, 30, 26);
        _pads.drawPad(90, 0, 30, 27);
        _pads.drawPad(90, 0, 30, 28);
        _pads.drawPad(90, 0, 30, 29);
        _pads.drawPad(90, 0, 30, 30);

        //octave3
        _pads.drawPad(0, 30, 90, 33);
        _pads.drawPad(0, 30, 90, 34);
        _pads.drawPad(0, 30, 90, 36);
        _pads.drawPad(0, 30, 90, 37);
        _pads.drawPad(0, 30, 90, 38);
        //
        _pads.drawPad(90, 30, 0, 48);
        _pads.drawPad(90, 30, 0, 49);
        _pads.drawPad(90, 30, 0, 50);
        _pads.drawPad(90, 30, 0, 51);
        _pads.drawPad(90, 30, 0, 52);
        _pads.drawPad(90, 30, 0, 53);
        _pads.drawPad(90, 30, 0, 54);

        //octave4
        _pads.drawPad(0, 30, 90, 40);
        _pads.drawPad(0, 30, 90, 41);
        _pads.drawPad(0, 30, 90, 43);
        _pads.drawPad(0, 30, 90, 44);
        _pads.drawPad(0, 30, 90, 45);
        //
        _pads.drawPad(90, 30, 0, 55);
        _pads.drawPad(90, 30, 0, 56);
        _pads.drawPad(90, 30, 0, 57);
        _pads.drawPad(90, 30, 0, 58);
        _pads.drawPad(90, 30, 0, 59);
        _pads.drawPad(90, 30, 0, 60);
        _pads.drawPad(90, 30, 0, 61);
        _pads.drawPad(90, 30, 0, 62);

        //util
        _pads.drawPad(70, 20, 10, 15);
        _pads.drawPad(70, 20, 10, 47);
        _pads.drawPad(70, 20, 10, 63);
    }

    private function drawDisplay(padIndex :Int) : Void
    {
        _display.clear();
        _display.drawText(Renoise.song().selectedTrack.name, 18, 0, false, false);
        var visibleNoteColumns = Renoise.song().selectedTrack.visibleNoteColumns;
        var visibleEffectColumns = Renoise.song().selectedTrack.visibleEffectColumns;

        for(i in 0...7) {
            var drawIndex = padIndex + i - 3;
            var x = drawLineIndex(0, drawIndex, i + 1, false);
            var highlight = i - 3 == 0;

            for(columnIndex in 0...visibleNoteColumns) {
                x = drawNoteColumn(x, drawIndex, i + 1, columnIndex + 1, highlight);
            }

            for(columnIndex in 0...visibleEffectColumns) {
                x = drawEffectColumn(x, drawIndex, i + 1, columnIndex + 1, highlight);
            }
        }

        _display.render(_outputDevice);
    }

    private function drawLineIndex(x :Int, index :Int, row :Int, highlight :Bool) : Int
    {
        index = Math.mod(index, 64);
        var line = lineString(index - 1);
        var isUnderlined = (index - 1) % Renoise.song().transport.lpb == 0;
        x = _display.drawText(line, x, 8 * row, false, isUnderlined);
        return _display.drawText(" ", x, 8 * row, false, false);
    }

    private function drawNoteColumn(x :Int, index :Int, row :Int, noteColumnIndex :Int, highlight :Bool) : Int
    {
        index = Math.mod(index, 64);
        var gi = _gridIndex.value;
        var noteColumn = Renoise.song().selectedPatternTrack.line(index).noteColumn(noteColumnIndex);
        x = drawNote(noteColumn, noteColumnIndex, x, row, gi, highlight);
        x = drawInst(noteColumn, noteColumnIndex, x, row, gi, highlight);
        x = drawSpacer(x, row);
        x = drawVol(noteColumn, noteColumnIndex, x, row, gi, highlight);
        return drawSpacer(x, row);
    }

    private function drawEffectColumn(x :Int, index :Int, row :Int, effectColumnIndex :Int, highlight :Bool) : Int
    {
        index = Math.mod(index, 64);
        var gi = _gridIndex.value;
        var effectColumn = Renoise.song().selectedPatternTrack.line(index).effectColumn(effectColumnIndex);
        x = drawFXNumber(effectColumn, effectColumnIndex, x, row, gi, highlight);
        x = drawFXAmount(effectColumn, effectColumnIndex, x, row, gi, highlight);
        return _display.drawText("|", x, 8 * row, false, false);
    }

    private inline function drawNote(noteColumn:NoteColumn, noteColumnIndex :Int, x :Int, row :Int, cursor :Cursor, highlight :Bool) : Int
    {
        var willHighlight = cursor == Note && highlight && noteColumnIndex == Renoise.song().selectedNoteColumnIndex;
        return _display.drawText(noteColumn.noteString, x, 8 * row, false, willHighlight);
    }

    private inline function drawInst(noteColumn:NoteColumn, noteColumnIndex :Int, x :Int, row :Int, cursor :Cursor, highlight :Bool) : Int
    {
        var willHighlight = cursor == Inst && highlight && noteColumnIndex == Renoise.song().selectedNoteColumnIndex;
        return _display.drawText(noteColumn.instrumentString, x, 8 * row, false, willHighlight);
    }

    private inline function drawVol(noteColumn:NoteColumn, noteColumnIndex :Int, x :Int, row :Int, cursor :Cursor, highlight :Bool) : Int
    {
        var willHighlight = cursor == Vol && highlight && noteColumnIndex == Renoise.song().selectedNoteColumnIndex;
        return _display.drawText(noteColumn.volumeString, x, 8 * row, false, willHighlight);
    }

    private inline function drawFXNumber(effectColumn:EffectColumn, effectColumnIndex :Int, x :Int, row :Int, cursor :Cursor, highlight :Bool) : Int
    {
        var willHighlight = cursor == FXNum && highlight && effectColumnIndex == Renoise.song().selectedEffectColumnIndex;
        return _display.drawText(effectColumn.numberString, x, 8 * row, false, willHighlight);
    }

    private inline function drawFXAmount(effectColumn:EffectColumn, effectColumnIndex :Int, x :Int, row :Int, cursor :Cursor, highlight :Bool) : Int
    {
        var willHighlight = cursor == FXAmount && highlight && effectColumnIndex == Renoise.song().selectedEffectColumnIndex;
        return _display.drawText(effectColumn.amountString, x, 8 * row, false, willHighlight);
    }

    private inline function drawSpacer(x :Int, row :Int) : Int
    {
        return _display.drawText("|", x, 8 * row, false, false);
    }

    private var _outputDevice :MidiOutputDevice;
    private var _display :Display;
    private var _pads :Grid;
    private var _buttons :ButtonLights;
    private var _transport :Buttons;
    private var _gridIndex :Signal1<Cursor>;
}