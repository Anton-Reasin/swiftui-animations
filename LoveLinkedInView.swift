import SwiftUI

// "I ❤️ LinkedIn" — pure SwiftUI, zero dependencies.
// Title grows from a point, then gently pulses. Floating heart reactions + fireworks.
// One file. iOS 15+ (TimelineView, Canvas, resolveSymbol). Just drop it in and Run.

// MARK: - Models

struct Spark { var x, y, vx, vy, hue: Double; let birth: Date }
struct Heart: Identifiable { let id = UUID(); let x, drift: Double; let birth: Date }

final class Scene {
    var sparks: [Spark] = []
    var hearts: [Heart] = []
    private var lastBurst = Date.distantPast
    private var lastHeart = Date.distantPast

    func update(_ now: Date, size: CGSize) {
        // fireworks
        sparks.removeAll { now.timeIntervalSince($0.birth) > 1.5 }
        if now.timeIntervalSince(lastBurst) > 0.9 {
            lastBurst = now
            let ox = Double.random(in: 0...size.width)
            let oy = Double.random(in: size.height * 0.12 ... size.height * 0.30)
            let hue = Double.random(in: 0...1)
            for _ in 0..<46 {
                let a = Double.random(in: 0 ..< 2 * .pi)
                let s = Double.random(in: 40...130)
                sparks.append(Spark(x: ox, y: oy, vx: cos(a) * s, vy: sin(a) * s, hue: hue, birth: now))
            }
        }
        // hearts
        hearts.removeAll { now.timeIntervalSince($0.birth) > 3.4 }
        if now.timeIntervalSince(lastHeart) > 0.16 {
            lastHeart = now
            hearts.append(Heart(x: .random(in: 0...size.width),
                                drift: .random(in: 0 ..< 2 * .pi), birth: now))
        }
    }
}

// MARK: - View

struct LoveLinkedInView: View {
    @State private var scene = Scene()
    @State private var start = Date()
    private let blue = Color(red: 0.04, green: 0.40, blue: 0.76)

    var body: some View {
        TimelineView(.animation) { tl in
            let t = tl.date.timeIntervalSince(start)
            let appear = min(1, t / 0.9)             // grow from a point
            let pulse = 1 + 0.05 * sin(t * 2.5)      // then a slow, gentle pulse

            ZStack {
                Canvas { ctx, size in
                    scene.update(tl.date, size: size)

                    // fireworks
                    for s in scene.sparks {
                        let age = tl.date.timeIntervalSince(s.birth)
                        let x = s.x + s.vx * age
                        let y = s.y + s.vy * age + 120 * age * age
                        ctx.opacity = max(0, 1 - age / 1.5) * 0.6
                        let r = CGRect(x: x, y: y, width: 3, height: 3)
                        ctx.fill(Path(ellipseIn: r),
                                 with: .color(Color(hue: s.hue, saturation: 0.9, brightness: 1)))
                    }

                    // floating heart reactions (SF Symbol drawn in the Canvas)
                    let heart = ctx.resolveSymbol(id: 0)!
                    for h in scene.hearts {
                        let age = tl.date.timeIntervalSince(h.birth)
                        let x = h.x + sin(age * 2 + h.drift) * 26
                        let y = size.height - age * 80
                        ctx.opacity = max(0, 1 - age / 3.4)
                        ctx.draw(heart, at: CGPoint(x: x, y: y))
                    }
                } symbols: {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(.pink)
                        .tag(0)
                }

                // title: I ❤️ LinkedIn
                HStack(spacing: 10) {
                    Text("I")
                    Image(systemName: "heart.fill").foregroundStyle(.red)
                    Text("LinkedIn")
                }
                .font(.system(size: 42, weight: .heavy))
                .foregroundStyle(blue)               // I and LinkedIn -> same brand blue
                .scaleEffect(appear * pulse)         // appears from a point, then pulses
            }
            .background(.black)
            .ignoresSafeArea()
        }
    }
}

#Preview { LoveLinkedInView() }
