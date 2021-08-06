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

package lady.renoise;

import lady.renoise.application.Application;
import lady.renoise.song.Song;
import lady.renoise.tool.Tool;
import lady.renoise.hack.Hack;

@:native("renoise")
extern class Renoise
{
    extern public static var API_VERSION : Int;
    extern public static var RENOISE_VERSION : String;
    
    extern public static function app() :Application;

    extern public static function song() :Song;

    extern public static function tool() :Tool;

    extern public static inline function hack() :Hack
    {
        return RenoiseHack.hack;
    }
}

class RenoiseHack
{
    public static var hack (get, null) : Hack;

    private static function get_hack() : Hack
    {
        if(_hack == null) {
            _hack = new Hack();
        }
        return _hack;
    }

    private static var _hack :Hack = null;
}