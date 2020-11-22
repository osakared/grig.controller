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

package fire.toFire.button;

import renoise.Renoise;
import renoise.midi.Midi.MidiOutputDevice;
import fire.toFire.button.ButtonLights;
import fire.fromFire.button.ButtonsReadOnly as ButtonInputs;

class BottomButtons
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
        handleStep();
        handleNote();
        handleDrum();
        handlePerform();
        handleShift();
        handleAlt();
        handlePatternSong();
        handlePlay();
        handleStop();
        handleRecord();
    }

    private function handleStep() : Void
    {
        var isDown = _buttonInputs.step.value;
        if(isDown) {
            _buttons.step.send(_outputDevice, 1);
        }
        else {
            _buttons.step.send(_outputDevice, 0);
        }
    }

    private function handleNote() : Void
    {
        var isDown = _buttonInputs.note.value;
        if(isDown) {
            _buttons.note.send(_outputDevice, 1);
        }
        else {
            _buttons.note.send(_outputDevice, 0);
        }
    }

    private function handleDrum() : Void
    {
        var isDown = _buttonInputs.drum.value;
        if(isDown) {
            _buttons.drum.send(_outputDevice, 1);
        }
        else {
            _buttons.drum.send(_outputDevice, 0);
        }
    }

    private function handlePerform() : Void
    {
        var isDown = _buttonInputs.perform.value;
        if(isDown) {
            _buttons.perform.send(_outputDevice, 1);
        }
        else {
            _buttons.perform.send(_outputDevice, 0);
        }
    }

    private function handleShift() : Void
    {
        var isDown = _buttonInputs.shift.value;
        if(isDown) {
            _buttons.shift.send(_outputDevice, 1);
        }
        else {
            _buttons.shift.send(_outputDevice, 0);
        }
    }

    private function handleAlt() : Void
    {
        var isDown = _buttonInputs.alt.value;
        if(isDown) {
            _buttons.alt.send(_outputDevice, 1);
        }
        else {
            _buttons.alt.send(_outputDevice, 0);
        }
    }

    private function handlePatternSong() : Void
    {
        var isDown = _buttonInputs.patternSong.value;
        if(isDown) {
            _buttons.patternSong.send(_outputDevice, 1);
        }
        else {
            _buttons.patternSong.send(_outputDevice, 0);
        }
    }

    private function handlePlay() : Void
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
        _buttonInputs.step.addListener(_ -> handleStep());
        _buttonInputs.note.addListener(_ -> handleNote());
        _buttonInputs.drum.addListener(_ -> handleDrum());
        _buttonInputs.perform.addListener(_ -> handlePerform());
        _buttonInputs.shift.addListener(_ -> handleShift());
        _buttonInputs.alt.addListener(_ -> handleAlt());
        _buttonInputs.patternSong.addListener(_ -> handlePatternSong());

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            handlePlay();
        });
        _buttonInputs.play.addListener(_ -> handlePlay());

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