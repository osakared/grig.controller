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

package fire.toRenoise.button;

import renoise.Renoise;

class GridLeft
{
    public function onUp() : Void
    {
        // switch gridIndex.value {
        //     case Note: {
        //         if(Renoise.song().selectedNoteColumnIndex > 1) {
        //             Renoise.song().selectedNoteColumnIndex -= 1;
        //             gridIndex.value = Vol;
        //         }
        //         else if(Renoise.song().selectedTrackIndex > 1) {
        //             Renoise.song().selectedTrackIndex -= 1;
        //             if(Renoise.song().selectedTrack.visibleEffectColumns != 0) {
        //                 Renoise.song().selectedEffectColumnIndex = Renoise.song().selectedTrack.visibleEffectColumns;
        //                 gridIndex.value = FXAmount;
        //             }
        //             else {
        //                 Renoise.song().selectedNoteColumnIndex = Renoise.song().selectedTrack.visibleNoteColumns;
        //                 gridIndex.value = Vol;
        //             }
        //         }
        //     }
        //     case Inst:
        //         gridIndex.value = Note;
        //     case Vol:
        //         gridIndex.value = Inst;
        //     case FXNum:
        //         if(Renoise.song().selectedEffectColumnIndex > 1) {
        //             Renoise.song().selectedEffectColumnIndex -= 1;
        //             gridIndex.value = FXAmount;
        //         }
        //         else {
        //             Renoise.song().selectedNoteColumnIndex = Renoise.song().selectedTrack.visibleNoteColumns;
        //             gridIndex.value = Vol;
        //         }
        //     case FXAmount:
        //         gridIndex.value = FXNum;
        // }
    }
}