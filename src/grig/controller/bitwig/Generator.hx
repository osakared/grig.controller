package grig.controller.bitwig;

import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;

class Generator
{
    private static inline var NAME = 'name';
    private static inline var AUTHOR = 'author';
    private static inline var VERSION = 'version';
    private static inline var HARDWARE_VENDOR = 'hardwareVendor';
    private static inline var HARDWARE_MODEL = 'hardwareModel';
    private static inline var NUM_MIDI_IN_PORTS = 'numMidiInPorts';
    private static inline var NUM_MIDI_OUT_PORTS = 'numMidiOutPorts';
    private static inline var UUID = 'uuid';

    #if macro

    private static function getTypeRef(name:String):Ref<ClassType>
    {
        var definitionType = Context.getType(name);

        switch (definitionType) {
            default:
                return Context.error("Expected a ClassType", Context.currentPos());
            case TInst(cr, _):
                return cr;
        }
    }

    private static function checkMetadata(name:String, value:Null<String>):Void
    {
        if (value == null) {
            Context.error('Missing metadata @$name', Context.currentPos());
        }
    }

    private static function makeReturnFunction(name:String, value:String):Field
    {
        var fn:Function = { args: [] };
        fn.expr = { pos: Context.currentPos(), expr: EReturn({pos: Context.currentPos(), expr: EConst(CString(value))}) };
        var type:FieldType = FFun(fn);
        return { pos: Context.currentPos(), name: name, kind: type, access: [APublic, AOverload] };
    }

    private static function makeIntReturnFunction(name:String, value:String):Field
    {
        var fn:Function = { args: [] };
        fn.expr = { pos: Context.currentPos(), expr: EReturn({pos: Context.currentPos(), expr: EConst(CInt(value))}) };
        var type:FieldType = FFun(fn);
        return { pos: Context.currentPos(), name: name, kind: type, access: [APublic, AOverload] };
    }

    public static function generate(fields:Array<Field>):Void
    {
        var classType = Context.getLocalClass().get();
        var classPath:haxe.macro.TypePath = {
            pack: classType.pack,
            name: classType.name
        }
        var classComplexType = TPath(classPath);

        // First, make the wrapper class that inherits from ControllerExtension
        var wrapperTypeName = classType.name + 'Extension';
        var wrapperClassPath:haxe.macro.TypePath = {
            pack: classType.pack,
            name: wrapperTypeName
        }
        var extensionClass = macro class $wrapperTypeName extends com.bitwig.extension.controller.ControllerExtension {
            private var controller:$classComplexType;
            overload public function init():Void {
                controller = new $classPath();
                var controllerHost:com.bitwig.extension.controller.api.ControllerHost = getHost();
                var host = new grig.controller.bitwig.Host(controllerHost);
                controller.startup(host);
            }            
            overload public function exit():Void {
                controller.shutdown();
            }
            overload public function flush():Void {
            }
        }
        Context.defineType(extensionClass);

        // Now get the metadata for populating the definition class
        var name:Null<String> = null;
        var author:Null<String> = null;
        var version:Null<String> = null;
        var hardwareVendor:String = '';
        var hardwareModel:String = '';
        var numMidiInPorts:String = '0';
        var numMidiOutPorts:String = '0';
        var uuid:Null<String> = null;
        var metadata = classType.meta.get();
        for (metadatum in metadata) {
            var val = grig.controller.Generator.extractMetadataValue(metadatum);
            if (val == null) continue;
            if (metadatum.name == NAME) {
                name = val;
            } else if (metadatum.name == AUTHOR) {
                author = val;
            } else if (metadatum.name == VERSION) {
                version = val;
            } else if (metadatum.name == HARDWARE_VENDOR) {
                hardwareVendor = val;
            } else if (metadatum.name == HARDWARE_MODEL) {
                hardwareModel = val;
            } else if (metadatum.name == NUM_MIDI_IN_PORTS) {
                numMidiInPorts = val;
            } else if (metadatum.name == NUM_MIDI_OUT_PORTS) {
                numMidiOutPorts = val;
            } else if (metadatum.name == UUID) {
                uuid = val;
            }
        }
        checkMetadata(NAME, name);
        checkMetadata(AUTHOR, author);
        checkMetadata(VERSION, version);
        checkMetadata(UUID, uuid);

        // Now make the definition class
        var definitionName = classType.name + 'ExtensionDefinition';
        var definitionClass = macro class $definitionName extends com.bitwig.extension.controller.ControllerExtensionDefinition {
            overload public function getRequiredAPIVersion():Int {
                return 13;
            }
            overload public function createInstance(host:com.bitwig.extension.controller.api.ControllerHost):com.bitwig.extension.controller.ControllerExtension {
                return new $wrapperClassPath(this, host);
            }
            overload public function listAutoDetectionMidiPortNames(list:com.bitwig.extension.controller.AutoDetectionMidiPortNamesList,
                platformType:com.bitwig.extension.api.PlatformType):Void {
            }
        }

        definitionClass.fields.push(makeReturnFunction('getName', name));
        definitionClass.fields.push(makeReturnFunction('getAuthor', author));
        definitionClass.fields.push(makeReturnFunction('getVersion', version));
        definitionClass.fields.push(makeReturnFunction('getHardwareVendor', hardwareVendor));
        definitionClass.fields.push(makeReturnFunction('getHardwareModel', hardwareModel));
        definitionClass.fields.push(makeIntReturnFunction('getNumMidiInPorts', numMidiInPorts));
        definitionClass.fields.push(makeIntReturnFunction('getNumMidiOutPorts', numMidiOutPorts));

        var getUuidFn:Function = { args: [] };
        var getUuidExpr = { pos: Context.currentPos(), expr: EConst(CString(uuid)) };
        getUuidFn.expr = macro {
            return java.util.UUID.fromString($getUuidExpr);
        }
        var getUuidType:FieldType = FFun(getUuidFn);
        var getUuidField = { pos: Context.currentPos(), name: 'getId', kind: getUuidType, access: [APublic, AOverload] };
        definitionClass.fields.push(getUuidField);

        Context.defineType(definitionClass);
    }

#end
}