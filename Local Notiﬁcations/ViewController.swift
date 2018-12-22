//
//  ViewController.swift
//  Local Notiﬁcations
//
//  Created by Evgeniy Ryshkov on 22/12/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) {[unowned self] (granted, error) in
            if granted {
//                print("Yay!")
                DispatchQueue.main.async {
                    self.alert(title: "Yay!", message: nil, dismissTitle: "OK")
                }
            }else{
//                print("D'oh")
                DispatchQueue.main.async {
                    self.alert(title: "D'oh", message: nil, dismissTitle: "OK")
                }
            }
        }
    }
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches worm, but the second mouse gets the cheese"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData":"fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 13
        dateComponents.minute = 29
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
        
    }


}

extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // pull out the buried userInfo dictionary
        let userInfo = response.notification.request.content.userInfo
        
        var receivedData = ""
        
        if let customData = userInfo["customData"] as? String {
            receivedData = "Custom data received: \(customData)"
//            print(receivedData)
        }
        
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            // the user swiped to unlock
//            print("Default identifier")
            alert(title: "Default identifier selected", message: receivedData, dismissTitle: "OK")
        case "show":
            // the user tapped our "show more info..." button
//            print("Show more information...")
            alert(title: "Show more information selected", message: receivedData, dismissTitle: "OK")
        default:
            break
        }
        
        completionHandler()
    }
}
