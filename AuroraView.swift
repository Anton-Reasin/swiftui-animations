import SwiftUI

// Aurora - flowing northern-lights ribbons. Pure SwiftUI, zero dependencies.
// Each ribbon is a wavy Path filled with a vertical gradient and a soft blur. iOS 15+.

struct AuroraView: View {
    @State private var start = Date()

    // hue, vertical position (0...1), wave amplitude, scroll speed
    private let ribbons: [(hue: Double, y: Double, amp: Double, speed: Double)] = [
        (0.45, 0.40, 36, 0.6),
        (0.52, 0.50, 50, -0.4),
        (0.78, 0.58, 30, 0.9)
    ]

    var body: some View {
        TimelineView(.animation) { tl in
            let t = tl.date.timeIntervalSince(start)
            Canvas { ctx, size in
                for r in ribbons {
                    let baseY = size.height * r.y
                    var path = Path()
                    path.move(to: CGPoint(x: 0, y: baseY))
                    for x in stride(from: 0, through: size.width, by: 6) {
                        let phase = x / size.width * .pi * 4 + t * r.speed
                        path.addLine(to: CGPoint(x: x, y: baseY + sin(phase) * r.amp))
                    }
                    path.addLine(to: CGPoint(x: size.width, y: size.height))
                    path.addLine(to: CGPoint(x: 0, y: size.height))
                    path.closeSubpath()

                    let color = Color(hue: r.hue, saturation: 0.8, brightness: 1)
                    let shading = GraphicsContext.Shading.linearGradient(
                        Gradient(colors: [color.opacity(0.55), .clear]),
                        startPoint: CGPoint(x: 0, y: baseY - r.amp),
                        endPoint: CGPoint(x: 0, y: baseY + 130))

                    ctx.drawLayer { layer in
                        layer.addFilter(.blur(radius: 8))
                        layer.fill(path, with: shading)
                    }
                }
            }
            .background(.black)
            .ignoresSafeArea()
        }
    }
}

#Preview { AuroraView() }
