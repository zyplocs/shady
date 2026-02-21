//
//  HelloTriangle.metal
//  Shady
//
//  Created by Eli J on 2/20/26.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float2 position [[attribute(0)]];
    float2 uv [[attribute(1)]];
};

struct VertexOut {
    float4 position [[position]];
    float2 uv;
};

vertex VertexOut v_main(VertexIn in [[stage_in]]) {
    VertexOut out;
    out.position = float4(in.position, 0.0, 1.0);
    out.uv = in.uv;
    return out;
}

fragment float4 f_main(VertexOut in [[stage_in]]) {
    // simple UV gradient
    return float4(in.uv.x, in.uv.y, 0.2, 1.0);
}

