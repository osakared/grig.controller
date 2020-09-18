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

package fire.button;

import renoise.Song.Renoise;
import renoise.Midi.MidiOutputDevice;
import fire.button.ButtonType;
import fire.LuaArray;
import fire.Color;

class Stop implements Button
{
    public var color : Int;
    public var type : ButtonType;

    public function new(type :ButtonType) : Void
    {
        this.type = type;
    }

    public function initialize(output :MidiOutputDevice, display :Display) : Void
    {
        Renoise.song().transport.playingObservable.addNotifier(() -> {
            this.update(output, display);
        });
        output.send(new LuaArray([0xB0, this.type, getColor()]));
    }

    public function down(output :MidiOutputDevice, display :Display) : Void
    {
        Renoise.song().transport.playing = false;
    }

    public function up(output :MidiOutputDevice, display :Display) : Void
    {
    }

    public function update(output :MidiOutputDevice, display :Display) : Void
    {
        output.send(new LuaArray([0xB0, this.type, getColor()]));
    }

    public function getColor() : Int
    {
        return Renoise.song().transport.playing
            ? Yellow.DULL_YELLOW
            : Yellow.HIGH_YELLOW;
    }
}