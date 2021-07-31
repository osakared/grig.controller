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

    /**
     * Creates an int setting with specified constraints
     * @param name 
     * @param category 
     * @param minValue 
     * @param maxValue 
     * @param stepSize 
     * @param unit 
     * @param defaultValue 
     * @return Setting<Int>
     */
    public function createIntSetting(name:String, category:String, minValue:Int, maxValue:Int, stepSize:Int,
        unit:String, defaultValue:Int):Setting<Int>;

    /**
     * Creates a float setting with specified constraints
     * @param name 
     * @param category 
     * @param minValue 
     * @param maxValue 
     * @param stepSize 
     * @param unit 
     * @param defaultValue 
     * @return Setting<Float>
     */
    public function createFloatSetting(name:String, category:String, minValue:Float, maxValue:Float, stepSize:Float,
        unit:String, defaultValue:Float):Setting<Float>;

    /**
     * Creates a color setting
     * @param name 
     * @param category 
     * @param defaultValue 
     * @return Setting<Color>
     */
    public function createColorSetting(name:String, category:String, defaultValue:Color):Setting<Color>;
}