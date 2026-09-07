public import Cardinal
public import Ordinal
public import Tagged

extension Indexed {

    public struct Prefix: ~Copyable {
        @usableFromInline
        var base: Indexed<Bound>

        @inlinable
        package init(_ base: Indexed<Bound>) {
            self.base = base
        }
    }
}

extension Indexed.Prefix where Bound: Copyable {

    @inlinable
    public consuming func first(
        _ count: Indexed<Bound>.Index.Count
    ) -> Indexed<Bound> {
        let newEnd = base.start.advance.clamped(by: count, to: base.end)

        return Indexed<Bound>(
            __unchecked: (),
            start: base.start,
            end: newEnd,
            transform: base.transform
        )
    }

    @inlinable
    public consuming func `while`(_ predicate: (Bound) -> Bool) -> [Bound] {
        var result: [Bound] = []
        var i = base.start
        while i < base.end {
            let element = base.transform(i)
            if !predicate(element) { break }
            result.append(element)

            i += .one
        }
        return result
    }
}

extension Indexed where Bound: Copyable {

    @inlinable
    public var `prefix`: Prefix {
        Prefix(self)
    }
}
