package grig.controller.bitwig;

import grig.controller.ValueCallback;

class EnumChangedCallback<T> implements com.bitwig.extension.callback.EnumValueChangedCallback
{
    private var callback:ValueCallback<String>;

    public function new(callback:ValueCallback<String>)
    {
        this.callback = callback;
    }

    public function valueChanged(value:String):Void
    {
        callback(value);
    }
}