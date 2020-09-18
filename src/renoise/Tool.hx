package renoise;

class Tool
{
    public static inline function add_menu_entry(name :String) : Void
    {
        untyped renoise.tool().add_menu_entry(lua.Table.create({name: name}));
    }
}