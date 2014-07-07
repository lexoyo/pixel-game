import Mass;
import Car;
import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.events.KeyboardEvent;

class Main {
    public static inline var POC: Float = .03;
    public static var GRAVITY_X: Float = 0;
    public static var GRAVITY_Z: Float = -.2;
    public static inline var AMMORT_X: Float = .9;
    public static inline var AMMORT_Z: Float = .8;
    public static var masses: Array<Mass>;
    public static var floor: Floor;
    public static var isDown: Bool = false;

    static function main() {
        floor = new Floor();
        flash.Lib.current.addChild(floor);
        masses = new Array();
        createMass('the hero', 1, 20, Math.round(Math.random()*1000));
        createMass('the other ', Math.round(Math.random()+.5), Math.round(Math.random()*2000), Math.round(Math.random()*1000));
//        for (idx in 0...20){
//            createMass('the other '+idx, Math.round(Math.random()+.5), Math.round(Math.random()*2000), Math.round(Math.random()*1000));
//       }
        var mass = new Car(
            'car',
            1000,
            {x: 10, z: 10}
        );
        masses.push(mass);
        flash.Lib.current.addChild(mass);
        mass = new Car(
            'car 2',
            1000,
            {x: 500, z: 10}
        );
        masses.push(mass);
        flash.Lib.current.addChild(mass);
        (new haxe.Timer(10)).run = gameLoop;
        flash.Lib.current.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        flash.Lib.current.addEventListener(TouchEvent.TOUCH_TAP, onTouchDown);
        flash.Lib.current.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        flash.Lib.current.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
    }
    static function createMass(name: String, weight: Int, x: Int, z: Int):Void{
        var mass = new Mass(
            name,
            weight,
            {x: x, z: z}
        );
        masses.push(mass);
        flash.Lib.current.addChild(mass);
    }
    static function gameLoop():Void{
        for (idx1 in 0...masses.length){
            var mass1 = masses[idx1];
            mass1.gameLoop(floor);
            floor.check(mass1.position.x, mass1.position.z, mass1.collideFloor);
            for (idx2 in (idx1+1)...masses.length){
                var mass2 = masses[idx2];
                mass2.check(mass1.position.x, mass1.position.z, mass1.collideMass);
            }
        }
    }
    static function onKeyDown(e: KeyboardEvent):Void{
        trace('onKeyDown');
        masses[0].poc(0, 0);
    }
    static function onTouchDown(e: TouchEvent):Void{
        isDown = true;
        masses[0].poc(e.stageX, e.stageY);
    }
    static function onMouseDown(e: MouseEvent):Void{
        isDown = true;
        masses[0].poc(e.stageX, e.stageY);
    }
    static function onMouseUp(e: MouseEvent):Void{
        isDown = false;
        masses[0].poc(e.stageX, e.stageY);
    }
}
