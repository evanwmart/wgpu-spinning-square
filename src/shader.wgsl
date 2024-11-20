// shader.wgsl

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) uv: vec2<f32>, // UV coordinates for gradient
};

@group(0) @binding(0)
var<uniform> transform: mat4x4<f32>; // Transformation matrix

@vertex
fn vs_main(@builtin(vertex_index) in_vertex_index: u32) -> VertexOutput {
    var positions = array<vec2<f32>, 4>(
        vec2<f32>(-0.5, -0.5), // Bottom-left
        vec2<f32>(0.5, -0.5),  // Bottom-right
        vec2<f32>(-0.5, 0.5),  // Top-left
        vec2<f32>(0.5, 0.5)    // Top-right
    );

    var indices = array<u32, 6>(
        0, 1, 2, // First triangle
        2, 1, 3  // Second triangle
    );

    var output: VertexOutput;
    let pos = vec4<f32>(positions[indices[in_vertex_index]], 0.0, 1.0);
    output.clip_position = transform * pos; // Apply transformation
    output.uv = positions[indices[in_vertex_index]] * 0.5 + vec2<f32>(0.5);
    return output;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let color1 = vec3<f32>(0.9, 0.98, 0.1);
    let color2 = vec3<f32>(0.98, 0.5, 0.9);
    let t = (in.uv.x + in.uv.y) * 0.5;
    let final_color = mix(color1, color2, t);
    return vec4<f32>(final_color, 1.0);
}
