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

package fire.toRenoise.behavior.button;

import lady.renoise.Renoise;
import fire.util.RenoiseUtil;
import fire.fromRenoise.RenoiseState;
import fire.fromFire.ControllerStateReadOnly;

class Stop
{
    public static function handle(isDown: Bool, softKeys :SoftKeys, state :ControllerStateReadOnly, renoiseState :RenoiseState) : Void
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
        if(Renoise.song().transport.playing) {
            Renoise.song().transport.playing = false;
        }
        else {
            RenoiseUtil.setPos(1, 64);
        }
    }
}