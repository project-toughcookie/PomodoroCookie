//
//  PermissionViewModel.swift
//  Momentime
//
//  Created by 성준영 on 2021/01/05.
//

import Combine
import EventKit
import Foundation
import os

class CalendarViewModel: ObservableObject {
    private let calendarManager: AppleCalendarManager
    private let settingManager: SettingManager
    private let permission: Permission
    private var cancellables = Set<AnyCancellable>()

    @Published var granted = false
    @Published var calendars: [TaskCalendar] = []
    @Published var todayTasks: [Task] = []

    init(store: EventStore = EKEventStore(), persistent: Persistent = UserDefaultsPersistent()) {
        calendarManager = AppleCalendarManager(store: store)
        settingManager = SettingManager(persistent: persistent)
        permission = Permission(store: store)
    }

    func requestAccess() {
        permission.request { granted, _ in
            if granted {
                os_log("calendar access granted", type: .debug)
                DispatchQueue.main.async {
                    self.granted = true
                    self.subscribeEvents()
                }
            } else {
                os_log("user doesn't want to share calendar", type: .debug)
            }
        }
    }

    func subscribeEvents() {
        NotificationCenter.default.publisher(for: .EKEventStoreChanged)
            .sink { _ in
                DispatchQueue.main.async {
                    do {
                        try self.sync()
                    } catch {
                        // TODO: error published 변수 추가
                        print(error)
                    }
                }
            }.store(in: &cancellables)
    }

    func sync() throws {
        fetchCalendars()
        if modelData.svm.defaultCalendar != "" {
            try fetchTodayTasks(calendarId: modelData.svm.defaultCalendar)
            return
        }

        if calendars.count != 0 {
            try fetchTodayTasks(calendarId: calendars[0].id)
            return
        }

        todayTasks = []
    }

    func fetchCalendars() {
        calendars = calendarManager.getCalendars()
    }

    func fetchTodayTasks(calendarId: String) throws {
        todayTasks = try calendarManager.getTodayTasks(calendarId: calendarId)
    }
}