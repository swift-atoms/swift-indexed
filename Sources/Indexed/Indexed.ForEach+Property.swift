public import Property

extension Property {

    @inlinable
    public func callAsFunction<Bound: ~Copyable, E: Swift.Error>(
        _ body: (borrowing Bound) throws(E) -> Void
    ) throws(E) where Tag == Indexed<Bound>.ForEach, Base == Indexed<Bound> {
        var copy = base
        try copy._borrowingForEach(body)
    }

    @inlinable
    public func borrowing<Bound: ~Copyable, E: Swift.Error>(
        _ body: (borrowing Bound) throws(E) -> Void
    ) throws(E) where Tag == Indexed<Bound>.ForEach, Base == Indexed<Bound> {
        var copy = base
        try copy._borrowingForEach(body)
    }

    @inlinable
    public func callAsFunction<Bound: ~Copyable, E: Swift.Error>(
        _ body: (borrowing Bound) throws(E) -> Void
    ) throws(E) where Tag == Indexed<Bound>.ForEach, Base == Indexed<Bound>.Reversed {
        var copy = base
        try copy._borrowingForEach(body)
    }

    @inlinable
    public func borrowing<Bound: ~Copyable, E: Swift.Error>(
        _ body: (borrowing Bound) throws(E) -> Void
    ) throws(E) where Tag == Indexed<Bound>.ForEach, Base == Indexed<Bound>.Reversed {
        var copy = base
        try copy._borrowingForEach(body)
    }
}
