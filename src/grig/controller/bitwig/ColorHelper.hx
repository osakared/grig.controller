package grig.controller.bitwig;

import grig.controller.Color;

class ColorHelper
{
    public static function toBitwigColor(color:Color)
    {
        return com.bitwig.extension.api.Color.fromRGBA255(color.getRed(), color.getGreen(), color.getBlue(), color.getAlpha());
    }
}