import SwiftUI

struct VerticalDismissModifier: ViewModifier {
    @Environment(\.dismiss) var dismiss
    @State private var offset: CGSize = .zero
    @Binding public var isDragging: Bool
    
    func body(content: Content) -> some View {
        content
            .offset(y: offset.height)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 50 {
                            isDragging = true
                            offset = gesture.translation
                        }
                    }
                    .onEnded { _ in
                        isDragging = false
                        if abs(offset.height) > 100 {
                            dismiss()
                        } else {
                            offset = .zero
                        }
                    }
            )
    }
}

