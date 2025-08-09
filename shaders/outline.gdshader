shader_type spatial;
render_mode unshaded, cull_front;

uniform vec4 outline_color : source_color = vec4(1.0);
uniform float outline_width = 0.025;
uniform bool is_active = true;

void vertex() {
    VERTEX *= 1.0 + outline_width;
}

void fragment() {
	if (!is_active) {
		discard;
	}

    ALBEDO = outline_color.rgb;
    ALPHA = outline_color.a;
}
