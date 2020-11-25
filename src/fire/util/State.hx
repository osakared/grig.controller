package fire.util;

class State
{
    public var input :InputState;

    public function new() : Void
    {
        this.input = STEP;
    }
}

abstract StateReadOnly(State) from State
{
    public var input (get, never) : InputState;

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