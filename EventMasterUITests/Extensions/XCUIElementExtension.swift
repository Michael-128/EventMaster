import XCTest

extension XCUIElement {
    func swipeUpTo(element: XCUIElement, maxAttempts: Int, velocity: XCUIGestureVelocity) {
        for _ in 0...maxAttempts {
            guard !element.exists else { return }
            self.swipeUp(velocity: velocity)
        }
    }
}
