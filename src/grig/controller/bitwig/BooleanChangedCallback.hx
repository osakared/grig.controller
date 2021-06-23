package grig.controller.bitwig;

class BooleanChangedCallback implements com.bitwig.extension.callback.BooleanValueChangedCallback
{
    private var callback:grig.controller.BoolCallback;

    public function new(callback:grig.controller.BoolCallback)
    {
        this.callback = callback;
    }

    public function valueChanged(value:Bool):Void
    {
        callback(value);
    }
}