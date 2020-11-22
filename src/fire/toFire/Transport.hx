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

package fire.toFire;

import renoise.Renoise;
import renoise.midi.Midi.MidiOutputDevice;
import fire.toFire.button.ButtonLights;
import fire.fromFire.button.ButtonsReadOnly as ButtonInputs;

class Transport
{
    public function new(buttons :ButtonLights, buttonInputs :ButtonInputs, outputDevice :MidiOutputDevice) : Void
    {
        _buttons = buttons;
        _outputDevice = outputDevice;
        _buttonInputs = buttonInputs;
        resetLights();
        initializeListeners();
    }

    private function resetLights() : Void
    {
        handlePlaying();
        handleStop();
        handleRecord();
    }

    private function handlePlaying() : Void
    {
        var isDown = _buttonInputs.play.value;
        if(isDown) {
            _buttons.play.send(_outputDevice, 1);
        }
        else {
            if(Renoise.song().transport.playing) {
                _buttons.play.send(_outputDevice, 3);
            }
            else {
                _buttons.play.send(_outputDevice, 0);
            }
        }
    }

    private function handleStop() : Void
    {
        var isDown = _buttonInputs.stop.value;
        if(isDown) {
            _buttons.stop.send(_outputDevice, 1);
        }
        else {
            if(Renoise.song().transport.playing) {
                _buttons.stop.send(_outputDevice, 0);
            }
            else {
                _buttons.stop.send(_outputDevice, 2);
            }
        }
    }

    private function handleRecord() : Void
    {
        var isDown = _buttonInputs.record.value;
        if(isDown) {
            _buttons.record.send(_outputDevice, 1);
        }
        else {
            if(Renoise.song().transport.editMode) {
                _buttons.record.send(_outputDevice, 3);
            }
            else {
                _buttons.record.send(_outputDevice, 0);
            }
        }
    }

    private function initializeListeners() : Void
    {
        Renoise.song().transport.playingObservable.addNotifier(() -> {
            handlePlaying();
        });
        _buttonInputs.play.addListener(_ -> handlePlaying());

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            handleStop();
        });
        _buttonInputs.stop.addListener(_ -> handleStop());

        Renoise.song().transport.editModeObservable.addNotifier(() -> {
            handleRecord();
        });
        _buttonInputs.record.addListener(_ -> handleRecord());
    }

    private var _buttonInputs :ButtonInputs;
    private var _buttons :ButtonLights;
    private var _outputDevice :MidiOutputDevice;
}