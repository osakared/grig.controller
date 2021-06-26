package grig.controller.bitwig;

/**
 * Corresponds to Bitwig's playback states
 */
enum abstract PlaybackState(Int) from Int to Int
{
    var Stopped = 0;
    var Playing = 1;
    var Recording = 2;
}
