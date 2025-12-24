//
//  Vignette.metal
//  Shady
//
//  Created by Eli J on 12/23/25.
//

#include <metal_stdlib>
using namespace metal;

// MARK: Stitchables
[[ stitchable ]]
half4 vignette(
               float2 position,
               half4  color,
               float2 size,
               float2 center01,
               float  radius,
               float  feather
               ) {
    // Convert pixel position -> normalized UV
    float2 uv = position / size;
    
    // Aspect-correct distance for zero eccentricity
    float aspect = size.x / size.y;
    
    float2 d = uv - center01;
    d.x *= aspect;
    
    float r = length(d);
    
    // 0 inside, 1 outside; smooth transition over [radius, radius+feather]
    float a = smoothstep(radius, radius + feather, r);
    
    half3 rgb = color.rgb * half(1.0 - a);
    
    return half4(rgb, color.a);
}

// MARK: VSOut
struct VSOut {
    float4 position [[position]];
    float2 uv;
};

struct RadialParams {
    float2 center;
    float  radius;
    float  feather;
    float  aspect;
    float3 _pad;
};

// MARK: Vertices and Fragments
vertex VSOut fullscreenTriangle(uint vid [[vertex_id]]) {
    const float2 positions[3] = {
        float2(-1.0, -1.0),
        float2( 3.0, -1.0),
        float2(-1.0,  3.0)
    };
    
    const float2 uvs[3] = {
        float2(0.0, 0.0),
        float2(2.0, 0.0),
        float2(0.0, 2.0)
    };
    
    VSOut out;
    out.position = float4(positions[vid], 0.0, 1.0);
    out.uv = uvs[vid];
    return out;
}

fragment float4 radialTunnel(VSOut in [[stage_in]],
                             constant RadialParams& p [[buffer(0)]]) {
    float2 d = in.uv - p.center;
    
    d.x *= p.aspect;
    
    float r = length(d);
    
    float a = smoothstep(p.radius, p.radius + p.feather, r);
    
    return float4(0.0, 0.0, 0.0, a);
}
