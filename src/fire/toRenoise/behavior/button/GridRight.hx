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

package fire.toRenoise.behavior.button;

import renoise.Renoise;
import fire.fromFire.ControllerStateReadOnly;

class GridRight
{
    public static function handle(isDown: Bool, softKeys :SoftKeys, state :ControllerStateReadOnly) : Void
    {
        if(isDown) {
            // onDown();
        }
        else {
            onUp(state);
        }
    }

    private static function onUp(state :ControllerStateReadOnly) : Void
    {
        // switch gridIndex.value {
        //     case Note:
        //         gridIndex.value = Inst;
        //     case Inst:
        //         gridIndex.value = Vol;
        //     case Vol:
        //         if(Renoise.song().selectedNoteColumnIndex < Renoise.song().selectedTrack.visibleNoteColumns) {
        //             Renoise.song().selectedNoteColumnIndex += 1;
        //             gridIndex.value = Note;
        //         }
        //         else if(Renoise.song().selectedTrack.visibleEffectColumns != 0) {
        //             Renoise.song().selectedEffectColumnIndex = 1;
        //             gridIndex.value = FXNum;
        //         }
        //         else if(Renoise.song().selectedTrackIndex < Renoise.song().sequencerTrackCount) {
        //             Renoise.song().selectedTrackIndex += 1;
        //             gridIndex.value = Note;
        //         }
        //     case FXNum:
        //         gridIndex.value = FXAmount;
        //     case FXAmount:
        //         if(Renoise.song().selectedEffectColumnIndex < Renoise.song().selectedTrack.visibleEffectColumns) {
        //             Renoise.song().selectedEffectColumnIndex += 1;
        //             gridIndex.value = FXNum;
        //         }
        //         else if(Renoise.song().selectedTrackIndex < Renoise.song().sequencerTrackCount) {
        //             Renoise.song().selectedTrackIndex += 1;
        //             gridIndex.value = Note;
        //         }
        // }
    }
}