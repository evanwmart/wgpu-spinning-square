// main.rs
use wgpu_spinning_square::run;

fn main() {
    pollster::block_on(run());
}