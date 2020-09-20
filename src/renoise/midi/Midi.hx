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
    @:native("available_input_devices")
    public static function availableInputDevices() : Array<Null<String>>;
    @:native("available_output_devices")
    public static function availableOutputDevices() : Array<Null<String>>;
    @:native("devices_changed_observable")
    public static function devicesChangedObservable() : Dynamic;
    @:native("create_input_device")
    public static function createInputDevice(device_name :String, callback :MidiMsg -> Void, sysex_callback :Dynamic -> Void) : MidiInputDevice;
    @:native("create_output_device")
    public static function createOutputDevice(device_name :String) : MidiOutputDevice;
}

extern class MidiInputDevice
{
    @:native("is_open")
    public var isOpen (default , null) : Bool;
    public var name (default , null) : String;
    public function close() : Void;
}

extern class MidiOutputDevice
{
    @:native("is_open")
    public var isOpen (default , null) : Bool;
    public var name (default , null) : String;
    public function close() : Void;
    public function send(msg :LuaArray<Int>) : Void;
}