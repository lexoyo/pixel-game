import Types;
import flash.events.Event;

class Floor extends flash.display.Sprite {

    public function new() {
        super();
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
    }
    public function getZ(_x:Float):Float{
        return 200 + Math.cos(_x / 50) * 50 + Math.cos(_x / 100) * 50;
    }
    public function getTanZ(_x:Float):Float{
        return Math.sin(_x / 50);
        // tan(a+b) = (tan(a)+ tan(b))/(1+tan(a)*tan(b))
        var tanA: Float = Math.sin(_x / 50);
        var tanB: Float = Math.sin(_x / 100);
        return (tanA+tanB)/(1.0+(tanA*tanB));
    }
    private function addedToStage(e:Event){
        trace("I'm the floor !");
        for (_x in 0...this.stage.stageWidth){
            var _y = this.stage.stageHeight;
            graphics.lineStyle(1, 0x000099, Math.abs(Math.cos(x)));
            graphics.moveTo(_x, this.stage.stageHeight);
            graphics.lineTo(_x, this.stage.stageHeight - _y);
        }
        for (_x in 0...this.stage.stageWidth){
            var _y = getZ(_x);
            graphics.lineStyle(1, 0x339933, Math.abs(Math.cos(x)));
            graphics.moveTo(_x, this.stage.stageHeight);
            graphics.lineTo(_x, this.stage.stageHeight - _y);
        }
    }
    public function check(massPositionX: Float, massPositionZ: Float, collideFloor: Float -> Float -> Float -> Float -> Void):Void{
        if (massPositionZ < getZ(massPositionX)){
            var tan = getTanZ(massPositionX);
            collideFloor(tan, 1-Math.abs(tan), massPositionX + tan, getZ(massPositionX));
        }
        if (massPositionX > this.stage.stageWidth){
            var tan = -1;
            collideFloor(tan, 1-Math.abs(tan), this.stage.stageWidth, massPositionZ);
        }
        if (massPositionX < 0){
            var tan = 1;
            collideFloor(tan, 1-Math.abs(tan), 0, massPositionZ);
        }
    }
}
