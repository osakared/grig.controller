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
import fire.fromFire.ControllerStateReadOnly;

class Buttons
{
    public function new(buttons :ButtonLights, controllerState :ControllerStateReadOnly, outputDevice :MidiOutputDevice) : Void
    {
        _buttons = buttons;
        _outputDevice = outputDevice;
        _controllerState = controllerState;
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
        handleInput();
        handleShift();
        handleAlt();
        handlePatternSong();
        handlePlay();
        handleStop();
        handleRecord();
    }

    private function handlePatternUp() : Void
    {
        if(_controllerState.buttons.isDown(PATTERN_UP)) {
            _buttons.patternUp.send(_outputDevice, 1);
        }
        else {
            _buttons.patternUp.send(_outputDevice, 0);
        }
    }

    private function handlePatternDown() : Void
    {
        if(_controllerState.buttons.isDown(PATTERN_DOWN)) {
            _buttons.patternDown.send(_outputDevice, 1);
        }
        else {
            _buttons.patternDown.send(_outputDevice, 0);
        }
    }

    private function handleBrowser() : Void
    {
        if(_controllerState.buttons.isDown(BROWSER)) {
            _buttons.browser.send(_outputDevice, 1);
        }
        else {
            _buttons.browser.send(_outputDevice, 0);
        }
    }

    private function handleGridLeft() : Void
    {
        if(_controllerState.buttons.isDown(GRID_LEFT)) {
            _buttons.gridLeft.send(_outputDevice, 1);
        }
        else {
            _buttons.gridLeft.send(_outputDevice, 0);
        }
    }

    private function handleGridRight() : Void
    {
        if(_controllerState.buttons.isDown(GRID_RIGHT)) {
            _buttons.gridRight.send(_outputDevice, 1);
        }
        else {
            _buttons.gridRight.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo1() : Void
    {
        if(_controllerState.buttons.isDown(MUTE_SOLO_1)) {
            _buttons.muteSolo1.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo1.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo2() : Void
    {
        if(_controllerState.buttons.isDown(MUTE_SOLO_2)) {
            _buttons.muteSolo2.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo2.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo3() : Void
    {
        if(_controllerState.buttons.isDown(MUTE_SOLO_3)) {
            _buttons.muteSolo3.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo3.send(_outputDevice, 0);
        }
    }

    private function handleMuteSolo4() : Void
    {
        if(_controllerState.buttons.isDown(MUTE_SOLO_4)) {
            _buttons.muteSolo4.send(_outputDevice, 1);
        }
        else {
            _buttons.muteSolo4.send(_outputDevice, 0);
        }
    }

    private function handleInput() : Void
    {
        if(_controllerState.buttons.isDown(STEP)) {
            _buttons.step.send(_outputDevice, 2);
        }
        else {
            switch _controllerState.input.value {
                case STEP:
                    _buttons.step.send(_outputDevice, 4);
                case _:
                    _buttons.step.send(_outputDevice, 0);
            }
        }

        if(_controllerState.buttons.isDown(NOTE)) {
            _buttons.note.send(_outputDevice, 2);
        }
        else {
            switch _controllerState.input.value {
                case NOTE:
                    _buttons.note.send(_outputDevice, 4);
                case _:
                    _buttons.note.send(_outputDevice, 0);
            }
        }

        if(_controllerState.buttons.isDown(DRUM)) {
            _buttons.drum.send(_outputDevice, 2);
        }
        else {
            switch _controllerState.input.value {
                case DRUM:
                    _buttons.drum.send(_outputDevice, 4);
                case _:
                    _buttons.drum.send(_outputDevice, 0);
            }
        }

        if(_controllerState.buttons.isDown(PERFORM)) {
            _buttons.perform.send(_outputDevice, 2);
        }
        else {
            switch _controllerState.input.value {
                case PERFORM:
                    _buttons.perform.send(_outputDevice, 4);
                case _:
                    _buttons.perform.send(_outputDevice, 0);
            }
        }
    }

    private function handleShift() : Void
    {
        if(_controllerState.buttons.isDown(SHIFT)) {
            _buttons.shift.send(_outputDevice, 1);
        }
        else {
            _buttons.shift.send(_outputDevice, 0);
        }
    }

    private function handleAlt() : Void
    {
        if(_controllerState.buttons.isDown(ALT)) {
            _buttons.alt.send(_outputDevice, 1);
        }
        else {
            _buttons.alt.send(_outputDevice, 0);
        }
    }

    private function handlePatternSong() : Void
    {
        if(_controllerState.buttons.isDown(PATTERN_SONG)) {
            _buttons.patternSong.send(_outputDevice, 1);
        }
        else {
            _buttons.patternSong.send(_outputDevice, 0);
        }
    }

    private function handlePlay() : Void
    {
        if(_controllerState.buttons.isDown(PLAY)) {
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
        if(_controllerState.buttons.isDown(STOP)) {
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
        if(_controllerState.buttons.isDown(RECORD)) {
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
        _controllerState.buttons.change.addListener(handlePatternUp);
        _controllerState.buttons.change.addListener(handlePatternDown);
        _controllerState.buttons.change.addListener(handleBrowser);
        _controllerState.buttons.change.addListener(handleGridLeft);
        _controllerState.buttons.change.addListener(handleGridRight);
        _controllerState.buttons.change.addListener(handleMuteSolo1);
        _controllerState.buttons.change.addListener(handleMuteSolo2);
        _controllerState.buttons.change.addListener(handleMuteSolo3);
        _controllerState.buttons.change.addListener(handleMuteSolo4);
        _controllerState.buttons.change.addListener(handleInput);
        _controllerState.buttons.change.addListener(handleInput);
        _controllerState.buttons.change.addListener(handleInput);
        _controllerState.buttons.change.addListener(handleInput);
        _controllerState.buttons.change.addListener(handleShift);
        _controllerState.buttons.change.addListener(handleAlt);
        _controllerState.buttons.change.addListener(handlePatternSong);
        _controllerState.buttons.change.addListener(handlePlay);
        _controllerState.buttons.change.addListener(handleStop);
        _controllerState.buttons.change.addListener(handleRecord);

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            handlePlay();
        });

        Renoise.song().transport.playingObservable.addNotifier(() -> {
            handleStop();
        });

        Renoise.song().transport.editModeObservable.addNotifier(() -> {
            handleRecord();
        });
    }

    private var _controllerState :ControllerStateReadOnly;
    private var _buttons :ButtonLights;
    private var _outputDevice :MidiOutputDevice;
}