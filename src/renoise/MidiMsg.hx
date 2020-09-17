package renoise;

abstract MidiMsg(Array<Int>) 
{
    public inline function isOn() : Int
    {
        return this[1];
    }

    public inline function note() : Int
    {
        return this[2];
    }

    public inline function velocity() : Int
    {
        return this[3];
    }
}