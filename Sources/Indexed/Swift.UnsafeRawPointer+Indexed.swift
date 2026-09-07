public import Index
public import Ordinal

extension Swift.UnsafeRawPointer {

    @inlinable
    public func advanced<Tag: ~Copyable & ~Escapable>(
        by index: Index::Index<Tag>
    ) -> Self {
        unsafe self.advanced(by: Int(bitPattern: index))
    }
}
