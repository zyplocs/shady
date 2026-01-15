//
//  Spectrogram.metal
//  Shady
//
//  Created by Eli J on 1/1/26.
//

#include <metal_stdlib>
using namespace metal;

// Payload
struct VSOut {
    // the [[position]] attribute denotes the field as the clip-space  for rasterization
    float4 position [[position]];
    float2 uv;
};

// Fullscreen triangle
vertex VSOut spectrogramVS(uint vid [[vertex_id]]) {
    // Point positions in clip-space: x,y ∈ [-1,1]
    constexpr float2 pos[3] = {
        float2(-1.0, -1.0),
        float2( 3.0, -1.0),
        float2(-1.0,  3.0)
    };
    
    // Point positions in uv [0,1]
    constexpr float2 uv[3] = {
        float2(0.0, 1.0),
        float2(2.0, 1.0),
        float2(0.0, -1.0)
    };
    
    VSOut out;
    out.position = float4(pos[vid], 0.0, 1.0);
    out.uv = uv[vid];
    return out;
}

struct FragParams {
    uint width;
    uint head;
    uint height;
};

fragment float4 spectrogramFS(
                              VSOut in [[stage_in]],
                              texture2d<half, access::sample> spectro [[texture(0)]],
                              constant FragParams& params [[buffer(0)]]
                              ) {
    constexpr sampler samplr(coord::normalized, address::clamp_to_edge, filter::linear);
    
    float2 uv = fract(in.uv);
    
    float fx = uv.x * float(params.width);
    uint x = (uint(fx) + params.head) % params.width;
    
    float u = (float(x) + 0.5) / float(params.width);
    float v = uv.y;
    
    half intensity = spectro.sample(samplr, float2(u, v)).r;
    float xOut = float(intensity);
    
    return float4(xOut, xOut, xOut, 1.0);
}
