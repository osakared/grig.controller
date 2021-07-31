package grig.controller.bitwig;

import com.bitwig.extension.controller.api.SettableRangedValue;
import grig.controller.ValueCallback;

class IntSetting implements grig.controller.Setting<Int>
{
    private var value:SettableRangedValue;
    private var initializedCallbacks = false;
    private var callbacks = new Array<ValueCallback<Int>>();

    public function new(value:SettableRangedValue)
    {
        this.value = value;
    }

    public function get():Int
    {
        return Std.int(value.get());
    }

    public function set(val:Int):Void
    {
        value.set(val);
    }

    private function initializeCallbacks()
    {
        if (initializedCallbacks) return;
        initializedCallbacks = true;
        value.addRawValueObserver(new FloatChangedCallback((value:Float) -> {
            for (callback in callbacks) {
                callback(Std.int(value));
            }
        }));
    }

    public function addValueCallback(callback:ValueCallback<Int>):Void
    {
        callbacks.push(callback);
        initializeCallbacks();
    }
}