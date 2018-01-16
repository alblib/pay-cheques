//
//  AppDelegate.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-15.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa
import SwiftyDropbox

/** All variables and methods to save file */
class IOVariable{
    static let dropboxAppKey : String = "cxvvf5czfzx7rzt"
    static var localPath: String!{
        get{
            return UserDefaults.standard.string(forKey: "localPath") ?? NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] as String
        }
        set(newValue){
            if (newValue == nil || newValue == ""){
                UserDefaults.standard.removeObject(forKey: "localPath")
            }else{
                UserDefaults.standard.set(newValue, forKey: "localPath")
            }
        }
    }
}


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag{
            let sb = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
            let controller = sb.instantiateInitialController() as! NSWindowController
            
            controller.window?.makeKeyAndOrderFront(self)
            //self.window = controller.window
        }
        
        return true
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        DropboxClientsManager.setupWithAppKeyDesktop(IOVariable.dropboxAppKey)
        NSAppleEventManager.shared().setEventHandler(self,
                                                     andSelector: #selector(handleGetURLEvent),
                                                     forEventClass: AEEventClass(kInternetEventClass),
                                                     andEventID: AEEventID(kAEGetURL))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func handleGetURLEvent(_ event: NSAppleEventDescriptor?, replyEvent: NSAppleEventDescriptor?) {
        if let aeEventDescriptor = event?.paramDescriptor(forKeyword: AEKeyword(keyDirectObject)) {
            if let urlStr = aeEventDescriptor.stringValue {
                let url = URL(string: urlStr)!
                if let authResult = DropboxClientsManager.handleRedirectURL(url) {
                    switch authResult {
                    case .success:
                        print("Success! User is logged into Dropbox.")
                        UserDefaults.standard.set("token", forKey: "DropboxStatus")
                    case .cancel:
                        print("Authorization flow was manually canceled by user!")
                    case .error(_, let description):
                        print("Error: \(description)")
                    }
                }
                // this brings your application back the foreground on redirect
                NSApp.activate(ignoringOtherApps: true)
            }
        }
    }
}

