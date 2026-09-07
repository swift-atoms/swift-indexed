public import Cardinal
public import Ordinal
public import Tagged

extension Indexed {

    public struct Drop: ~Copyable {
        @usableFromInline
        var base: Indexed<Bound>

        @inlinable
        package init(_ base: Indexed<Bound>) {
            self.base = base
        }
    }
}

extension Indexed.Drop where Bound: Copyable {

    @inlinable
    public consuming func first(
        _ count: Indexed<Bound>.Index.Count
    ) -> Indexed<Bound> {
        let newStart = base.start.advance.clamped(by: count, to: base.end)
        return Indexed<Bound>(
            __unchecked: (),
            start: newStart,
            end: base.end,
            transform: base.transform
        )
    }

    @inlinable
    public consuming func `while`(_ predicate: (Bound) -> Bool) -> [Bound] {
        var result: [Bound] = []
        var dropping = true
        var i = base.start
        while i < base.end {
            let element = base.transform(i)

            let next = i + .one
            if dropping && predicate(element) {
                i = next
                continue
            }
            dropping = false
            result.append(element)
            i = next
        }
        return result
    }
}

extension Indexed where Bound: Copyable {

    @inlinable
    public var drop: Drop {
        Drop(self)
    }
}
