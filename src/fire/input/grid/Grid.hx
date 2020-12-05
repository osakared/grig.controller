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

package fire.input.grid;

import fire.util.Signal0;
import fire.util.Signal1;

class Grid
{
    public var hasDown (get, never) : Bool;
    public var fire (default, null) : Signal0;
    public var onUp (default, null) : Signal1<Null<Int>>;
    public var onDown (default, null) : Signal1<Null<Int>>;

    public function new() : Void
    {
        this.fire = new Signal0();
        this.onUp = new Signal1(null);
        this.onDown = new Signal1(null);
        _lengthDown = 0;
        _pads = new Map<Int, Int>();
    }

    public function down(pad :Int) : Void
    {
        if(!_pads.exists(pad)) {
            _pads.set(pad, pad);
            _lengthDown++;
            this.onDown.value = pad;
            this.fire.emit();
        }
    }

    public function up(pad :Int) : Void
    {
        if(_pads.exists(pad)) {
            _pads.remove(pad);
            _lengthDown--;
            this.onUp.value = pad;
            this.fire.emit();
        }
    }

    public inline function iterator() : Iterator<Int>
    {
        return _pads.iterator();
    }

    public inline function isDown(pad :Int) : Bool
    {
        return _pads.exists(pad);
    }

    private function get_hasDown() : Bool
    {
        return _lengthDown > 0;
    }

    private var _lengthDown :Int;
    private var _pads :Map<Int, Int>;
}