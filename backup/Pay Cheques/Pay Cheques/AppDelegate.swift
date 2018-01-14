//
//  AppDelegate.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-14.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa
//import SwiftyDropbox

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    //var dropboxToken: String!
    //var dropboxID: String!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        //DropboxClientsManager.setupWithAppKeyDesktop("cxvvf5czfzx7rzt")
        //NSAppleEventManager.shared().setEventHandler(self,
        //                                             andSelector: #selector(handleGetURLEvent),
        //                                             forEventClass: AEEventClass(kInternetEventClass),
        //                                             andEventID: AEEventID(kAEGetURL))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    /*
    @objc func handleGetURLEvent(_ event: NSAppleEventDescriptor?, replyEvent: NSAppleEventDescriptor?) {
        if let aeEventDescriptor = event?.paramDescriptor(forKeyword: AEKeyword(keyDirectObject)) {
            if let urlStr = aeEventDescriptor.stringValue {
                let url = URL(string: urlStr)!
                if let authResult = DropboxClientsManager.handleRedirectURL(url) {
                    switch authResult {
                    case .success:
                        print("Success! User is logged into Dropbox.")
                        dropboxToken = DropboxClientsManager.authorizedClient?.auth.client.accessToken
                        dropboxID = DropboxClientsManager.authorizedClient?.users.client.selectUser
                        print(dropboxToken)
                        print(dropboxID)
                    case .cancel:
                        print("Authorization flow was manually canceled by user!")
                    case .error(_, let description):
                        print("Error: \(description)")
                        let alert = NSAlert()
                        alert.messageText = "Authorization went wrong"
                        alert.informativeText = description
                        alert.alertStyle = .warning
                        alert.addButton(withTitle: "Confirm")
                        alert.runModal()
                    }
                }
                // this brings your application back the foreground on redirect
                NSApp.activate(ignoringOtherApps: true)
            }
        }
    }*/
}

