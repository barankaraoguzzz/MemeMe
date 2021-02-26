//
//  ShareManager.swift
//  MemeMe
//
//  Created by BARAN BATUHAN KARAOGUZ on 26.02.2021.
//

import UIKit

class ShareManager {
    
    func startShareWith(from fromVC: UIViewController?, withSharingTypeProtocol sharingType: SharingType) {
        
        var items: [AnyHashable] = []
        
       
        if let image = sharingType.displayImage {
            items.append(image)
        }
    
        if let contentText = sharingType.displayText {
            items.append(contentText)
        }
        
        if let urlString = sharingType.displayLink {
            if let url = URL(string: urlString) {
                items.append(url)
            }
        }

        if let attachmentPath = sharingType.attachmentPath {
            items.append(URL(fileURLWithPath: attachmentPath))
        }
        
        if let data = sharingType.attachmentData {
            items.append(data)
        }
        
        if items.count > 0 {
            let controller = createActivityViewController(items)
           
            if let subject = sharingType.subject{
                 controller?.setValue(subject, forKey: "subject")
            }
            
            presentActivityController(controller, withFrom: fromVC)
        } else {
            print("Sorry, i have not shareing data")
        }
        
    }
    
    private func createActivityViewController(_ items: [AnyHashable]?) -> UIActivityViewController? {
        var controller: UIActivityViewController? = nil
        if let items = items {
            controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        }
        return controller
    }
    
    private func presentActivityController(_ controller: UIActivityViewController?, withFrom fromVC: UIViewController?) {
        fromVC?.present(controller!, animated: true, completion: nil)
        
        // access the completion handler
        controller?.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            if completed {
                // user shared an item
                print("We used activity type\(activityType ?? UIActivity.ActivityType(rawValue: ""))")
            } else {
                // user cancelled
                print("We didn't want to share anything after all.")
            }
            if error != nil {
                print("An Error occured: \(error?.localizedDescription ?? ""), \((error as NSError?)?.localizedFailureReason ?? "")")
            }
        }
    }

    
}
