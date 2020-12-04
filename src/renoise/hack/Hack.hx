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

package renoise.hack;

import fire.util.Signal1;

class Hack
{
    public var cursor :Signal1<Cursor>;

    public function new() : Void
    {
        this.cursor = new Signal1(NOTE);
        this.init();
    }

    public function moveCursorLeft() : Void
    {
        switch this.cursor.value {
            case NOTE:
                if(Renoise.song().selectedNoteColumnIndex > 1) {
                    Renoise.song().selectedNoteColumnIndex -= 1;
                    this.cursor.value = VOL;
                }
            case INST:
                this.cursor.value = NOTE;
            case VOL:
                this.cursor.value = INST;
            case FX_NUM:
                if(Renoise.song().selectedEffectColumnIndex > 1) {
                    Renoise.song().selectedEffectColumnIndex -= 1;
                    this.cursor.value = FX_AMOUNT;
                }
                else {
                    Renoise.song().selectedNoteColumnIndex = Renoise.song().selectedTrack.visibleNoteColumns;
                    this.cursor.value = VOL;
                }
            case FX_AMOUNT:
                this.cursor.value = FX_NUM;
        }
    }

    public function moveCursorRight() : Void
    {
        switch this.cursor.value {
            case NOTE:
                this.cursor.value = INST;
            case INST:
                this.cursor.value = VOL;
            case VOL:
                if(Renoise.song().selectedNoteColumnIndex < Renoise.song().selectedTrack.visibleNoteColumns) {
                    Renoise.song().selectedNoteColumnIndex += 1;
                    this.cursor.value = NOTE;
                }
                else if(Renoise.song().selectedTrack.visibleEffectColumns != 0) {
                    Renoise.song().selectedEffectColumnIndex = 1;
                    this.cursor.value = FX_NUM;
                }
            case FX_NUM:
                this.cursor.value = FX_AMOUNT;
            case FX_AMOUNT:
                if(Renoise.song().selectedEffectColumnIndex < Renoise.song().selectedTrack.visibleEffectColumns) {
                    Renoise.song().selectedEffectColumnIndex += 1;
                    this.cursor.value = FX_NUM;
                }
        }
    }

    private function init() : Void
    {
        if(Renoise.song().selectedNoteColumnIndex != 0) {
            this.cursor.value = NOTE;
        }
        else {
            this.cursor.value = FX_NUM;
        }
    }
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