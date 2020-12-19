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

import fire.fromFire.ControllerState.BrowsterListItem;
import fire.fromFire.ControllerStateReadOnly;
import lady.renoise.midi.Midi.MidiOutputDevice;
import lady.renoise.Renoise;

class List
{
    public static function draw(controllerState :ControllerStateReadOnly, outputDevice :MidiOutputDevice, display :Display, item :BrowsterListItem) : Void
    {
        display.clear();
        settings(controllerState, display, item);
        display.render(outputDevice);
    }

    private static function settings(controllerState :ControllerStateReadOnly, display :Display, item :BrowsterListItem) : Void
    {
        display.drawText("Selection", 0, 0, false, false);
        var x = display.drawText("1:", 0, 8, false, false);
        display.drawText("Sequencer", x, 8, false, item == B_SEQ);

        var x = display.drawText("2:", 0, 16, false, false);
        display.drawText("Instruments", x, 16, false, item == B_INST);

        var x = display.drawText("3:", 0, 24, false, false);
        display.drawText("Settings", x, 24, false, item == B_SETTINGS);

        var x = display.drawText("4:", 0, 32, false, false);
        display.drawText("Trigger Options", x, 32, false, item == B_TRIGGER_OPTIONS);
    }
}