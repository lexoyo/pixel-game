import Types;
import flash.events.Event;

class Mass extends flash.display.Sprite {

    public var displayName: String;
    public var weight: Int;
    public var position: Position;
    public var speed: Position;
    public var accel: Position;
    public var isOnTheFloor: Bool;
    private var toggle: Bool;
    private var lastCollision: Null<Float>;

    public function new(displayName: String, weight: Int, position: Position) {
        super();
        this.displayName = displayName;
        this.weight = weight;
        this.position = position;
        this.speed = {x: 0, z: 0};
        this.accel = {x: 0, z: 0};
        this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
    }
    private function addedToStage(e:Event){
        redraw();
        x = Math.round(position.x);
        y = stage.stageHeight - Math.round(position.z);
    }
    private function redraw(){
        graphics.clear();
        graphics.beginFill(toggle ? 0xFF0000 : 0xFFFFFF);
        graphics.drawCircle(-2, -4, 4);
    }
    public function gameLoop(floor: Floor):Void{
        accel.z = Main.GRAVITY_Z * weight;
        speed.z += accel.z;
        speed.x += accel.x;
        position.z += speed.z;
        position.x += speed.x;
        x = Math.round(position.x);
        y = stage.stageHeight - Math.round(position.z);
        isOnTheFloor = false;
    }
    public function collideFloor(vectorX: Float, vectorZ: Float, floorX: Float, floorZ: Float):Void{
        var speedNorm = Math.sqrt((speed.x * speed.x) + (speed.z * speed.z));
        speed.x = speedNorm * vectorX * Main.AMMORT_X;
        speed.z = speedNorm * vectorZ * Main.AMMORT_Z;
        position.x = floorX;
        position.z = floorZ;
        isOnTheFloor = true;
    }
    public function poc(mouseX: Float, mouseY: Float):Void{
        if (!isOnTheFloor) return;

        var distX = mouseX - position.x;
        var distZ = (stage.stageHeight - mouseY) - position.z;
        //var strength = Math.sqrt((distX * distX) + (distZ * distZ));
        //var direction = Math.atan2(distZ, distX);
        //speed.x += Main.POC * Math.cos(direction) * strength;
        //speed.z += Main.POC * Math.sin(direction) * strength;
        speed.x += Main.POC * distX;
        speed.z += Main.POC * distZ;
        position.z += speed.z;
        position.x += speed.x;


        return;
//        if (Math.abs(speed.z)<0.01) return;
        var direction = Math.atan2(speed.z, speed.x);
direction = 0.1;
        speed.x += Main.POC * Math.cos(direction);
        speed.z += Main.POC * Math.sin(direction);
    }
    public function check(massPositionX: Float, massPositionZ: Float, otherMassCollide: Float -> Float -> Float -> Float -> Void):Void{
        if (massPositionX < position.x + 2 && massPositionX > position.x - 2
            && massPositionZ < position.z + 2 && massPositionZ > position.z - 2
            ){
            var vectorX = position.x - massPositionX + speed.x;
            var vectorZ = position.z - massPositionZ + speed.z;
            otherMassCollide(vectorX, vectorZ, position.x, position.z);
            collideMass(vectorX, vectorZ, position.x, position.z);
        }
    }
    public function collideMass(vectorX: Float, vectorZ: Float, floorX: Float, floorZ: Float):Void{
        speed.x -= vectorX;
        speed.z -= vectorZ;
        if(lastCollision == null || Date.now().getTime() > lastCollision + 2000) {
            lastCollision = Date.now().getTime();
            toggle = !toggle;
            redraw();
        }
    }
}
