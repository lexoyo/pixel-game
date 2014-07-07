import Types;
import flash.events.Event;

class Car extends Mass {
    public function new(displayName: String, weight: Int, position: Position) {
        super(displayName, weight, position);
    }
    override private function redraw(){
        graphics.clear();
        graphics.beginFill(toggle ? 0xFFFFFF : 0xFF0000);
        graphics.drawRect(-2, -2, 4, 4);
        graphics.endFill();
    }
    override private function addedToStage(e:Event){
        redraw();
        x = Math.round(position.x);
        y = stage.stageHeight - Math.round(position.z);
        speed.x = 1;
    }
    override public function gameLoop(floor:Floor):Void{
        speed.z += accel.z;
        speed.x += accel.x;
        position.x += speed.x;
        position.z = floor.getZ(position.x);
        x = Math.round(position.x);
        y = stage.stageHeight - Math.round(position.z);
        isOnTheFloor = false;
    }
    override public function collideFloor(vectorX: Float, vectorZ: Float, floorX: Float, floorZ: Float):Void{
        if (position.x < 0 || position.x > stage.stageWidth){
            speed.x = -speed.x;
        }
    }
}
