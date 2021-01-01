//
//  PomodoroCookieApp.swift
//  PomodoroCookie
//
//  Created by 성준영 on 2020/12/31.
//

import Cocoa
import SwiftUI

var appDelegate = AppDelegate()

@main
enum AppSelector {
    static func main() {
        if #available(OSX 11.0, *) {
            UpToBigSurApp.main()
        } else {
            OldApp.main()
        }
    }
}

@available(OSX 11.0, *)
struct UpToBigSurApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    struct Empty: View {
        @State var show = false

        var body: some View {
            if !show {
                EmptyView()
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            Empty()
        }
    }
}

enum OldApp {
    static func main() {
        NSApplication.shared.setActivationPolicy(.regular)

        let nib = NSNib(nibNamed: NSNib.Name("Pomodoro Cookie"), bundle: Bundle.main)
        nib?.instantiate(withOwner: NSApplication.shared, topLevelObjects: nil)

        NSApp.delegate = appDelegate
        NSApp.activate(ignoringOtherApps: true)
        NSApp.run()
    }
}
