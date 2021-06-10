package;

import com.bitwig.extension.controller.ControllerExtension;
import java.util.UUID;

import com.bitwig.extension.api.PlatformType;
import com.bitwig.extension.controller.AutoDetectionMidiPortNamesList;
import com.bitwig.extension.controller.ControllerExtensionDefinition;
import com.bitwig.extension.controller.api.ControllerHost;

class DummyExtensionDefinition extends ControllerExtensionDefinition
{
    public function new()
    {
        super();
    }

    overload public function getName():String
    {
        return "dummy";
    }

    overload public function getAuthor():String
    {
        return "pinkboi";
    }

    overload public function getVersion():String
    {
        return "0.1";
    }

    overload public function getId():UUID
    {
        return UUID.fromString("c3f15e69-d773-4873-9e9f-b3f9a27f2878");
    }

    overload public function getHardwareVendor():String
    {
        return "oas";
    }

    overload public function getHardwareModel():String
    {
        return "bitwigtest";
    }

    overload public function getRequiredAPIVersion():Int
    {
        return 13;
    }

    overload public function getNumMidiInPorts():Int
    {
        return 0;
    }

    overload public function getNumMidiOutPorts():Int
    {
        return 0;
    }

    overload public function listAutoDetectionMidiPortNames(list:AutoDetectionMidiPortNamesList, platformType:PlatformType):Void
    {
    }

    overload public function createInstance(host:ControllerHost):ControllerExtension
    {
        return new DummyExtension(this, host);
    }
}