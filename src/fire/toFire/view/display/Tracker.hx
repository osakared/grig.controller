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

package fire.toFire.view.display;

import fire.fromFire.ControllerStateReadOnly;
import renoise.midi.Midi.MidiOutputDevice;
import fire.util.Math;
import renoise.song.EffectColumn;
import renoise.Renoise;
import renoise.song.NoteColumn;
using lua.PairTools;

class Tracker
{
    public static function draw(controllerState :ControllerStateReadOnly, outputDevice :MidiOutputDevice, display :Display, padIndex :Int) : Void
    {
        display.clear();
        display.drawText(Renoise.song().selectedTrack.name, 18, 0, false, false);
        var visibleNoteColumns = Renoise.song().selectedTrack.visibleNoteColumns;
        var visibleEffectColumns = Renoise.song().selectedTrack.visibleEffectColumns;

        for(i in 0...7) {
            var drawIndex = padIndex + i - 3;
            var x = drawLineIndex(display, 0, drawIndex, i + 1, false);
            var highlight = i - 3 == 0;

            for(columnIndex in 0...visibleNoteColumns) {
                x = drawNoteColumn(display, x, drawIndex, i + 1, columnIndex + 1, highlight);
            }

            for(columnIndex in 0...visibleEffectColumns) {
                x = drawEffectColumn(display, x, drawIndex, i + 1, columnIndex + 1, highlight);
            }
        }

        display.render(outputDevice);
    }

    private static function lineString(line :Int) : String
    {
        var lineStr = "" + line;
        return lineStr.length == 1
            ? "0" + lineStr
            : lineStr;
    }

    private static function drawLineIndex(display :Display, x :Int, index :Int, row :Int, highlight :Bool) : Int
    {
        index = Math.mod(index, 64);
        var line = lineString(index - 1);
        var isUnderlined = (index - 1) % Renoise.song().transport.lpb == 0;
        x = display.drawText(line, x, 8 * row, false, isUnderlined);
        return display.drawText(" ", x, 8 * row, false, false);
    }

    private static function drawNoteColumn(display :Display, x :Int, index :Int, row :Int, noteColumnIndex :Int, highlight :Bool) : Int
    {
        index = Math.mod(index, 64);
        var noteColumn = Renoise.song().selectedPatternTrack.line(index).noteColumn(noteColumnIndex);
        x = drawNote(display, noteColumn, noteColumnIndex, x, row, highlight);
        x = drawInst(display, noteColumn, noteColumnIndex, x, row, highlight);
        x = drawSpacer(display, x, row);
        x = drawVol(display, noteColumn, noteColumnIndex, x, row, highlight);
        return drawSpacer(display, x, row);
    }

    private static function drawEffectColumn(display :Display, x :Int, index :Int, row :Int, effectColumnIndex :Int, highlight :Bool) : Int
    {
        index = Math.mod(index, 64);
        var effectColumn = Renoise.song().selectedPatternTrack.line(index).effectColumn(effectColumnIndex);
        x = drawFXNumber(display, effectColumn, effectColumnIndex, x, row, highlight);
        x = drawFXAmount(display, effectColumn, effectColumnIndex, x, row, highlight);
        return display.drawText("|", x, 8 * row, false, false);
    }

    private static inline function drawNote(display :Display, noteColumn:NoteColumn, noteColumnIndex :Int, x :Int, row :Int, highlight :Bool) : Int
    {
        // var willHighlight = cursor == Cursor.NOTE && highlight && noteColumnIndex == Renoise.song().selectedNoteColumnIndex;
        var willHighlight = highlight && noteColumnIndex == Renoise.song().selectedNoteColumnIndex;
        return display.drawText(noteColumn.noteString, x, 8 * row, false, willHighlight);
    }

    private static inline function drawInst(display :Display, noteColumn:NoteColumn, noteColumnIndex :Int, x :Int, row :Int, highlight :Bool) : Int
    {
        var willHighlight = false;
        // var willHighlight = cursor == Cursor.INST && highlight && noteColumnIndex == Renoise.song().selectedNoteColumnIndex;
        return display.drawText(noteColumn.instrumentString, x, 8 * row, false, willHighlight);
    }

    private static inline function drawVol(display :Display, noteColumn:NoteColumn, noteColumnIndex :Int, x :Int, row :Int, highlight :Bool) : Int
    {
        var willHighlight = false;
        // var willHighlight = cursor == Cursor.VOL && highlight && noteColumnIndex == Renoise.song().selectedNoteColumnIndex;
        return display.drawText(noteColumn.volumeString, x, 8 * row, false, willHighlight);
    }

    private static inline function drawFXNumber(display :Display, effectColumn:EffectColumn, effectColumnIndex :Int, x :Int, row :Int, highlight :Bool) : Int
    {
        var willHighlight = false;
        // var willHighlight = cursor == Cursor.FX_NUM && highlight && effectColumnIndex == Renoise.song().selectedEffectColumnIndex;
        return display.drawText(effectColumn.numberString, x, 8 * row, false, willHighlight);
    }

    private static inline function drawFXAmount(display :Display, effectColumn:EffectColumn, effectColumnIndex :Int, x :Int, row :Int, highlight :Bool) : Int
    {
        var willHighlight = false;
        // var willHighlight = cursor == Cursor.FX_AMOUNT && highlight && effectColumnIndex == Renoise.song().selectedEffectColumnIndex;
        return display.drawText(effectColumn.amountString, x, 8 * row, false, willHighlight);
    }

    private static inline function drawSpacer(display :Display, x :Int, row :Int) : Int
    {
        return display.drawText("|", x, 8 * row, false, false);
    }
}