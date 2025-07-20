shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;
uniform float frequency = 60;
uniform float amplitude = 0.005;
uniform float speed = 30.0;

void fragment() {
	vec2 new_uv = SCREEN_UV;
	new_uv.y += sin(new_uv.x * frequency + (TIME * speed)) * amplitude;

	vec3 new_colors = textureLod(screen_texture, new_uv, 0.0).rgb;
	COLOR.rgb = new_colors;
}
