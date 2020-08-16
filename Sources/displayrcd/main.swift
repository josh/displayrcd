import Cocoa

let shURL = URL(fileURLWithPath: "/bin/bash")
let displayrcURL = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent(".displayrc")

func reload() {
    let displayName = NSScreen.main?.localizedName ?? ""
    fputs("+ \(shURL.path) -x \(displayrcURL.path) DISPLAY_NAME=\"\(displayName)\"\n", stderr)

    let process = Process()
    process.executableURL = shURL
    process.arguments = ["-x", displayrcURL.path]

    var environment = ProcessInfo.processInfo.environment
    environment["DISPLAY_NAME"] = displayName
    process.environment = environment

    process.launch()
    process.waitUntilExit()
}

func observeMainDisplayChanges() {
    var currentDisplayName: String?

    NotificationCenter.default.addObserver(
        forName: NSApplication.didChangeScreenParametersNotification,
        object: NSApplication.shared,
        queue: .main
    ) { _ in
        guard currentDisplayName != NSScreen.main?.localizedName else {
            return
        }
        currentDisplayName = NSScreen.main?.localizedName

        reload()
    }

    reload()
    RunLoop.current.run()
}

observeMainDisplayChanges()
