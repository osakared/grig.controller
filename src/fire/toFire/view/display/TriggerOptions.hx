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

package fire.toFire.view.display;

import fire.fromRenoise.RenoiseState;
import fire.fromFire.ControllerStateReadOnly;
import lady.renoise.midi.Midi.MidiOutputDevice;
import lady.renoise.Renoise;
import lady.display.Display;

class TriggerOptions
{
    public static function draw(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, outputDevice :MidiOutputDevice, display :Display) : Void
    {
        display.clear();
        options(controllerState, renoiseState, display);
        display.render(outputDevice);
    }

    private static function options(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, display :Display) : Void
    {
        display.drawText("Trigger Options", 0, 0, false, false);
        var y = 8;
        for(i in 0...renoiseState.scaleMode.available.length) {
            var realIndex = i + 1;
            var isSelected = realIndex == renoiseState.scaleMode.index.value;
            var x = display.drawText('${realIndex}:', 0, y, false, false);
            display.drawText(renoiseState.scaleMode.available[realIndex], x, y, false, isSelected);
            y += 8;
        }
    }
}