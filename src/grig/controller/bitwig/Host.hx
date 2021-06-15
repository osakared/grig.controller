package grig.controller.bitwig;

import com.bitwig.extension.controller.api.ControllerHost;

class Host implements grig.controller.Host
{
    private var controllerHost:ControllerHost;

    public function new(controllerHost_:ControllerHost)
    {
        controllerHost = controllerHost_;
    }

    public function showMessage(message:String):Void
    {
        controllerHost.showPopupNotification(message);
    }

    public function logMessage(message:String):Void
    {
        controllerHost.println(message);
    }
}