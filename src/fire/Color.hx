package fire;


abstract Color(Int) from Int to Int 
{
    public static inline function fromARGBi(a : Int, r : Int, g : Int, b : Int) : Color 
    {
        return new Color((a << 24) | (r << 16) | (g << 8) | b);
    }

    public var ai(get, set) : Int;
    public var ri(get, set) : Int;
    public var gi(get, set) : Int;
    public var bi(get, set) : Int;

    public inline function new(argb : Int) : Voidargb
    {
        this = argb;
    }

    inline function get_ai() : Int
    {
        return (this >> 24) & 0xff;
    }

    inline function set_ai(ai : Int) : Int
    {   
        this = fromARGBi(ai, ri, gi, bi); 
        return ai;
    }

    function get_ri() : Int
    {
        var v = (this >> 16) & 0xff;
        var f = v/255;
        return Math.floor(f * 127);
    }

    inline function set_ri(ri : Int) : Int
    {
        this = fromARGBi(ai, ri, gi, bi); 
        return ri;
    }

    function get_gi() : Int
    {
        var v = (this >> 8) & 0xff;
        var f = v/255;
        return Math.floor(f * 127);
    }

    inline function set_gi(gi : Int) : Int
    {
        this = fromARGBi(ai, ri, gi, bi); 
        return gi;
    }

    function get_bi() : Int
    {
        var v =  this & 0xff;
        var f = v/255;
        return Math.floor(f * 127);
    }

    inline function set_bi(bi : Int) : Int 
    {
        this = fromARGBi(ai, ri, gi, bi); 
        return bi;
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