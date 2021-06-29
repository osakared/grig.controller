package grig.controller.bitwig;

class IndexedBooleanChangedCallback implements com.bitwig.extension.callback.IndexedBooleanValueChangedCallback
{
    private var callback:grig.controller.IndexedBoolCallback;

    public function new(callback:grig.controller.IndexedBoolCallback)
    {
        this.callback = callback;
    }

    public function valueChanged(idx:Int, value:Bool):Void
    {
        callback(idx, value);
    }
}