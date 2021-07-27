package grig.controller.bitwig;

import com.bitwig.extension.controller.api.SettableEnumValue;

using haxe.EnumTools;

class EnumSetting<T> implements grig.controller.EnumSetting<T>
{
    private var value:SettableEnumValue;
    private var type:Enum<T>;

    public function new(value:SettableEnumValue, type:Enum<T>)
    {
        this.value = value;
        this.type = type;
    }

    public function get():T
    {
        var valString = value.get();
        return type.createByName(valString);
    }

    public function set(val:T):Void
    {
        value.set(Std.string(val));
    }
}