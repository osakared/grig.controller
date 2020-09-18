package renoise;

import renoise.song.Song;
import renoise.tool.Tool;

@:native("renoise")
extern class Renoise
{
    extern public static function song() :Song;
    extern public static function tool() :Tool;
}