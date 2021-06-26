package grig.controller.bitwig;

class IndexedBooleanChangedCallback implements com.bitwig.extension.callback.IndexedBooleanValueChangedCallback
{
    private var callback:IndexedBoolCallback;

    public function new(callback:IndexedBoolCallback)
    {
        this.callback = callback;
    }

    public function valueChanged(idx:Int, value:Bool):Void
    {
        callback(idx, value);
    }
}