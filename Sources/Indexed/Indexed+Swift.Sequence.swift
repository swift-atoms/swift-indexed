public import Cardinal
public import Tagged

extension Indexed: Swift.Sequence where Bound: Copyable {

    @inlinable
    public var underestimatedCount: Int { Int(clamping: count.underlying.rawValue) }
}
