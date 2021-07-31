package grig.controller.bitwig;

import com.bitwig.extension.controller.api.SettableRangedValue;
import grig.controller.ValueCallback;

class FloatSetting implements grig.controller.Setting<Float>
{
    private var value:SettableRangedValue;
    private var initializedCallbacks = false;
    private var callbacks = new Array<ValueCallback<Float>>();

    public function new(value:SettableRangedValue)
    {
        this.value = value;
    }

    public function get():Float
    {
        return value.get();
    }

    public function set(val:Float):Void
    {
        value.set(val);
    }

    private function initializeCallbacks()
    {
        if (initializedCallbacks) return;
        initializedCallbacks = true;
        value.addRawValueObserver(new FloatChangedCallback((value:Float) -> {
            for (callback in callbacks) {
                callback(value);
            }
        }));
    }

    public function addValueCallback(callback:ValueCallback<Float>):Void
    {
        callbacks.push(callback);
        initializeCallbacks();
    }
}