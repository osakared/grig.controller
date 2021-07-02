package grig.controller;

interface SendView extends LaterallyMovable
{
    /**
     * Sets level of send
     * @param send 
     * @param level between 0.0 and 1.0
     */
    public function setLevel(send:Int, level:Float):Void;
}