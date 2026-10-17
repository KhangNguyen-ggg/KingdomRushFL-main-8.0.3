extern vec4 punch_boxes[13];
extern vec4 punch_masks[13];

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 sample_coords = texture_coords;
    number mask = 0.0;
    for (int i = 0; i < 13; i++) {
        vec4 box = punch_boxes[i];
        if (all(greaterThanEqual(texture_coords, box.xy)) && all(lessThanEqual(texture_coords, box.zw))) {
            vec4 region = punch_masks[i];
            // Reflect the clean lower-right energy quadrant to exclude Navira's arm and body.
            sample_coords = region.xy + abs(texture_coords - region.xy);
            if (any(greaterThan(sample_coords, box.zw))) return vec4(0.0);
            number radius = length((texture_coords - region.xy) / region.zw);
            mask = 1.0 - smoothstep(0.8, 1.0, radius);
            // Clear the lingering fingertip once the solid flash has passed.
            if (i >= 5) mask *= smoothstep(0.12, 0.2, radius);
            break;
        }
    }
    vec4 tex = Texel(texture, sample_coords);
    number light = max(tex.r, max(tex.g, tex.b));
    number energy = clamp((max(tex.g, tex.b) - tex.r) * 3.4, 0.0, 1.0);
    number core = smoothstep(0.78, 0.95, min(tex.r, min(tex.g, tex.b)));
    tex.a *= mask * max(energy, core) * smoothstep(0.4, 0.8, light);
    return tex * color;
}
