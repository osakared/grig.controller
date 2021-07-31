package grig.controller;

/**
 * RGBA data
 */
abstract Color(Int) from Int to Int
{
    public static inline function fromRGB(r:Int, g:Int, b:Int, a:Int = 0):Color
    {
        return (r << 0x18) + (g << 0x10) + (b << 0x8) + a;
    }

    public inline function getRed():Int
    {
        return (this & 0xff000000) >> 0x18;
    }

    public inline function getGreen():Int
    {
        return (this & 0xff0000) >> 0x10;
    }

    public inline function getBlue():Int
    {
        return (this & 0xff00) >> 8;
    }

    public inline function getAlpha():Int
    {
        return this & 0xff;
    }
}