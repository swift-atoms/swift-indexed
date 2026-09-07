public import Cardinal
public import Ordinal
public import Tagged

extension Indexed where Bound: ~Copyable {

    @inlinable
    package borrowing func _makeSequenceIterator() -> Iterator {
        Iterator(current: start, end: end, transform: transform)
    }

    @inlinable
    package mutating func _clear() {
        _start = end
        _count = .zero
    }
}

extension Indexed.Reversed where Bound: ~Copyable {

    @inlinable
    package borrowing func _makeSequenceIterator() -> Iterator {
        Iterator(start: start, end: end, transform: transform)
    }

    @inlinable
    package mutating func _clear() {
        start = end
        _count = .zero
    }
}
