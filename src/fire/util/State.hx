package fire.util;

import fire.util.Signal1;
import fire.util.Signal1ReadOnly;

class State
{
    public var input :Signal1<InputState>;

    public function new() : Void
    {
        this.input = new Signal1(STEP);
    }
}

abstract StateReadOnly(State) from State
{
    public var input (get, never) : Signal1ReadOnly<InputState>;

    private inline function get_input() {
        return this.input;
    }
}

enum InputState
{
    STEP;
    NOTE;
    DRUM;
    PERFORM;
}