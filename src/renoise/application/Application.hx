package renoise.application;


extern class Application
{
    @:native("show_message")
    public function showMessage(message :String) : Void;

    @:native("show_error")
    public function showError(message :String) : Void;

    @:native("show_warning")
    public function showWarning(message :String) : Void;

    @:native("show_status")
    public function showStatus(message :String) : Void;
}