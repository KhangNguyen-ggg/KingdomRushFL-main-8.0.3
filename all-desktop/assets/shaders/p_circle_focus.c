extern number norm_radius;          // radius normalized to virtual size (0–1)
extern vec2 norm_center;            // normalized center (0–1 in virtual space)
extern number inner_radius_factor;
extern number max_alpha;

// real screen size
extern vec2 screen_size;    // (X, Y)

// virtual screen size
extern vec2 virtual_size;   // (SX, SY)

float gen_alpha(float d, float max, float scale)
{
    float radius_virtual = norm_radius * screen_size.y / (scale * virtual_size.y);

    float md1 = radius_virtual;
    float md2 = md1 * inner_radius_factor;

    if (d < md2) {
        return 0.0;
    }
    if (d < md1) {
        float nd = (d - md2) / (md1 - md2);
        return nd * max;
    }

    return max;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    float scale = min(screen_size.x / virtual_size.x,
                      screen_size.y / virtual_size.y);

    vec2 offset = vec2(
        (screen_size.x - virtual_size.x * scale) * 0.5,
        (screen_size.y - virtual_size.y * scale) * 0.5
    );

    float aspect = virtual_size.x / virtual_size.y;

    vec2 virtual_pos = (screen_coords - offset) / scale;

    vec2 uv = virtual_pos / virtual_size;

    vec2 d_uv = uv;
    d_uv.x *= aspect;

    vec2 center = norm_center;
    center.x *= aspect;

    float d = distance(d_uv, center);

    vec4 c = Texel(texture, texture_coords) * color;

    float alpha = gen_alpha(d, min(max_alpha, c.a), scale);

    return vec4(c.rgb, alpha);
}
