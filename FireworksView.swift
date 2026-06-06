import SwiftUI

// Fireworks - a pure SwiftUI particle system in ~40 lines. Zero dependencies.
// TimelineView(.animation) redraws every frame; Canvas draws each spark. iOS 15+.
// Drop it into a project and hit Run.

struct Spark { var x, y, vx, vy, hue: Double; let birth: Date }

final class Sky {
    var sparks: [Spark] = []
    private var last = Date.distantPast

    func update(_ now: Date, size: CGSize) {
        sparks.removeAll { now.timeIntervalSince($0.birth) > 1.6 }
        guard now.timeIntervalSince(last) > 0.45 else { return }
        last = now
        let ox = Double.random(in: 0...size.width)
        let oy = Double.random(in: size.height * 0.15 ... size.height * 0.55)
        let hue = Double.random(in: 0...1)
        for _ in 0..<90 {
            let a = Double.random(in: 0 ..< 2 * .pi)
            let s = Double.random(in: 60 ... size.width * 0.55)
            sparks.append(Spark(x: ox, y: oy, vx: cos(a) * s,
                                vy: sin(a) * s, hue: hue, birth: now))
        }
    }
}

struct FireworksView: View {
    @State private var sky = Sky()

    var body: some View {
        TimelineView(.animation) { tl in
            Canvas { ctx, size in
                sky.update(tl.date, size: size)
                for s in sky.sparks {
                    let age = tl.date.timeIntervalSince(s.birth)
                    let x = s.x + s.vx * age
                    let y = s.y + s.vy * age + 130 * age * age
                    ctx.opacity = max(0, 1 - age / 1.6)
                    let r = CGRect(x: x, y: y, width: 4, height: 4)
                    ctx.fill(Path(ellipseIn: r),
                             with: .color(Color(hue: s.hue, saturation: 0.9, brightness: 1)))
                }
            }
        }
        .background(.black)
        .ignoresSafeArea()
    }
}

#Preview { FireworksView() }
