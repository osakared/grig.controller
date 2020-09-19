package renoise;

import renoise.application.Application;
import renoise.song.Song;
import renoise.tool.Tool;

@:native("renoise")
extern class Renoise
{
    extern public static function app() :Application;
    extern public static function song() :Song;
    extern public static function tool() :Tool; //completed
    extern public static var API_VERSION : Int;
    extern public static var RENOISE_VERSION : String;
}