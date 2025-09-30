//
//  NotificationManager.swift
//  RemindMe
//
//  Created by Anbalagan on 14/03/24.
//

import Foundation
import UserNotifications

final class NotificationManager: NSObject, @unchecked Sendable {
    static let shared = NotificationManager()

    private let userNotificationCenter = UNUserNotificationCenter.current()

    private override init() {
        super.init()
        initialSetup()
    }

    private func initialSetup() {
        userNotificationCenter.delegate = self
    }

    func requestAuthorization(_ completion: @escaping @Sendable (Result<Bool, any Error>) -> Void) {
        let authorizationOption: UNAuthorizationOptions = [
            .alert,
            .sound,
            .badge,
            .provisional,
            .criticalAlert,
            .providesAppNotificationSettings
        ]

        userNotificationCenter.requestAuthorization(options: authorizationOption) { isAuthorized, error in
            let result: Result<Bool, any Error> = if let error {
                .failure(error)
            } else {
                .success(isAuthorized)
            }

            completion(result)
        }
    }

    func getNotificationSettings(_ completion: @Sendable @escaping (UNNotificationSettings) -> Void) {
        userNotificationCenter.getNotificationSettings(completionHandler: completion)
    }
    
    func getScheduleNotificationList() {
        userNotificationCenter.getPendingNotificationRequests { notificationRequest in
            print(notificationRequest)
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.list, .banner, .sound])
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        completionHandler()
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        openSettingsFor notification: UNNotification?
    ) {
        // TODO: show notification setting screen if have any screen dedicated for notification
        print(#function)
    }
}
