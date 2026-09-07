import Index_Test_Support
public import Ordinal
public import Tagged
public import Indexed

extension Indexed where Bound == UInt {

    public init(
        _ range: Swift.Range<UInt>,
        transform: @escaping @Sendable (UInt) -> UInt = { $0 }
    ) {

        self.init(
            __unchecked: (),
            start: Indexed<UInt>.Index(_unchecked: Ordinal::Ordinal(range.lowerBound)),
            end: Indexed<UInt>.Index(_unchecked: Ordinal::Ordinal(range.upperBound)),
            transform: { transform($0.position.rawValue) }
        )
    }

    #if !hasFeature(Embedded)

    @inlinable
    public init(
        count: Indexed<UInt>.Index.Count,
        transform: @escaping @Sendable (Int) -> Bound = { $0.magnitude }
    ) {
        self.init(count: count, transform: { $0.position.rawValue })
    }

    public init(
        start: Indexed<UInt>.Index,
        end: Indexed<UInt>.Index,
        transform: @escaping @Sendable (Int) -> Bound = { $0.magnitude }
    ) throws(Indexed<UInt>.Error) {
        try self.init(start: start, end: end, transform: { $0.position.rawValue })
    }
    #endif
}

public enum VectorTestError: Swift.Error {

    case countOverflow
}

extension Indexed where Bound == Int {

    public init(
        _ range: Swift.Range<Swift.Int>,
        transform: @escaping @Sendable (Swift.Int) -> Swift.Int = { $0 }
    ) throws(VectorTestError) {

        let distance = range.upperBound - range.lowerBound

        guard distance >= .zero, UInt(bitPattern: distance) <= UInt.max else {
            throw .countOverflow
        }
        let count = UInt(distance)

        let offset = range.lowerBound

        self.init(
            __unchecked: (),
            start: Indexed<Int>.Index(_unchecked: .zero),
            end: Indexed<Int>.Index(_unchecked: Ordinal::Ordinal(count)),
            transform: { transform(offset + Swift.Int(bitPattern: $0.position.rawValue)) }
        )
    }
}
