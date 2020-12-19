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

package fire.util;

import lady.renoise.Renoise;

class RenoiseUtil
{
    public static inline function isRecording() : Bool
    {
        return Renoise.song().transport.editMode;
    }

    public static function setPos(line :Int, modVal :Int) : Void
    {
        var playbackPos = Renoise.song().transport.playbackPos;
        playbackPos.line = Math.mod(line, modVal);
        Renoise.song().transport.playbackPos = playbackPos;

        var editPos = Renoise.song().transport.editPos;
        editPos.line = Math.mod(line, modVal);
        Renoise.song().transport.editPos = editPos;
    }

    public static function lineMoveBy(amount :Int) : Void
    {
        if(Renoise.song().transport.editMode) {
            RenoiseUtil.setPos(Renoise.song().transport.editPos.line + amount, 64);
        }
        else {
            RenoiseUtil.setPos(Renoise.song().transport.playbackPos.line + amount, 64);
        }
    }
}