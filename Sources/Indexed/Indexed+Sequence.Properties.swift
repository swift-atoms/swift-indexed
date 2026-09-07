public import Cardinal
public import Ordinal
public import Tagged

extension Indexed where Bound: Copyable {

    @inlinable
    public func count(where predicate: (Bound) -> Bool) -> Index.Count {
        var count: Index.Count = .zero
        var iterator: Iterator = makeIterator()
        while let element = iterator.next() {
            if predicate(element) { count += .one }
        }
        return count
    }
}

extension Indexed.Reversed where Bound: Copyable {

    @inlinable
    public func count(where predicate: (Bound) -> Bool) -> Indexed<Bound>.Index.Count {
        var count: Indexed<Bound>.Index.Count = .zero
        var iterator: Iterator = makeIterator()
        while let element = iterator.next() {
            if predicate(element) { count += .one }
        }
        return count
    }
}
