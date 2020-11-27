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
import fire.fromFire.ControllerStateReadOnly;
import fire.util.PadNote.PadNoteUtil;
using lua.PairTools;

class ToFire
{
    public function new(outputDevice :MidiOutputDevice, controllerState :ControllerStateReadOnly, gridIndex :Signal1<Cursor>) : Void
    {
        _outputDevice = outputDevice;
        _gridIndex = gridIndex;
        _display = new Display();
        _pads = new Grid(_outputDevice);
        var buttonLights = new ButtonLights();
        _transport = new Buttons(buttonLights, controllerState, _outputDevice);
        this.initializeListeners(controllerState);
        makeDrawCalls(controllerState);
    }

    private function lineString(line :Int) : String
    {
        var lineStr = "" + line;
        return lineStr.length == 1
            ? "0" + lineStr
            : lineStr;
    }

    private function initializeListeners(controllerState :ControllerStateReadOnly) : Void
    {
        var lineObserver = new LineChaneObserver();
        lineObserver.register(0, makeDrawCalls.bind(controllerState));
        _gridIndex.addListener((_, _) -> {
            makeDrawCalls(controllerState);
        });
        controllerState.input.addListener((_, _) -> {
            makeDrawCalls(controllerState);
        });
        controllerState.grid.change.addListener(makeDrawCalls.bind(controllerState));
        controllerState.dials.change.addListener(makeDrawCalls.bind(controllerState));
        Renoise.song().selectedPatternTrackObservable.addNotifier(makeDrawCalls.bind(controllerState));
    }

    private function makeDrawCalls(controllerState :ControllerStateReadOnly) : Void
    {
        if(Renoise.song().selectedNoteColumnIndex != 0 || Renoise.song().selectedEffectColumnIndex != 0) {
            var transport = Renoise.song().transport;
            var padIndex = transport.playbackPos.line;
            drawPads(controllerState, padIndex);
            drawDisplay(padIndex);
        }
    }

    private function drawPads(controllerState :ControllerStateReadOnly, padIndex :Int) : Void
    {
        _pads.clear();

        switch controllerState.input.value {
            case STEP:
                drawPadsStep(padIndex);
            case NOTE:
                drawPadsNote(controllerState);
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

    private function drawPadsNote(controllerState :ControllerStateReadOnly) : Void
    {
        for(pad in PadNoteUtil.keysBlack) {
            var offset = controllerState.grid.isDown(pad)
                ? 30
                : 0;
            _pads.drawPad(60 + offset, 0, 30 + offset, pad);
        }

        for(pad in PadNoteUtil.keysWhite) {
            var offset = controllerState.grid.isDown(pad)
                ? 30
                : 0;
            _pads.drawPad(60 + offset, 30 + offset, 0, pad);
        }
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
    private var _transport :Buttons;
    private var _gridIndex :Signal1<Cursor>;
}