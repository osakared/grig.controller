package fire;

import lua.Lua;
import lua.Table;

abstract LuaArray<T>(Table<Int, T>) to Table<Int, T>
{
    public var length (get, never) : Int;

    inline public function new(array :Array<T>) : Void
    {
        this = Table.create(array);
    }

    @:arrayAccess
    public inline function get(key :Int) {
        return this[key];
    }

    @:arrayAccess
    public inline function arrayWrite(k :Int, v :T) : T 
    {
        this[k] = v;
        return v;
    }

    private inline function get_length() : Int
    {
        return untyped _hx_length(this);
    }
}