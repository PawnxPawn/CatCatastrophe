shader_type canvas_item;

uniform sampler2D exist_screen_texture: hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec3 new_color = texture(exist_screen_texture,SCREEN_UV, 0.0).rgb;
	new_color = vec3(1) - new_color;
	COLOR.rgb = new_color;
}
