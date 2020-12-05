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

package fire.fireout.button;

import renoise.Renoise;
import renoise.midi.Midi.MidiOutputDevice;
import fire.fireout.button.ButtonLights;
import fire.fireout.button.behavior.*;
import fire.fromFire.ControllerStateReadOnly;

class Buttons
{
    public function new(buttons :ButtonLights, controllerState :ControllerStateReadOnly, outputDevice :MidiOutputDevice) : Void
    {
        _buttons = buttons;
        _outputDevice = outputDevice;
        _controllerState = controllerState;
        _behaviors = [
            Alt.handle,
            Browser.handle,
            GridLeft.handle,
            GridRight.handle,
            MuteSolo1.handle,
            MuteSolo2.handle,
            MuteSolo3.handle,
            MuteSolo4.handle,
            PatternDown.handle,
            PatternUp.handle,
            PatternSong.handle,
            Play.handle,
            Record.handle,
            Shift.handle,
            Stop.handle,
            Step.handle,
            Note.handle,
            Drum.handle,
            Perform.handle
        ];
        update();
        initializeListeners();
    }

    private function update() : Void
    {
        for(behavior in _behaviors) {
            behavior(_controllerState, _buttons, _outputDevice);
        }
    }

    private function initializeListeners() : Void
    {
        _controllerState.buttons.fire.addListener(update);
        Renoise.song().transport.playingObservable.addNotifier(update);
        Renoise.song().transport.editModeObservable.addNotifier(update);
    }

    private var _controllerState :ControllerStateReadOnly;
    private var _buttons :ButtonLights;
    private var _outputDevice :MidiOutputDevice;
    private var _behaviors : Array<Behavior>;
}