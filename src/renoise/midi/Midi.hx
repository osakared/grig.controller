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

@:native("renoise.Midi")
extern class Midi
{
    /**
     * Return a list of strings with the currently available devices. 
     * This list can change when devices are hot-plugged. See 
     * 'devices_changed_observable'
     * @return Array<Null<String>>
     */
    @:native("available_input_devices")
    public static function availableInputDevices() : Array<Null<String>>;


    @:native("available_output_devices")
    public static function availableOutputDevices() : Array<Null<String>>;

    /**
     * Fire notifications as soon as new devices become active or a 
     * previously added device gets removed/unplugged. This will only 
     * happen on Linux and OSX with real devices. On Windows this may 
     * happen when using ReWire slaves. ReWire adds virtual MIDI 
     * devices to Renoise. Already opened references to devices which 
     * are no longer available will do nothing. Aka, you can use them 
     * as before and they will not fire any errors. The messages will 
     * simply go into the void...
     * @return Dynamic
     */
    @:native("devices_changed_observable")
    public static function devicesChangedObservable() : Dynamic;

    /**
     * Listen to incoming MIDI data: opens access to a MIDI input 
     * device by specifying a device name. Name must be one of 
     * "available_input_devices". Returns a ready to use MIDI input 
     * device object. One or both callbacks should be valid, and 
     * should either point to a function with one 
     * parameter(message_table), or a table with an object and class, 
     * a method. All MIDI messages except active sensing will be 
     * forwarded to the callbacks. When Renoise is already listening 
     * to this device, your callback and Renoise (or even other 
     * scripts) will also handle the message. Messages are received 
     * until the device reference is manually closed 
     * (see midi_device:close()) or until the MidiInputDevice object 
     * gets garbage collected.
     * @param device_name 
     * @param callback 
     * @param sysex_callback 
     * @return MidiInputDevice
     */
    @:native("create_input_device")
    public static function createInputDevice(device_name :String, callback :MidiMsg -> Void, sysex_callback :Dynamic -> Void) : MidiInputDevice;

    /**
     * Send MIDI: open access to a MIDI device by specifying the 
     * device name. Name must be one of "available_input_devices". 
     * All other device names will fire an error. Returns a ready to 
     * use output device. The real device driver gets automatically 
     * closed when the MidiOutputDevice object gets garbage collected 
     * or when the device is explicitly closed via midi_device:close() 
     * and nothing else references it.
     * @param device_name 
     * @return MidiOutputDevice
     */
    @:native("create_output_device")
    public static function createOutputDevice(device_name :String) : MidiOutputDevice;
}

extern class MidiInputDevice
{
    /**
     * Returns true while the device is open (ready to send or receive
     * messages). Your device refs will never be auto-closed, "is_open" 
     * will only be false if you explicitly call "midi_device:close()" 
     * to release a device.
     */
    @:native("is_open")
    public var isOpen (default , null) : Bool;

    /**
     * The name of a device. This is the name you create a device with 
     * (via 'create_input_device' or 'create_output_device')
     */
    public var name (default , null) : String;

    /**
     * Close a running MIDI device. When no other client is using a device, 
     * Renoise will also shut off the device driver so that, for example, 
     * Windows OS other applications can use the device again. This is 
     * automatically done when scripts are closed or your device objects 
     * are garbage collected.
     */
    public function close() : Void;
}

extern class MidiOutputDevice
{
    /**
     * Returns true while the device is open (ready to send or receive
     * messages). Your device refs will never be auto-closed, "is_open" 
     * will only be false if you explicitly call "midi_device:close()" 
     * to release a device.
     */
    @:native("is_open")
    public var isOpen (default , null) : Bool;

    /**
     * The name of a device. This is the name you create a device with 
     * (via 'create_input_device' or 'create_output_device')
     */
    public var name (default , null) : String;

    /**
     * Close a running MIDI device. When no other client is using a device, 
     * Renoise will also shut off the device driver so that, for example, 
     * Windows OS other applications can use the device again. This is 
     * automatically done when scripts are closed or your device objects 
     * are garbage collected.
     */
    public function close() : Void;

    /**
     * Send raw 1-3 byte MIDI messages or sysex messages. The message is 
     * expected to be an array of numbers. It must not be empty and can 
     * only contain numbers >= 0 and <= 0xFF (bytes). Sysex messages must 
     * be sent in one block, must start with 0xF0, and end with 0xF7.
     * @param msg 
     */
    public function send(msg :lua.Table<Int, Int>) : Void;
}