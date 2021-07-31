package grig.controller.bitwig;

import grig.controller.StringCallback;

class EnumChangedCallback<T> implements com.bitwig.extension.callback.EnumValueChangedCallback
{
    private var callback:StringCallback;

    public function new(callback:StringCallback)
    {
        this.callback = callback;
    }

    public function valueChanged(value:String):Void
    {
        callback(value);
    }
}