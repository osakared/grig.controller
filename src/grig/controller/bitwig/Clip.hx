package grig.controller.bitwig;

import grig.controller.ClipState;

/**
 * To keep track of clip's state and workaround limitations of bitwig's api
 */
class Clip
{
    private var _state:ClipState = Stopped;
    public var state(get, set):ClipState;
    public var hasContent:Bool = false;

    private function get_state():ClipState
    {
        return if (hasContent) _state;
        else Empty;
    }

    private function set_state(newState:ClipState):ClipState
    {
        _state = newState;
        return get_state();
    }

    public function new()
    {
    }
}