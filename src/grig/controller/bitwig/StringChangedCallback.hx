package grig.controller.bitwig;

class StringChangedCallback implements com.bitwig.extension.callback.StringValueChangedCallback
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