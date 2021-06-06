//
//  Notifications.swift
//  H21
//
//  Created by Lisita Evgheni on 25.05.21.
//

import UserNotifications

protocol Notificator {
    func requestPermissions()
    func scheduleNotifications(with id: String, _ title: String, _ message: String, for time: Date)
    func removeNotifications(with id: String)
}

class Notifications: Notificator {
    func scheduleNotifications(with id: String, _ title: String, _ message: String, for time: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        
        let hour = Calendar.current.component(.hour, from: time)
        let minute = Calendar.current.component(.minute, from: time)
        
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        
        // Create the request
        let requestId = id
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
    
    func removeNotifications(with id: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func requestPermissions() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert])
        { (granted, error) in
            if let error = error {
                print(error)
            }
        }
    }
}
