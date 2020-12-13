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

import fire.fromFire.ControllerStateReadOnly;
import renoise.midi.Midi.MidiOutputDevice;
import renoise.Renoise;

class Instruments
{
    public static function draw(controllerState :ControllerStateReadOnly, outputDevice :MidiOutputDevice, display :Display) : Void
    {
        display.clear();
        instruments(display);
        display.render(outputDevice);
    }

    private static function lineString(line :Int) : String
    {
        var lineStr = "" + line;
        return lineStr.length == 1
            ? "0" + lineStr
            : lineStr;
    }

    private static function instName(name :String) : String
    {
        return (name == null || name.length == 0)
            ? "                  "
            : name;
    }

    private static function instruments(display :Display) : Void
    {
        var instruments = Renoise.song().instruments;
        var activeIndex = Renoise.song().selectedInstrumentIndex;
        var length = instruments.length;
        var y = 0;
        for(i in 0...length) {
            var index = i + 1;
            var inst = instruments[index];
            var x = 0;
            var isActive = activeIndex == index;
            x = display.drawText('${lineString(index)}', x, y, false, false);
            x = display.drawText(':', x, y, false, false);
            display.drawText(instName(inst.name), x, y, false, isActive);
            y += 8;
        }
    }
}