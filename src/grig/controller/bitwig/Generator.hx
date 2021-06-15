package grig.controller.bitwig;

import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;

class Generator
{
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

    public static function generate(fields:Array<Field>):Void
    {
        var classType = Context.getLocalClass().get();
        var classPath:haxe.macro.TypePath = {
            pack: classType.pack,
            name: classType.name
        }
        var classComplexType = TPath(classPath);
        var wrapperTypeName = classType.name + 'Extension';
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
        // Add as parent type
        // classType.superClass = { t: superClass, params: [] };
    }

#end
}