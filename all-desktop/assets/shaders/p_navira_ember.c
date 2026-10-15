vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 tex = Texel(texture, texture_coords);
    number light = max(tex.r, max(tex.g, tex.b));
    number energy = clamp((max(tex.g, tex.b) - tex.r) * 3.0, 0.0, 1.0);
    number hot = clamp((light - 0.6) / 0.4, 0.0, 1.0);
    number glow = min(1.0, light * 1.16);
    vec3 ember = vec3(glow, glow * (0.18 + 0.46 * hot), glow * 0.07);
    return vec4(mix(min(vec3(1.0), tex.rgb * 1.06), ember, energy), tex.a) * color;
}
