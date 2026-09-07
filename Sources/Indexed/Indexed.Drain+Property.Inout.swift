public import Property

extension Property.Inout where Base: ~Copyable {

    @inlinable
    public mutating func callAsFunction<Bound: ~Copyable>(
        _ body: (consuming Bound) -> Void
    ) where Tag == Indexed<Bound>.Drain, Base == Indexed<Bound> {
        base.value._consumingDrain(body)
    }

    @inlinable
    public mutating func callAsFunction<Bound: ~Copyable>(
        _ body: (consuming Bound) -> Void
    ) where Tag == Indexed<Bound>.Drain, Base == Indexed<Bound>.Reversed {
        base.value._consumingDrain(body)
    }
}
