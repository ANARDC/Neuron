//
//  NotificationsProcesses.swift
//  Neuron
//
//  Created by Anar on 05/08/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UserNotifications

class NotificationsProcesses {
    let notificationCenter = UNUserNotificationCenter.current()
    var tasksNotificationsStatus = "daily"
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
    
    func scheduleNotification(notificationType: String, hour: Int?, minute: Int?, frequency: String?) {
        let content = UNMutableNotificationContent()
        
        let diaryNotificationBody = "Reminder that you need to fill in the diary. The diary can be filled only once a day."
        let fruitsNotificationBody = "You have not trained in the game \"Fruits\" for more than a day. You need find time to practice."
        
        content.title = notificationType == "DiaryFillingNotificationID" ? "" : "Fruits"
        content.body = notificationType == "DiaryFillingNotificationID" ? diaryNotificationBody : fruitsNotificationBody
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        var request: UNNotificationRequest
        
        if let hour = hour, let minute = minute {
            let date = DateComponents(hour: hour, minute: minute)
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
            let identifier = "DiaryFillingNotificationID"
            request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        } else {
            let date = Date()
            
            var triggerFrequency: DateComponents
            
            let identifier = "TasksPerformanceNotificationID"
            
            switch frequency! {
            case "daily":
                triggerFrequency = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
            case "weekly":
                triggerFrequency = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: date)
            default:
                triggerFrequency = Calendar.current.dateComponents([.weekOfMonth, .weekday, .hour, .minute, .second], from: date)
            }
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerFrequency, repeats: true)
            request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        }
        
        
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func removeNotification(notificationType: String) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationType])
    }
}
