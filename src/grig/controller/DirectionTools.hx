package grig.controller;

class DirectionTools
{
    static public function opposite(other:Direction):Direction
    {
        return switch other {
            case Up: Down;
            case Down: Up;
            case Left: Right;
            case Right: Left;
        }
    }
}