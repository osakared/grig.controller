package fire.util;

import renoise.song.TrackColor;

class Color
{
    public var r (get, set) : Int;
    public var g (get, set) : Int;
    public var b (get, set) : Int;

    public function new(r :Int, g :Int, b :Int) : Void
    {
        this.r = r;
        this.g = g;
        this.b = b;
    }

    public static function fromTrackColor(color :TrackColor) : Color
    {
        return new Color(Std.int(color.r/2), Std.int(color.g/2), Std.int(color.b/2));
    }

    private inline function get_r() : Int
    {
        return _r;
    }

    private inline function get_g() : Int
    {
        return _g;
    }

    private inline function get_b() : Int
    {
        return _b;
    }

    private function set_r(r :Int) : Int
    {
        _r = Math.clamp(r, 0, 0x7f);
        return _r;
    }

    private function set_g(g :Int) : Int
    {
        _g = Math.clamp(g, 0, 0x7f);
        return _g;
    }

    private function set_b(b :Int) : Int
    {
        _b = Math.clamp(b, 0, 0x7f);
        return _b;
    }

    private var _r = 0;
    private var _g = 0;
    private var _b = 0;
}