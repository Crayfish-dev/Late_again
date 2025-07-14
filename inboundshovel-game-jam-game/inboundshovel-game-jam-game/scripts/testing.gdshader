shader_type canvas_item;
render_mode unshaded;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest, repeat_disable;

void fragment() {
    vec2 ps = SCREEN_PIXEL_SIZE;
    vec4 col = texture(screen_texture, SCREEN_UV);
    float alpha = col.a;

    float outline = 0.0;

    // 9x9 kernel (radius = 4)
    for (int x = -4; x <= 4; x++) {
        for (int y = -4; y <= 4; y++) {
            if (x == 0 && y == 0) continue;
            vec2 offset = vec2(float(x), float(y)) * ps;
            float neighbor_alpha = texture(screen_texture, SCREEN_UV + offset).a;
            outline += step(0.01, neighbor_alpha);
        }
    }

    if (alpha == 0.0 && outline > 0.0) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0); // solid black outline
    } else {
        COLOR = col;
    }
}
