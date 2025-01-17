//
// Created by 성준영 on 2021/01/18.
//

import Foundation
import SwiftUI

enum Opacity {
    case _15
    case _20
    case _100

    func String() -> String {
        switch self {
        case ._15:
            return "15"
        case ._20:
            return "20"
        case ._100:
            return "100"
        }
    }
}

enum Status {
    case stop
    case pause
    case play
    case `break`

    func MainColor() -> Color {
        switch self {
        case .stop:
            return Color("Black60")
        case .pause:
            return Color("Black60")
        case .play:
            return Color("Red100")
        case .break:
            return Color("Green100")
        }
    }

    func ColorWithOpacity(opacity: Opacity) -> Color {
        switch self {
        case .stop:
            return Color("Black\(opacity.String())")
        case .pause:
            return Color("Black\(opacity.String())")
        case .play:
            return Color("Red\(opacity.String())")
        case .break:
            return Color("Green\(opacity.String())")
        }
    }

    func ColorGradient() -> Gradient {
        switch self {
        case .stop:
            return Gradient(colors: [Color("PauseFrom"), Color("PauseTo")])
        case .pause:
            return Gradient(colors: [Color("PauseFrom"), Color("PauseTo")])
        case .play:
            return Gradient(colors: [Color("PlayFrom"), Color("PlayTo")])
        case .break:
            return Gradient(colors: [Color("BreakFrom"), Color("BreakTo")])
        }
    }

    func TimerLabel(_ prevStatus: Status?) -> String {
        switch self {
        case .stop:
            return "Get ready to start!🍅️"
        case .pause:
            if prevStatus == .play || prevStatus == .break {
                return prevStatus!.TimerLabel(nil)
            }
            return "Pausing..."
        case .play:
            return "It's Time to Focus⚡️"
        case .break:
            return "Break Time... 😌"
        }
    }

    func TimerButton() -> Image {
        switch self {
        case .stop:
            return Image("icon_timer_play")
        case .pause:
            return Image("icon_timer_play")
        case .play:
            return Image("icon_timer_pause_focus")
        case .break:
            return Image("icon_timer_pause_break")
        }
    }

    func CheckButton(checked: Bool) -> Image {
        switch self {
        case .stop:
            return checked ? Image("icon_list_check_checked") : Image("icon_list_check_default")
        case .pause:
            return checked ? Image("icon_list_check_checked") : Image("icon_list_check_default")
        case .play:
            return checked ? Image("icon_list_check_checked") : Image("icon_list_check_default")
        case .break:
            return checked ? Image("icon_list_check_checked") : Image("icon_list_check_default")
        }
    }
}
