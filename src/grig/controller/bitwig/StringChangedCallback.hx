package grig.controller.bitwig;

class StringChangedCallback implements com.bitwig.extension.callback.StringValueChangedCallback
{
    private var callback:grig.controller.StringCallback;

    public function new(callback:grig.controller.StringCallback)
    {
        this.callback = callback;
    }

    public function valueChanged(value:String):Void
    {
        callback(value);
    }
}