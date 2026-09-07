import Indexed

func mutate(_ view: inout Indexed<UInt>) {
    view.end = view.start
}
