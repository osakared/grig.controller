package grig.controller.bitwig;

import com.bitwig.extension.controller.api.SettableStringValue;

class StringSetting implements grig.controller.StringSetting
{
    private var value:SettableStringValue;

    public function new(value:SettableStringValue)
    {
        this.value = value;
    }

    public function get():String
    {
        return value.get();
    }

    public function set(val:String):Void
    {
        value.set(val);
    }
}