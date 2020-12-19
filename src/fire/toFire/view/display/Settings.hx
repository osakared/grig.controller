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

class Settings
{
    public static function draw(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, outputDevice :MidiOutputDevice, display :Display) : Void
    {
        display.clear();
        settings(controllerState, renoiseState, display);
        display.render(outputDevice);
    }

    private static function settings(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, display :Display) : Void
    {
        display.drawText("Settings", 0, 0, false, false);
        editStep(controllerState, renoiseState, display);
        bpm(controllerState, renoiseState, display);
    }

    private static inline function editStep(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, display :Display) : Void
    {
        var editStep = renoiseState.editStep;
        var x = display.drawText('Edit Step:', 0, 8, false, false);
        display.drawText('${editStep}', x, 8, false, controllerState.settingSelection.value == EDIT_STEP);
    }

    private static inline function bpm(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState, display :Display) : Void
    {
        var bpm = renoiseState.bpm;
        var x = display.drawText('BPM:', 0, 16, false, false);
        display.drawText('${bpm}', x, 16, false, controllerState.settingSelection.value == BPM);
    }
}