import Cardinal
import Tagged

extension Indexed where Bound: Copyable {

    @inlinable
    public mutating func removeAll() {
        _clear()
    }
}

extension Indexed.Reversed where Bound: Copyable {

    @inlinable
    public mutating func removeAll() {
        _clear()
    }
}
