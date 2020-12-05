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

import lua.Table;
import renoise.midi.Midi.MidiOutputDevice;
import fire.fromFire.button.ButtonType;

abstract ButtonLight(ButtonType) from Int
{
    inline public function new(value :ButtonType) : Void
    {
        this = value;
    }

    public inline function clear(output :MidiOutputDevice) : Void
    {
        send(output, 0);
    }

    public function send(output :MidiOutputDevice, value :Int) : Void
    {
        lightMsg[2] = this;
        lightMsg[3] = value;
        output.send(lightMsg);
    }

    private static var lightMsg :Table<Int, Int> = Table.create([0xB0]);
}