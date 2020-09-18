package renoise;

import renoise.song.Song;

@:native("renoise")
extern class Renoise
{
    extern public static function song() :Song;
}