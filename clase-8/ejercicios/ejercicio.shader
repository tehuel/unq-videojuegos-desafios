shader_type canvas_item;

uniform float progress : hint_range(0.1, 0.9) = 0.5;
uniform float width = 0.05;
uniform vec4 color_min : hint_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform vec4 color_max : hint_color = vec4(0.0, 1.0, 0.0, 1.0);

// Retorna la distancia al segmento
float sdSegment( in vec2 p, in vec2 a, in vec2 b )
{
    vec2 pa = p-a, ba = b-a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
    return length( pa - ba*h );
}

void fragment() {
	float grayFg = sdSegment(UV, vec2(0.1, 0.5), vec2(progress, 0.5));
	float lineFg = 1.0 - smoothstep(width, width + 0.01, grayFg);

	float grayBg = sdSegment(UV, vec2(0.1, 0.5), vec2(0.9, 0.5));
	vec3 lineBg = vec3(1.0 - smoothstep(width, width + 0.01, grayBg));
	vec3 healthColor = mix(color_min.rgb, color_max.rgb, progress);
	
	vec3 bar = mix(lineBg, healthColor.rgb, lineFg);

	COLOR = vec4(bar, 1.0);
}