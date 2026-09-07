public import Ordinal
public import Tagged

extension Indexed.Reversed {

    public struct Drop: ~Copyable {
        @usableFromInline
        var base: Indexed<Bound>.Reversed

        @inlinable
        package init(_ base: Indexed<Bound>.Reversed) {
            self.base = base
        }
    }
}

extension Indexed.Reversed.Drop where Bound: Copyable {

    @inlinable
    public consuming func first(_ count: Indexed<Bound>.Index.Count) -> Indexed<Bound>.Reversed {
        let newEnd = base.end.retreat.clamped(by: count, to: base.start)
        return Indexed<Bound>.Reversed(
            __unchecked: (),
            start: base.start,
            end: newEnd,
            transform: base.transform
        )
    }

    @inlinable
    public consuming func `while`(_ predicate: (Bound) -> Bool) -> [Bound] {
        var result: [Bound] = []
        var dropping = true
        guard !base.isEmpty else { return result }

        let initial: Indexed<Bound>.Index
        do throws(Ordinal::Ordinal.Error) {
            initial = try base.end.predecessor.exact()
        } catch {
            return result
        }
        var i = initial
        while i >= base.start {
            let element = base.transform(i)
            if dropping && predicate(element) {
                if i == base.start { break }

                do throws(Ordinal::Ordinal.Error) {
                    i = try i.predecessor.exact()
                } catch {
                    break
                }
                continue
            }
            dropping = false
            result.append(element)
            if i == base.start { break }

            do throws(Ordinal::Ordinal.Error) {
                i = try i.predecessor.exact()
            } catch {
                break
            }
        }
        return result
    }
}

extension Indexed.Reversed where Bound: Copyable {

    @inlinable
    public var drop: Drop {
        Drop(self)
    }
}
