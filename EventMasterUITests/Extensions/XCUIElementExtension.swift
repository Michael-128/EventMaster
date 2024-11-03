import XCTest

// This extension add a method that allows for scrolling until a given item is found
extension XCUIElement {
    func swipeUpTo(element: XCUIElement, maxAttempts: Int, velocity: XCUIGestureVelocity) {
        for _ in 0...maxAttempts {
            guard !element.exists else { return }
            self.swipeUp(velocity: velocity)
        }
    }
}
