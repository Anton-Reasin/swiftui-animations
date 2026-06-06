import SwiftUI

// Fireflies - soft glowing dots drifting in lazy loops and breathing in brightness.
// Pure SwiftUI, zero dependencies. iOS 15+.

struct Firefly { let x, y, ax, ay, fx, fy, phase: Double }

struct FirefliesView: View {
    @State private var start = Date()
    private let flies: [Firefly] = (0..<28).map { _ in
        Firefly(x: .random(in: 0...1), y: .random(in: 0...1),
                ax: .random(in: 20...60), ay: .random(in: 20...60),
                fx: .random(in: 0.3...0.8), fy: .random(in: 0.3...0.8),
                phase: .random(in: 0 ..< 2 * .pi))
    }

    var body: some View {
        TimelineView(.animation) { tl in
            let t = tl.date.timeIntervalSince(start)
            Canvas { ctx, size in
                for fly in flies {
                    let x = fly.x * size.width + sin(t * fly.fx + fly.phase) * fly.ax
                    let y = fly.y * size.height + cos(t * fly.fy + fly.phase) * fly.ay
                    let glow = 0.5 + 0.5 * sin(t * 2 + fly.phase)
                    let r = 3 + glow * 3
                    ctx.opacity = 0.25 + 0.75 * glow
                    ctx.fill(
                        Circle().path(in: CGRect(x: x - r / 2, y: y - r / 2, width: r, height: r)),
                        with: .color(Color(hue: 0.15, saturation: 0.75, brightness: 1)))
                }
            }
            .background(.black)
            .ignoresSafeArea()
        }
    }
}

#Preview { FirefliesView() }
