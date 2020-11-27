package fire.util;

@:enum
abstract PadNote(Int) from Int to Int
{
    var C_1 = 16;
    var C_SHARP_1 = 1;
    var D_1 = 17;
    var D_SHARP_1 = 2;
    var E_1 = 18;
    var F_1 = 19;
    var F_SHARP_1 = 4;
    var G_1 = 20;
    var G_SHARP_1 = 5;
    var A_1 = 21;
    var A_SHARP_1 = 6;
    var B_1 = 22;

    var C_2 = 23;
    var C_SHARP_2 = 8;
    var D_2 = 24;
    var D_SHARP_2 = 9;
    var E_2 = 25;
    var F_2 = 26;
    var F_SHARP_2 = 11;
    var G_2 = 27;
    var G_SHARP_2 = 12;
    var A_2 = 28;
    var A_SHARP_2 = 13;
    var B_2 = 29;

    var C_3 = 30;

    public static function getNote(padNote :PadNote) : Int
    {
        return switch padNote {
            case C_1: 48;
            case C_SHARP_1: 49;
            case D_1: 50;
            case D_SHARP_1: 51;
            case E_1: 52;
            case F_1: 53;
            case F_SHARP_1: 54;
            case G_1: 55;
            case G_SHARP_1: 56;
            case A_1: 57;
            case A_SHARP_1: 58;
            case B_1: 59;
        
            case C_2: 60;
            case C_SHARP_2: 61;
            case D_2: 62;
            case D_SHARP_2: 63;
            case E_2: 64;
            case F_2: 65;
            case F_SHARP_2: 66;
            case G_2: 67;
            case G_SHARP_2: 68;
            case A_2: 69;
            case A_SHARP_2: 70;
            case B_2: 71;

            case C_3: 72;
            case _: -1;
        }
    }
}

class PadNoteUtil
{
    public static var keysBlack = [
        C_SHARP_1, D_SHARP_1, F_SHARP_1, G_SHARP_1, A_SHARP_1,
        C_SHARP_2, D_SHARP_2, F_SHARP_2, G_SHARP_2, A_SHARP_2
    ];

    public static var keysWhite = [
        C_1, D_1, E_1, F_1, G_1, A_1, B_1, 
        C_2, D_2, E_2, F_2, G_2, A_2, B_2, 
        C_3
    ];
}