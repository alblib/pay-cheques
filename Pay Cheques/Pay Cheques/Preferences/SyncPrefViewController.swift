//
//  SyncPreferencesView.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-14.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa
import SwiftyDropbox

class SyncPrefViewController: PrefTabChildViewController, NSTabViewDelegate{
    let dropboxNameFieldDefault: String = NSLocalizedString("User Authorization required", comment: "")
    @IBOutlet weak var dropboxNameField: NSTextField!
    @IBOutlet weak var dropboxButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UserDefaults.standard.addObserver(self, forKeyPath: "DropboxStatus", options: .new, context: nil)
        refreshDropboxID()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
            NSLog("d")
            refreshDropboxID()
        }
    }

    deinit{
        UserDefaults.standard.removeObserver(self, forKeyPath: "DropboxStatus")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //do your changes with for key
        if (keyPath == "DropboxStatus"){
            refreshDropboxID()
        }
    }
    func refreshDropboxID(){
        if let client = DropboxClientsManager.authorizedClient {
            client.users.getCurrentAccount().response(completionHandler: { (account : Users.FullAccount?, error : CallError<()>?) in
                if (error != nil) {
                    NSLog("Error ", error?.description ?? "");
                }
                if (account != nil) {
                    let name = account?.name.displayName
                    let email = account?.email
                    let displayname : String = (name != nil && name != "") ? (name! + " <" + (email ?? "") + ">") : (email ?? "")
                    self.dropboxNameField?.stringValue = displayname
                }
            })
            dropboxButton?.title = NSLocalizedString("Deauthorize", comment: "")
        }else{
            dropboxNameField?.stringValue = dropboxNameFieldDefault
            dropboxButton?.title = NSLocalizedString("Authorize", comment: "")
        }
    }
    @IBAction func dropboxAuthorization(sender : NSButton) {
        if (DropboxClientsManager.authorizedClient == nil){
            DropboxClientsManager.authorizeFromController(sharedWorkspace: NSWorkspace.shared, controller: self, openURL: { (url: URL) -> Void in NSWorkspace.shared.open(url)})
        }else{
            DropboxClientsManager.unlinkClients()
            UserDefaults.standard.set("none", forKey: "DropboxStatus")
        }
    }
    @IBAction func dropboxAuthorization(touchbarButton : NSButton) {
        dropboxAuthorization(sender: touchbarButton)
    }
}
