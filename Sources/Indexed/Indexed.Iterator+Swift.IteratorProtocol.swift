public import Cardinal
public import Tagged

extension Indexed.Iterator: Swift.IteratorProtocol
where Bound: Copyable {}
