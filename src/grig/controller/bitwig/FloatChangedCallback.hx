package grig.controller.bitwig;

class FloatChangedCallback implements com.bitwig.extension.callback.DoubleValueChangedCallback
{
    private var callback:grig.controller.ValueCallback<Float>;

    public function new(callback:grig.controller.ValueCallback<Float>)
    {
        this.callback = callback;
    }

    public function valueChanged(value:Float):Void
    {
        callback(value);
    }
}