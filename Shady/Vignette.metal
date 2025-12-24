//
//  Vignette.metal
//  Shady
//
//  Created by Eli J on 12/23/25.
//

#include <metal_stdlib>
using namespace metal;

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
                             constant RadialParams& p [[buffer(0)]])
{
    float2 d = in.uv - p.center;
    
    d.x *= p.aspect;
    
    float r = length(d);
    
    float a = smoothstep(p.radius, p.radius + p.feather, r);
    
    return float4(0.0, 0.0, 0.0, a);
}
