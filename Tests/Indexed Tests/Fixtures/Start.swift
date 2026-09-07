import Indexed

func mutate(_ view: inout Indexed<UInt>) {
    view.start = view.end
}
