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

No Swift Package, no setup. Each file is standalone and runs in the Xcode preview.

---

## Inspiration & resources

Brilliant open-source collections and tutorials worth exploring. All credit to their authors:

- [twostraws/Vortex](https://github.com/twostraws/Vortex) - high-performance particle effects for SwiftUI (Paul Hudson)
- [amosgyamfi/open-swiftui-animations](https://github.com/amosgyamfi/open-swiftui-animations) - pure SwiftUI animation inspirations (Amos Gyamfi)
- [naykutguven/CoolSwiftUIAnimations](https://github.com/naykutguven/CoolSwiftUIAnimations) - 27 ready-to-use components
- [ajagatobby/SwiftMotion](https://github.com/ajagatobby/SwiftMotion) - 58 animations + 31 Metal shaders
- [muhittincamdali/SwiftUI-Animation-Masterclass](https://github.com/muhittincamdali/SwiftUI-Animation-Masterclass) - 50+ animations, zero dependencies
- [Shubham0812/SwiftUI-Animations](https://github.com/Shubham0812/SwiftUI-Animations) - 20+ polished animations + Metal shaders
- [iAmVishal16/legendary-Animo](https://github.com/iAmVishal16/legendary-Animo) - micro-interactions in SwiftUI / UIKit / SpriteKit / Metal
- [Hacking with Swift - TimelineView + Canvas](https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-custom-animated-drawings-with-timelineview-and-canvas) (Paul Hudson)
- [The SwiftUI Lab - Advanced Animations: TimelineView](https://swiftui-lab.com/swiftui-animations-part4)

---

## License

[MIT](LICENSE). The animations in this repository are original work. The resources linked above belong to their respective authors.
