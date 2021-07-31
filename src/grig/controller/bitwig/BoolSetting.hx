package grig.controller.bitwig;

import com.bitwig.extension.controller.api.SettableBooleanValue;
import grig.controller.ValueCallback;

class BoolSetting implements grig.controller.Setting<Bool>
{
    private var value:SettableBooleanValue;
    private var initializedCallbacks = false;
    private var callbacks = new Array<ValueCallback<Bool>>();

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

    private function initializeCallbacks()
    {
        if (initializedCallbacks) return;
        initializedCallbacks = true;
        value.addValueObserver(new BooleanChangedCallback((value:Bool) -> {
            for (callback in callbacks) {
                callback(value);
            }
        }));
    }

    public function addValueCallback(callback:ValueCallback<Bool>):Void
    {
        callbacks.push(callback);
        initializeCallbacks();
    }
}