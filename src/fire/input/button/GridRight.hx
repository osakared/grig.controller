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

package fire.input.button;

import renoise.Renoise;

class GridRight extends Button
{
    override public function onUp() : Void
    {
        switch activeKeys.gridIndex.value {
            case Note:
                activeKeys.gridIndex.value = Inst;
            case Inst:
                activeKeys.gridIndex.value = Vol;
            case Vol:
                if(Renoise.song().selectedNoteColumnIndex < Renoise.song().selectedTrack.visibleNoteColumns) {
                    Renoise.song().selectedNoteColumnIndex += 1;
                    activeKeys.gridIndex.value = Note;
                }
                else if(Renoise.song().selectedTrack.visibleEffectColumns != 0) {
                    Renoise.song().selectedEffectColumnIndex = 1;
                    activeKeys.gridIndex.value = FXNum;
                }
                else if(Renoise.song().selectedTrackIndex < Renoise.song().sequencerTrackCount) {
                    Renoise.song().selectedTrackIndex += 1;
                    activeKeys.gridIndex.value = Note;
                }
            case FXNum:
                activeKeys.gridIndex.value = FXAmount;
            case FXAmount:
                if(Renoise.song().selectedEffectColumnIndex < Renoise.song().selectedTrack.visibleEffectColumns) {
                    Renoise.song().selectedEffectColumnIndex += 1;
                    activeKeys.gridIndex.value = FXNum;
                }
                else if(Renoise.song().selectedTrackIndex < Renoise.song().sequencerTrackCount) {
                    Renoise.song().selectedTrackIndex += 1;
                    activeKeys.gridIndex.value = Note;
                }
        }
    }
}