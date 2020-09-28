

extension Array {
    func takeElements(elementCount: Int) -> Array {
        if (elementCount > count) {
            return self
        }
        return Array(self[0..<elementCount])
    }
}
