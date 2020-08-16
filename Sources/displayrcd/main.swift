import ArgumentParser
import Cocoa

struct Displayrcd: ParsableCommand {
    @Argument(help: "The path to a displayrc.")
    var displayrc = FileManager.default.homeDirectoryForCurrentUser
        .appendingPathComponent(".displayrc").path

    @Argument(help: "The shell to use.")
    var shell = "/bin/bash"

    func run() throws {
        reload()
        observeMainDisplayChanges()
        RunLoop.current.run()
    }

    func observeMainDisplayChanges() {
        var currentDisplayName: String?

        NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: NSApplication.shared,
            queue: .main
        ) { _ in
            guard currentDisplayName != NSScreen.main?.localizedName else { return }
            currentDisplayName = NSScreen.main?.localizedName
            self.reload()
        }
    }

    func reload() {
        let displayName = NSScreen.main?.localizedName ?? ""
        fputs("+ \(shell) -x \(displayrc) DISPLAY_NAME=\"\(displayName)\"\n", stderr)

        let process = Process()
        process.executableURL = URL(fileURLWithPath: shell)
        process.arguments = ["-x", displayrc]

        var environment = ProcessInfo.processInfo.environment
        environment["DISPLAY_NAME"] = displayName
        process.environment = environment

        process.launch()
        process.waitUntilExit()
    }
}

Displayrcd.main()
