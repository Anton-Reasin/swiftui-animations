import SwiftUI

// Bloom - a rainbow flower / mandala that slowly spins and breathes.
// Each petal is an ellipse radiating from the center. Pure SwiftUI, zero dependencies. iOS 15+.

struct BloomView: View {
    @State private var start = Date()
    private let petals = 12

    var body: some View {
        TimelineView(.animation) { tl in
            let t = tl.date.timeIntervalSince(start)
            Canvas { ctx, size in
                let center = CGPoint(x: size.width / 2, y: size.height * 0.46)
                let breathe = 0.82 + 0.18 * sin(t * 1.0)
                let spin = t * 0.35
                let len = size.width * 0.34 * breathe
                let w = size.width * 0.10

                for i in 0..<petals {
                    let angle = Double(i) / Double(petals) * 2 * .pi + spin
                    let hue = Double(i) / Double(petals)

                    var petal = Path()
                    petal.addEllipse(in: CGRect(x: -w / 2, y: 0, width: w, height: len))
                    let transform = CGAffineTransform.identity
                        .translatedBy(x: center.x, y: center.y)
                        .rotated(by: angle)

                    ctx.opacity = 0.5
                    ctx.fill(petal.applying(transform),
                             with: .color(Color(hue: hue, saturation: 0.7, brightness: 1)))
                }

                // glowing core
                ctx.fill(
                    Circle().path(in: CGRect(x: center.x - 7, y: center.y - 7, width: 14, height: 14)),
                    with: .color(.white))
            }
            .background(.black)
            .ignoresSafeArea()
        }
    }
}

#Preview { BloomView() }
