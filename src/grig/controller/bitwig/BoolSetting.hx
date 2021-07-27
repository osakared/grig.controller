package grig.controller.bitwig;

import com.bitwig.extension.controller.api.SettableBooleanValue;

class BoolSetting implements grig.controller.BoolSetting
{
    private var value:SettableBooleanValue;

    public function new(value:SettableBooleanValue)
    {
        this.value = value;
    }

    public function get():Bool
    {
        return value.get();
    }

    public function set(val:Bool):Void
    {
        value.set(val);
    }
}