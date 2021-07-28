package grig.controller;

import tink.core.Outcome;

interface DeviceView extends LaterallyMovable
{
    /**
     * Creates a parameter view
     * @param width number of parameters
     * @return Promise<ParameterView>
     */
    public function createParameterView(width:Int):Outcome<ParameterView, tink.core.Error>;
}