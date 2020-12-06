/*
 * Copyright (c) 2020 Jeremy Meltingtallow
 *
 * Permission is hereby granted, free of charge, to any peon obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit peons to whom the Software is furnished to do so,
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

package fire.util;

import renoise.song.TrackColor;

class Color
{
    public var r (get, set) : Int;
    public var g (get, set) : Int;
    public var b (get, set) : Int;

    public var re (default, null) : Int = 0;
    public var ge (default, null) : Int = 0;
    public var be (default, null) : Int = 0;

    public function new(r :Int, g :Int, b :Int) : Void
    {
        this.r = r;
        this.g = g;
        this.b = b;
    }

    public static function fromTrackColor(color :TrackColor) : Color
    {
        return new Color(Std.int(color.r/2), Std.int(color.g/2), Std.int(color.b/2));
    }

    private inline function get_r() : Int
    {
        return _r;
    }

    private inline function get_g() : Int
    {
        return _g;
    }

    private inline function get_b() : Int
    {
        return _b;
    }

    private function set_r(r :Int) : Int
    {
        _r = Math.clamp(r, 0, 0x7f);
        this.re = Math.clamp(r + EXCITED_VAL, 0, 0x7f);
        return _r;
    }

    private function set_g(g :Int) : Int
    {
        _g = Math.clamp(g, 0, 0x7f);
        this.ge = Math.clamp(g + EXCITED_VAL, 0, 0x7f);
        return _g;
    }

    private function set_b(b :Int) : Int
    {
        _b = Math.clamp(b, 0, 0x7f);
        this.be = Math.clamp(b + EXCITED_VAL, 0, 0x7f);
        return _b;
    }

    private var _r = 0;
    private var _g = 0;
    private var _b = 0;
    private static var EXCITED_VAL = 10;
}