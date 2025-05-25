shader_type canvas_item;
uniform vec4 light : source_color;
uniform vec4 normal : source_color;
uniform vec4 shade : source_color;
uniform vec4 outline : source_color;

uniform vec4 swapLight : source_color;
uniform vec4 swapNormal : source_color;
uniform vec4 swapShade : source_color;
uniform vec4 swapOutline : source_color;

const float precision = 0.3;


void fragment(){
	vec4 current_color = texture(TEXTURE,UV);
		if(distance(current_color,light)<=precision){
			COLOR = swapLight;
		}
		else if(distance(current_color,normal)<=precision){
			COLOR = swapNormal;
		}
		
		else if(distance(current_color,shade)<=precision){
			COLOR = swapShade;
		}
		else if(distance(current_color,outline)<=precision){
			COLOR = swapOutline;
		}
		else{
			COLOR = current_color;
		}
		
		
}

