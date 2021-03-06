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

package fire.toFire;

import fire.fromRenoise.RenoiseState;
import fire.toFire.button.Buttons;
import lady.renoise.Renoise;
import lady.renoise.midi.Midi.MidiOutputDevice;
import lady.display.Display;
import fire.toFire.button.ButtonLights;
import fire.toFire.Grid;
import fire.fromFire.ControllerStateReadOnly;
import fire.toFire.view.display.Tracker;
import fire.toFire.view.display.Instruments;
import fire.toFire.view.display.Settings;
import fire.toFire.view.display.TriggerOptions;
import fire.toFire.view.display.List;
import fire.toFire.view.grid.Step;
import fire.toFire.view.grid.Piano;
using lua.PairTools;

class Fireout
{
    public function new(outputDevice :MidiOutputDevice, controllerState :ControllerStateReadOnly, renoiseState :RenoiseState) : Void
    {
        _outputDevice = outputDevice;
        _display = new Display();
        _pads = new Grid(_outputDevice);
        var buttonLights = new ButtonLights();
        new Buttons(buttonLights, controllerState, renoiseState, _outputDevice);
        Renoise.tool().appIdleObservable.addNotifier(draw.bind(controllerState, renoiseState));
        draw(controllerState, renoiseState);
    }

    private function draw(controllerState :ControllerStateReadOnly, renoiseState :RenoiseState) : Void
    {
        var padIndex =  renoiseState.currentPos.line;
        switch controllerState.input.value {
            case STEP:
                Step.draw(_outputDevice, _pads, padIndex);
            case NOTE:
                Piano.draw(_outputDevice, _pads, controllerState, renoiseState);
            case DRUM:
            case PERFORM:
        }
        switch controllerState.browser.value {
            case LIST(item):
                List.draw(controllerState, _outputDevice, _display, item);
            case SEQ:
                Tracker.draw(controllerState, _outputDevice, _display, padIndex);
            case INST:
                Instruments.draw(controllerState, _outputDevice, _display);
            case SETTINGS:
                Settings.draw(controllerState, renoiseState, _outputDevice, _display);
            case TRIGGER_OPTIONS:
                TriggerOptions.draw(controllerState, renoiseState, _outputDevice, _display);
        }
    }  

    private var _outputDevice :MidiOutputDevice;
    private var _display :Display;
    private var _pads :Grid;
}