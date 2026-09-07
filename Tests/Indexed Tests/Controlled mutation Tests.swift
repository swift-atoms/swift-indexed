import Indexed
import Testing

@Suite struct `Controlled mutations preserve indexed bounds and counts` {
    private struct Token: ~Copyable {
        let value: UInt
    }

    @Test func `Draining noncopyable elements preserves empty bounds`() {
        var view = Indexed<Token>(count: 3, transform: { Token(value: $0.position.rawValue) })
        var values: [UInt] = []
        view.drain { token in values.append(token.value) }
        #expect(values == [0, 1, 2])
        #expect(view.start == view.end)
        #expect(view.count == .zero)
        #expect(view.isEmpty)
        var iterator = view.makeIterator()
        if let token = iterator.next() {
            Issue.record("Unexpected generated token: \(token.value)")
        }
        view.drain { token in values.append(token.value) }
        #expect(values == [0, 1, 2])
    }

    @Test func `Draining reversed noncopyable elements empties every traversal`() {
        var view = Indexed<Token>(count: 3, transform: { Token(value: $0.position.rawValue) })
            .reversed()
        var values: [UInt] = []
        view.drain { token in values.append(token.value) }
        #expect(values == [2, 1, 0])
        #expect(view.count == .zero)
        #expect(view.isEmpty)
        var iterator = view.makeIterator()
        if let token = iterator.next() {
            Issue.record("Unexpected generated token: \(token.value)")
        }
        view.drain { token in values.append(token.value) }
        #expect(values == [2, 1, 0])
    }

    @Test func `Slicing and clearing preserve the full cardinal range`() {
        typealias View = Indexed<UInt>
        let full = View(count: .init(UInt.max), transform: { $0.position.rawValue })
        var tail = full.drop.first(.init(UInt.max - 3))
        #expect(tail.count == 3)
        #expect(Array(tail) == [UInt.max - 3, UInt.max - 2, UInt.max - 1])
        var reversed = tail.reversed().prefix.first(2)
        #expect(Array(reversed) == [UInt.max - 1, UInt.max - 2])
        reversed.removeAll()
        #expect(reversed.count == .zero)
        #expect(reversed.isEmpty)
        #expect(Array(reversed).isEmpty)
        tail.removeAll()
        #expect(tail.start == full.end)
        #expect(tail.end == full.end)
        #expect(tail.count == .zero)
        #expect(Array(tail).isEmpty)
        #expect(full.count == .init(UInt.max))
    }
}
