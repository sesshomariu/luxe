
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import luxe.Color;
import phoenix.Shader;

class Main extends luxe.Game {

	var sprite1 : Sprite;
	var sprite2 : Sprite;
	var sprite3 : Sprite;

	var shader1 : Shader;
	var shader2 : Shader;
	var shader3 : Shader;

    public function ready() {

    	var tex = Luxe.loadTexture('assets/luxe.png');
    	var tex2 = Luxe.loadTexture('assets/level.png');
    	var tex3 = Luxe.loadTexture('assets/distort.png');
    		tex2.filter = phoenix.Texture.FilterType.nearest;    	

    	var sprite1 = new Sprite({
    		texture : tex,
    		pos : new Vector(150,320)
    	});

    	var sprite2 = new Sprite({
    		texture : tex,
    		pos : new Vector(430,320)
    	});

    	var sprite3 = new Sprite({
    		texture : tex2,
    		pos : new Vector(480,320)
    	});

    	sprite1.scale = new Vector(0.75,0.75);
    	sprite2.scale = new Vector(0.75,0.75);
    	sprite3.scale = new Vector(4,4);	

    		//we do this separately so we can set the uniforms
    	shader1 = Luxe.loadShader('assets/gray_tilt_shift.glsl');
    	shader2 = Luxe.loadShader('assets/huechange.glsl');
    	shader3 = Luxe.loadShader('assets/distort.glsl');

    	sprite3.shader = shader1;
    	sprite2.shader = shader2;
    	sprite1.shader = shader3;

    		//move to second slot
    	tex3.slot = 1;
    	shader3.set_uniform_texture('distortmap', tex3);


    } //ready

    public function onmousemove( e:MouseEvent ) {

    	var percent = e.pos.x / Luxe.screen.w;
    	var hue = (Math.PI*2) * percent;

    	shader2.set_uniform_float('in_hue', hue);

    }

    public function onkeyup( e:KeyEvent ) {

        if(e.key == KeyValue.escape) {
            Luxe.shutdown();
        }
        
    } //onkeyup

    public function update(dt:Float) {

    	shader2.setUniformFloat('in_hue', 1.57);

    } //update

} //Main