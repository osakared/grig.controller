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

package fire.fromFire;

import fire.util.Signal1;
import fire.util.Signal1ReadOnly;

class Grid
{
    public function new() : Void
    {
        _pads = [for (i in 0...64) new Signal1(false)];
    }

    public function down(pad :Int) : Void
    {
        _pads[pad].value = true;
    }

    public function up(pad :Int) : Void
    {
        _pads[pad].value = false;
    }

    public function isDown(pad :Int) : Bool
    {
        return _pads[pad].value;
    }

    public function connect(pad :Int) : Signal1ReadOnly<Bool>
    {
        return _pads[pad];
    }

    private var _pads : Array<Signal1<Bool>>;
}