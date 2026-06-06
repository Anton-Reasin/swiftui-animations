# SwiftUI Animations

Fun, eye-catching SwiftUI animations - each one is a **single file, zero dependencies**. Drop it into your project and hit Run. iOS 15+.

Built for delight (and for sharing). New ones added regularly.

---

## Animations

### I love LinkedIn
![I love LinkedIn](previews/love-linkedin.gif)

A title that grows from a point and gently pulses, floating heart reactions, and fireworks - all in one `Canvas`. Uses `TimelineView`, `Canvas`, and SF Symbols.

➡️ [LoveLinkedInView.swift](LoveLinkedInView.swift)

### Fireworks
![Fireworks](previews/fireworks.gif)

A full particle system in ~40 lines: `TimelineView(.animation)` redraws every frame, `Canvas` draws each spark, gravity is one line. Bursts fill the whole screen using the canvas size.

➡️ [FireworksView.swift](FireworksView.swift)

---

## How to use

1. Copy the `.swift` file into your Xcode project.
2. Use the view, e.g. `FireworksView()`.
3. Tweak the constants - particle count, gravity, colors, speed.

Each file is standalone and runs in the Xcode preview.

---

## Credits

Inspired by the SwiftUI animation community - especially Paul Hudson and Amos Gyamfi, whose open work got me experimenting with `Canvas` and `TimelineView`. All code here is my own.

## License

[MIT](LICENSE).
