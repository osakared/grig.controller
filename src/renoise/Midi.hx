package renoise;

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
    extern public function send(msg :lua.Table<Int,Int>) : Void;
}