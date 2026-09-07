public import Index
public import Ordinal
public import Tagged

@inlinable
public func ..< <Tag: ~Copyable & ~Escapable>(
    lhs: Index<Tag>,
    rhs: Index<Tag>.Count
) -> Indexed<Index<Tag>> {
    let start: Indexed<Index<Tag>>.Index = lhs.retag()
    let end: Indexed<Index<Tag>>.Index = rhs.map { Ordinal::Ordinal($0) }.retag()

    return Indexed(
        __unchecked: (),
        start: start,
        end: end,
        transform: { $0.retag() }
    )
}
