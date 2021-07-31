package grig.controller.bitwig;

import com.bitwig.extension.controller.api.SettableEnumValue;

using haxe.EnumTools;

class EnumSetting<T> implements grig.controller.Setting<T>
{
    private var value:SettableEnumValue;
    private var type:Enum<T>;
    private var callbacks = new Array<(value:T)->Void>();
    private var initializedCallbacks = false;

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

    private function initializeCallbacks():Void
    {
        if (initializedCallbacks) return;
        initializedCallbacks = true;
        value.addValueObserver(new EnumChangedCallback((value:String) -> {
            var enumVal = type.createByName(value);
            for (callback in callbacks) {
                callback(enumVal);
            }
        }));
    }

    public function addValueCallback(callback:(value:T)->Void):Void
    {
        callbacks.push(callback);
        initializeCallbacks();
    }
}