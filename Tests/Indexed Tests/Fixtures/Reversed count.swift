import Indexed

func mutate(_ view: inout Indexed<UInt>.Reversed) {
    view.count = .zero
}
