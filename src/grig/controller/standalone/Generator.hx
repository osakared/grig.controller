package grig.controller.standalone;

import haxe.macro.Expr;
import haxe.macro.Context;

class Generator
{
#if macro

    public static function generate(fields:Array<Field>):Void
    {
        var mainName = 'main';
        grig.controller.Generator.verifyAbsence(mainName, fields);

        var fn:Function = { args: [] };
        var classType = Context.getLocalClass().get();
        var classPath:haxe.macro.TypePath = {
            pack: classType.pack,
            name: classType.name
        }

        fn.expr = macro {
            var controller = new $classPath();
            var host = new grig.controller.standalone.Host();
            controller.startup(host);
            #if (sys && !nodejs)
            var stdout = Sys.stdout();
            var stdin = Sys.stdin();
            // Using Sys.getChar() unfortunately fucks up the output
            stdout.writeString('quit[enter] to quit\n');
            while (true) {
                var command = stdin.readLine();
                if (command.toLowerCase() == 'quit') {
                    break;
                }
            }
            #end
            controller.shutdown();
        }

        var type:FieldType = FFun(fn);
        var main:Field = { pos: Context.currentPos(), name: mainName, kind: type, access: [APublic, AStatic] };
        fields.push(main);
    }

#end
}