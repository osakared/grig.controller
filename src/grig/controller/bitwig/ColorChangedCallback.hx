package grig.controller.bitwig;

typedef ColorCallback = (r:Float, g:Float, b:Float)->Void;

class ColorChangedCallback implements com.bitwig.extension.callback.ColorValueChangedCallback
{
    private var callback:ColorCallback;

    public function new(callback:ColorCallback)
    {
        this.callback = callback;
    }

    public function valueChanged(r:Float, g:Float, b:Float):Void
    {
        callback(r, g, b);
    }
}