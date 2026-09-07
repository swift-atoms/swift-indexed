public import Cardinal
public import Tagged

extension Indexed.Iterator: IteratorProtocol
where Bound: Copyable {}

extension Indexed.Reversed.Iterator: IteratorProtocol
where Bound: Copyable {}

extension Indexed where Bound: Copyable {

    @inlinable
    public mutating func removeAll() {
        _clear()
    }
}

extension Indexed.Reversed where Bound: Copyable {

    @inlinable
    public mutating func removeAll() {
        _clear()
    }
}

extension Indexed: Swift.Sequence where Bound: Copyable {

    @inlinable
    public var underestimatedCount: Int { Int(clamping: count.underlying.rawValue) }
}

extension Indexed.Reversed: Swift.Sequence where Bound: Copyable {

    @inlinable
    public var underestimatedCount: Int { Int(clamping: count.underlying.rawValue) }
}
