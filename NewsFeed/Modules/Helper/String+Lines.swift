

extension String {
    internal var firstLine: String {
        var current = startIndex
        while current < endIndex && self[current].isNewline == false {
            current = self.index(after: current)
        }
        return String(self[..<current])
    }
}

extension Character {
    internal var isNewline: Bool {
        return self == "\n" || self == "\r\n" || self == "\r"
    }
}
