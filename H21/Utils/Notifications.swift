//
//  Notifications.swift
//  H21
//
//  Created by Lisita Evgheni on 25.05.21.
//

import UserNotifications

class Notifications {
    static func requestPermissions() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert])
        { (granted, error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    static func scheduleNotifications(for habit: Habit) {
        let content = UNMutableNotificationContent()
        content.title = habit.title
        content.body = habit.motivation
        
        print("scheduleNotifications for", habit.reminderTime!)

        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        if let reminderDate = habit.reminderTime {
            let hour = Calendar.current.component(.hour, from: reminderDate)
            let minute = Calendar.current.component(.minute, from: reminderDate)
                        
            dateComponents.hour = hour
            dateComponents.minute = minute

            // Create the trigger as a repeating event.
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents, repeats: true)


            // Create the request
            let requestId = habit.id.uuidString
            let request = UNNotificationRequest(identifier: requestId,
                                                content: content, trigger: trigger)

            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error) in
                if let error = error {
                    debugPrint("Schedule notification error: \(error)")
                }
            }
        }
    }
    
    static func removeNotifications(for habit: Habit) {
        let requestId = habit.id.uuidString
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [requestId])
    }
}
