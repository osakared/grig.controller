package fire;


abstract Color(Int) from Int to Int 
{
    public var red(get, set) : Int;
    public var blue(get, set) : Int;
    public var green(get, set) : Int;

    public inline function new(argb : Int) : Voidargb
    {
        this = argb;
    }

    function get_red() : Int
    {
        var v = (this >> 16) & 0xff;
        var f = v/255;
        return Math.floor(f * 127);
    }

    inline function set_red(r : Int) : Int
    {
        return r;
    }

    function get_blue() : Int
    {
        return 0;
    }

    inline function set_blue(b : Int) : Int
    {
        return b;
    }

    function get_green() : Int
    {
        return 0;
    }

    inline function set_green(g : Int) : Int 
    {
        return g;
    }
}

@:enum
abstract RedYellow(Int) from Int to Int
{
    var OFF = 0x00;
    var DULL_RED = 0x01;
    var DULL_YELLOW = 0x02;
    var HIGH_RED = 0x03;
    var HIGH_YELLOW = 0x04;
}

@:enum
abstract Yellow(Int) from Int to Int
{
    var OFF = 0x00;
    var DULL_YELLOW = 0x01;
    var HIGH_YELLOW = 0x02;
}

@:enum
abstract Red(Int) from Int to Int
{
    var OFF = 0x00;
    var DULL_RED = 0x01;
    var HIGH_RED = 0x02;
}

@:enum
abstract Green(Int) from Int to Int
{
    var OFF = 0x00;
    var DULL_GREEN = 0x01;
    var HIGH_GREEN = 0x02;
}

@:enum
abstract YellowGreen(Int) from Int to Int
{
    var OFF = 0x00;
    var DULL_GREEN = 0x01;
    var DULL_YELLOW = 0x02;
    var HIGH_GREEN = 0x03;
    var HIGH_YELLOW = 0x04;
}