package grig.controller.bitwig;

import com.bitwig.extension.controller.api.SettableColorValue;
import grig.controller.Color;
import grig.controller.ValueCallback;

class ColorSetting implements grig.controller.Setting<Color>
{
    private var value:SettableColorValue;
    private var initializedCallbacks = false;
    private var callbacks = new Array<ValueCallback<Color>>();

    public function new(value:SettableColorValue)
    {
        this.value = value;
    }

    public function get():Color
    {
        var color = value.get();
        return Color.fromRGB(color.getRed255(), color.getGreen255(), color.getBlue255(), color.getAlpha255());
    }

    public function set(val:Color):Void
    {
        value.set(ColorHelper.toBitwigColor(val));
    }

    private function initializeCallbacks()
    {
        if (initializedCallbacks) return;
        initializedCallbacks = true;
        value.addValueObserver(new ColorChangedCallback((r:Float, g:Float, b:Float) -> {
            for (callback in callbacks) {
                callback(Color.fromRGB(Std.int(r), Std.int(g), Std.int(b)));
            }
        }));
    }

    public function addValueCallback(callback:ValueCallback<Color>):Void
    {
        callbacks.push(callback);
        initializeCallbacks();
    }
}