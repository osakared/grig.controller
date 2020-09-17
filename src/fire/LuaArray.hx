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

    public inline function push(item :T) : Void
    {
        untyped _hx_table_push(this, item);
    }

    public inline function clear() : Void
    {
        untyped _hx_table_clear(this);
    }

    private inline function get_length() : Int
    {
        return untyped _hx_length(this);
    }
}