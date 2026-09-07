#if os(macOS)
import Foundation
import Testing

@Suite struct `Public mutations cannot invalidate indexed bounds` {
    @Test(arguments: ["Count", "Start", "End", "Reversed count"])
    func `The compiler rejects direct assignment`(fixture: String) throws {
        var products = Bundle.module.bundleURL
        while !FileManager.default.fileExists(
            atPath: products.appendingPathComponent("Indexed.swiftmodule").path
        ) {
            let parent = products.deletingLastPathComponent()
            products = try #require(parent != products ? parent : nil)
        }
        let source = try #require(Bundle.module.resourceURL)
            .appendingPathComponent("Fixtures")
            .appendingPathComponent(fixture + ".swift")
        let process = Process()
        let errors = Pipe()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/xcrun")
        process.arguments = [
            "swiftc", "-typecheck", "-swift-version", "6",
            "-enable-experimental-feature", "Lifetimes",
            "-module-name", "Client", "-I", products.path, source.path,
        ]
        process.standardError = errors
        try process.run()
        let diagnostic = String(
            decoding: errors.fileHandleForReading.readDataToEndOfFile(), as: UTF8.self
        )
        process.waitUntilExit()
        #expect(process.terminationStatus != 0)
        #expect(diagnostic.contains("cannot assign to property"))
        #expect(!diagnostic.contains("no such module"))
    }
}
#endif
