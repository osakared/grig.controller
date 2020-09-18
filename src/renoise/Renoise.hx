package renoise;

import renoise.midi.Midi;
import renoise.song.Song;

@:native("renoise")
extern class Renoise
{
    extern public static function song() :Song;
    extern public static var midi :Midi;
}