/*
 * Cool Crisp
 * 
 * Cooler tones with enhanced blues and clarity
 */

#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

const vec3 Balance = vec3(
    float(0.85),
    float(0.95),
    float(1.15)
);

const float Strength = float(0.20);

const vec3 VIB_coeffVibrance = Balance * -Strength;

void main() {
    vec4 pixColor = texture(tex, v_texcoord);
    vec3 color = pixColor.rgb;

    vec3 VIB_coefLuma = vec3(0.212656, 0.715158, 0.072186);
    float luma = dot(VIB_coefLuma, color);

    float max_color = max(color.r, max(color.g, color.b));
    float min_color = min(color.r, min(color.g, color.b));
    float color_saturation = max_color - min_color;

    vec3 p_col = (sign(VIB_coeffVibrance) * color_saturation - 1.0) * VIB_coeffVibrance + 1.0;

    vec3 adjustedColor = mix(vec3(luma), color, p_col);
    fragColor = vec4(adjustedColor, pixColor.a);
}
