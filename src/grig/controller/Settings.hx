package grig.controller;

interface Settings
{
    /**
     * Creates a bool setting
     * @param name 
     * @param category 
     * @param defaultValue 
     * @return BoolSetting
     */
    public function createBoolSetting(name:String, category:String, defaultValue:Bool):Setting<Bool>;

    /**
     * Creates a string setting
     * @param name 
     * @param category 
     * @param defaultValue 
     * @return StringSetting
     */
    public function createStringSetting(name:String, category:String, defaultValue:String):Setting<String>;

    /**
     * Creates an enum setting
     * @param name 
     * @param category 
     * @param type enum used
     * @param defaultValue 
     * @return EnumSetting<T>
     */
    public function createEnumSetting<T>(name:String, category:String, type:Enum<T>, defaultValue:T):Setting<T>;

    public function createIntSetting(name:String, category:String, minValue:Int, maxValue:Int, stepSize:Int,
        unit:String, defaultValue:Int):Setting<Int>;

    public function createFloatSetting(name:String, category:String, minValue:Float, maxValue:Float, stepSize:Float,
        unit:String, defaultValue:Float):Setting<Float>;
}