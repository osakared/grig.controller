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

package renoise.midi;

import fire.LuaArray;

@:native("renoise.Midi")
extern class Midi
{
    extern public static function available_input_devices() : Array<Null<String>>;
    extern public static function available_output_devices() : Array<Null<String>>;
    extern public static function devices_changed_observable() : Dynamic;
    extern public static function create_input_device(device_name :String, callback :MidiMsg -> Void, sysex_callback :Dynamic -> Void) : MidiInputDevice;
    extern public static function create_output_device(device_name :String) : MidiOutputDevice;
}

extern class MidiInputDevice
{
    extern public var is_open (default , null) : Bool;
    extern public var name (default , null) : String;
    extern public function close() : Void;
}

class MidiOutputDevice
{
    extern public var is_open (default , null) : Bool;
    extern public var name (default , null) : String;
    extern public function close() : Void;
    extern public function send(msg :LuaArray<Int>) : Void;
}