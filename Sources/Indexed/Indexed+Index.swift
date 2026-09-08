public import Index
public import Ordinal
public import Tagged

extension Indexed {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(
        _ range: Swift.Range<Index::Index<Tag>>
    ) where Bound == Index::Index<Tag> {
        let start: Indexed<Bound>.Index = range.lowerBound.retag()
        let end: Indexed<Bound>.Index = range.upperBound.retag()

        self.init(
            __unchecked: (),
            start: start,
            end: end,
            transform: { $0.retag() }
        )
    }
}

extension Indexed {

    @inlinable
    public subscript<Tag: ~Copyable & ~Escapable>(offset: Index::Index<Tag>.Offset)
        -> Index::Index<Tag>
    where Bound == Index::Index<Tag> {
        let vectorOffset: Indexed<Bound>.Index.Offset = offset.retag()
        precondition(
            vectorOffset >= .zero && vectorOffset.difference.magnitude.value < count.underlying,
            "Offset out of bounds"
        )

        let position: Indexed<Bound>.Index
        do throws(Ordinal::Ordinal.Error) {
            position = try start + vectorOffset
        } catch {
            fatalError("invariant violation: \(error)")
        }
        return transform(position)
    }
}

extension Indexed.Reversed {

    @inlinable
    public subscript<Tag: ~Copyable & ~Escapable>(offset: Index::Index<Tag>.Offset)
        -> Index::Index<Tag>
    where Bound == Index::Index<Tag> {
        let vectorOffset: Indexed<Bound>.Index.Offset = offset.retag()
        precondition(
            vectorOffset >= .zero && vectorOffset.difference.magnitude.value < count.underlying,
            "Offset out of bounds"
        )

        let position: Indexed<Bound>.Index
        do throws(Ordinal::Ordinal.Error) {
            let lastIndex = try end.predecessor.exact()
            position = try lastIndex - vectorOffset
        } catch {
            fatalError("invariant violation: \(error)")
        }
        return transform(position)
    }
}
