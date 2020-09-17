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

package fire;

abstract Color(Int) from Int to Int 
{
    public var red(get, set) : Int;
    public var blue(get, set) : Int;
    public var green(get, set) : Int;

    public inline function new(argb : Int) : Voidargb
    {
        this = argb;
    }

    function get_red() : Int
    {
        return 0;
    }

    inline function set_red(r : Int) : Int
    {
        return r;
    }

    function get_blue() : Int
    {
        return 0;
    }

    inline function set_blue(b : Int) : Int
    {
        return b;
    }

    function get_green() : Int
    {
        return 0;
    }

    inline function set_green(g : Int) : Int 
    {
        return g;
    }
}

@:enum
abstract RedYellow(Int) from Int to Int
{
    var OFF = 0x00;
    var DULL_RED = 0x01;
    var DULL_YELLOW = 0x02;
    var HIGH_RED = 0x03;
    var HIGH_YELLOW = 0x04;
}

@:enum
abstract Yellow(Int) from Int to Int
{
    var OFF = 0x00;
    var DULL_YELLOW = 0x01;
    var HIGH_YELLOW = 0x02;
}

@:enum
abstract Red(Int) from Int to Int
{
    var OFF = 0x00;
    var DULL_RED = 0x01;
    var HIGH_RED = 0x02;
}

@:enum
abstract Green(Int) from Int to Int
{
    var OFF = 0x00;
    var DULL_GREEN = 0x01;
    var HIGH_GREEN = 0x02;
}

@:enum
abstract YellowGreen(Int) from Int to Int
{
    var OFF = 0x00;
    var DULL_GREEN = 0x01;
    var DULL_YELLOW = 0x02;
    var HIGH_GREEN = 0x03;
    var HIGH_YELLOW = 0x04;
}