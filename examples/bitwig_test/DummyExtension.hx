package;

import com.bitwig.extension.controller.api.ControllerHost;
import com.bitwig.extension.controller.api.Transport;
import com.bitwig.extension.controller.ControllerExtension;

class DummyExtension extends ControllerExtension
{
    public function new(definition:DummyExtensionDefinition, host:ControllerHost)
    {
        super(definition, host);
    }

    overload public function init():Void
    {
        var host:ControllerHost = getHost();

        // TODO: Perform your driver initialization here.
        // For now just show a popup notification for verification that it is running.
        host.showPopupNotification("bitwigtest Initialized");
    }

    overload public function exit():Void
    {
        // TODO: Perform any cleanup once the driver exits
        // For now just show a popup notification for verification that it is no longer running.
        getHost().showPopupNotification("bitwigtest Exited");
    }

    overload public function flush():Void
    {
        // TODO Send any updates you need here.
    }
}