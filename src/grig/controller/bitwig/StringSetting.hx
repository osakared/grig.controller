package grig.controller.bitwig;

import com.bitwig.extension.controller.api.SettableStringValue;
import grig.controller.ValueCallback;

class StringSetting implements grig.controller.Setting<String>
{
    private var value:SettableStringValue;
    private var initializedCallbacks = false;
    private var callbacks = new Array<ValueCallback<String>>();

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

    private function initializeCallbacks()
    {
        if (initializedCallbacks) return;
        initializedCallbacks = true;
        value.addValueObserver(new StringChangedCallback((value:String) -> {
            for (callback in callbacks) {
                callback(value);
            }
        }));
    }

    public function addValueCallback(callback:ValueCallback<String>):Void
    {
        callbacks.push(callback);
        initializeCallbacks();
    }
}