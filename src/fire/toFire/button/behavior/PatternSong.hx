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

package fire.toFire.button.behavior;

import fire.fromRenoise.RenoiseState;
import fire.fromFire.ControllerStateReadOnly;
import lady.renoise.midi.Midi.MidiOutputDevice;

class PatternSong
{
    public static function handle(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, buttons :ButtonLights, outputDevice :MidiOutputDevice) : Void
    {
        if(controllerState.buttons.isDown(PATTERN_SONG)) {
            buttons.patternSong.send(outputDevice, 1);
        }
        else {
            buttons.patternSong.send(outputDevice, 0);
        }
    }
}