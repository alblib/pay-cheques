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
    @IBOutlet weak var applicationTouchBar : NSTouchBar!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        // make image template
        #imageLiteral(resourceName: "touch-up").isTemplate = true
        #imageLiteral(resourceName: "touch-left").isTemplate = true
        #imageLiteral(resourceName: "dropbox").isTemplate = true
        
        // Set up application touch bar
        NSApplication.shared.touchBar = applicationTouchBar
        
        // Set up dropbox authentication handler.
        DropboxClientsManager.setupWithAppKeyDesktop(IOVariable.dropboxAppKey)
        NSAppleEventManager.shared().setEventHandler(self,
                                                     andSelector: #selector(handleGetURLEvent),
                                                     forEventClass: AEEventClass(kInternetEventClass),
                                                     andEventID: AEEventID(kAEGetURL))
    }
    
    /** This handler opens Safari for Dropbox authentication when authentication request is called.*/
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
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    /** This function handles to reopen main window and other opened windows. */
    func restoreWindows(){
        for window in NSApplication.shared.windows {
            if (window.delegate?.isKind(of: MainWindowController.self)) == true {
                //window.makeKeyAndOrderFront(self)
                window.orderFront(self)
            }else if (window.isVisible){
                window.orderFront(self)
            }
        }
    }

    /** This function handles to reopen main window and other opened windows when dock icon is clicked. */
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        for window in sender.windows {
            if (window.delegate?.isKind(of: MainWindowController.self)) == true {
                flag ? window.orderFront(self) : window.makeKeyAndOrderFront(self)
            }else if (window.isVisible){
                window.orderFront(self)
            }
        }
        return true
    }
    
    /** This function handles to reopen main window and other opened windows. Signal should be sent from touch bar button. */
    @IBAction func restoreWindows(touchbarButton: NSButton){
        restoreWindows()
    }
    @IBAction func restoreWindows(dockBarMenu: NSMenuItem){
        restoreWindows()
    }
    @IBAction func terminate(touchbarButton: NSButton){
        NSApplication.shared.terminate(self)
    }
}

