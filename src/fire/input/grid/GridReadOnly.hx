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

import fire.util.Signal0ReadOnly;
import fire.util.Signal1ReadOnly;

abstract GridReadOnly(Grid) from Grid
{
    public var hasDown (get, never) : Bool;
    public var fire (get, never) : Signal0ReadOnly;
    public var onUp (get, never) : Signal1ReadOnly<Null<Int>>;
    public var onDown (get, never) : Signal1ReadOnly<Null<Int>>;

    public inline function isDown(pad :Int) : Bool
    {
        return this.isDown(pad);
    }

    public inline function iterator() : Iterator<Int>
    {
        return this.iterator();
    }

    private inline function get_hasDown() : Bool
    {
        return this.hasDown;
    }

    private inline function get_fire() : Signal0ReadOnly
    {
        return this.fire;
    }

    private inline function get_onUp() : Signal1ReadOnly<Null<Int>>
    {
        return this.onUp;
    }

    private inline function get_onDown() : Signal1ReadOnly<Null<Int>>
    {
        return this.onDown;
    }
}