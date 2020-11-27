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

import fire.util.State;
import renoise.Renoise;
import renoise.midi.Midi.MidiOutputDevice;
import fire.toFire.button.ButtonLights;
import fire.fromFire.button.ButtonsReadOnly;

class Buttons
{
    public function new(state :State, buttons :ButtonLights, buttonInputs :ButtonsReadOnly, outputDevice :MidiOutputDevice) : Void
    {
        _state = state;
        _buttons = buttons;
        _outputDevice = outputDevice;
        _buttonInputs = buttonInputs;
        resetLights();
        initializeListeners();
    }

    private function resetLights() : Void
    {
        handlePatternUp();
        handlePatternDown();
        handleBrowser();
        handleGridLeft();
        handleGridRight();
        handleMuteSolo1();
        handleMuteSolo2();
        handleMuteSolo3();
        handleMuteSolo4();
        handleThingThing();
        handleShift();
        handleAlt();
        handlePatternSong();
        handlePlay();
        handleStop();
        handleRecord();
    }

    private function handlePatternUp() : Void
    {
        var isDown = _buttonInputs.patternUp.value;
        if(isDown) {
            _buttons.patternUp.send(_outputDevice, 1);
        }
        else {
            _buttons.patternUp.send(_outputDevice, 0);
        }
    }

    private function handlePatternDown() : Void
    {
        var isDown = _buttonInputs.patternDown.value;
        if(isDown) {
            _buttons.patternDown.send(_outputDevice, 1);
        }
        else {
            _buttons.patternDown.send(_outputDevice, 0);
        }
    }

    private function handleBrowser() : Void
    {
        var isDown = _buttonInputs.browser.value;
        if(isDown) {
            _buttons.browser.send(_outputDevice, 1);
        }
        else {
            _buttons.browser.send(_outputDevice, 0);
        }
    }

    private function handleGridLeft() : Void
    {
        var isDown = _buttonInputs.gridLeft.value;
        if(isDown) {
            _buttons.gridLeft.send(_outputDevice, 1);
        }
        else {
            _buttons.gridLeft.send(_outputDevice, 0);
        }
    }

    private function handleGridRight() : Void
    {
        var isDown = _buttonInputs.gridRight.value;
        if(isDown) {
            _buttons.gridRight.send(_outputDevice, 1);
        }
        else {
            _buttons.gridRight.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo1() : Void
    {
        var isDown = _buttonInputs.muteSolo1.value;
        if(isDown) {
            _buttons.muteSolo1.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo1.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo2() : Void
    {
        var isDown = _buttonInputs.muteSolo2.value;
        if(isDown) {
            _buttons.muteSolo2.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo2.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo3() : Void
    {
        var isDown = _buttonInputs.muteSolo3.value;
        if(isDown) {
            _buttons.muteSolo3.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo3.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo4() : Void
    {
        var isDown = _buttonInputs.muteSolo4.value;
        if(isDown) {
            _buttons.muteSolo4.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo4.send(_outputDevice, 0);
        }
    }

    private function handleThingThing() : Void
    {
        if(_buttonInputs.step.value) {
            _buttons.step.send(_outputDevice, 2);
            _state.input.value = STEP;
        }
        else {
            switch _state.input.value {
                case STEP:
                    _buttons.step.send(_outputDevice, 4);
                case _:
                    _buttons.step.send(_outputDevice, 0);
            }
        }

        if(_buttonInputs.note.value) {
            _buttons.note.send(_outputDevice, 2);
            _state.input.value = NOTE;
        }
        else {
            switch _state.input.value {
                case NOTE:
                    _buttons.note.send(_outputDevice, 4);
                case _:
                    _buttons.note.send(_outputDevice, 0);
            }
        }

        if(_buttonInputs.drum.value) {
            _buttons.drum.send(_outputDevice, 2);
            _state.input.value = DRUM;
        }
        else {
            switch _state.input.value {
                case DRUM:
                    _buttons.drum.send(_outputDevice, 4);
                case _:
                    _buttons.drum.send(_outputDevice, 0);
            }
        }

        if(_buttonInputs.perform.value) {
            _buttons.perform.send(_outputDevice, 2);
            _state.input.value = PERFORM;
        }
        else {
            switch _state.input.value {
                case PERFORM:
                    _buttons.perform.send(_outputDevice, 4);
                case _:
                    _buttons.perform.send(_outputDevice, 0);
            }
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
        _buttonInputs.patternUp.addListener((_, _) -> handlePatternUp());
        _buttonInputs.patternDown.addListener((_, _) -> handlePatternDown());
        _buttonInputs.browser.addListener((_, _) -> handleBrowser());
        _buttonInputs.gridLeft.addListener((_, _) -> handleGridLeft());
        _buttonInputs.gridRight.addListener((_, _) -> handleGridRight());
        _buttonInputs.muteSolo1.addListener((_, _) -> handleMuteSolo1());
        _buttonInputs.muteSolo2.addListener((_, _) -> handleMuteSolo2());
        _buttonInputs.muteSolo3.addListener((_, _) -> handleMuteSolo3());
        _buttonInputs.muteSolo4.addListener((_, _) -> handleMuteSolo4());
        _buttonInputs.step.addListener((_, _) -> handleThingThing());
        _buttonInputs.note.addListener((_, _) -> handleThingThing());
        _buttonInputs.drum.addListener((_, _) -> handleThingThing());
        _buttonInputs.perform.addListener((_, _) -> handleThingThing());
        _buttonInputs.shift.addListener((_, _) -> handleShift());
        _buttonInputs.alt.addListener((_, _) -> handleAlt());
        _buttonInputs.patternSong.addListener((_, _) -> handlePatternSong());

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            handlePlay();
        });
        _buttonInputs.play.addListener((_, _) -> handlePlay());

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            handleStop();
        });
        _buttonInputs.stop.addListener((_, _) -> handleStop());

        Renoise.song().transport.editModeObservable.addNotifier(() -> {
            handleRecord();
        });
        _buttonInputs.record.addListener((_, _) -> handleRecord());
    }

    private var _buttonInputs :ButtonsReadOnly;
    private var _buttons :ButtonLights;
    private var _outputDevice :MidiOutputDevice;
    private var _state :State;
}