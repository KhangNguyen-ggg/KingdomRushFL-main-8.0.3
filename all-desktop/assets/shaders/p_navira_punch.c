extern vec4 punch_boxes[13];
extern vec4 punch_masks[13];

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 tex = Texel(texture, texture_coords);
    number mask = 0.0;
    for (int i = 0; i < 13; i++) {
        vec4 box = punch_boxes[i];
        if (all(greaterThanEqual(texture_coords, box.xy)) && all(lessThanEqual(texture_coords, box.zw))) {
            vec4 region = punch_masks[i];
            mask = 1.0 - smoothstep(0.8, 1.0, length((texture_coords - region.xy) / region.zw));
            break;
        }
    }
    number light = max(tex.r, max(tex.g, tex.b));
    number energy = clamp((max(tex.g, tex.b) - tex.r) * 3.0, 0.0, 1.0);
    number core = smoothstep(0.78, 0.95, min(tex.r, min(tex.g, tex.b)));
    number hot = clamp((light - 0.6) / 0.4, 0.0, 1.0);
    number glow = min(1.0, light * 1.16);
    vec3 ember = vec3(glow, glow * (0.18 + 0.46 * hot), glow * 0.07);
    tex.a *= mask * max(energy, core) * smoothstep(0.4, 0.8, light);
    return vec4(mix(min(vec3(1.0), tex.rgb * 1.06), ember, energy), tex.a) * color;
}
