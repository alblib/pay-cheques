//
//  PreferencesWindowController.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-16.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa

class PreferencesWindowController: NSWindowController {
    @IBOutlet weak var tabTouchBar: NSSegmentedControl!

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        contentViewController?.preferredContentSize = NSSize(width: 640, height: 640)
        (contentViewController as! PreferencesTabViewController).setTouchBarTabSegment(tabTouchBar)
    }

    @IBAction func tabTouchBar(_ sender: NSSegmentedControl){
        let viewController = self.contentViewController as! NSTabViewController
        viewController.selectedTabViewItemIndex = sender.selectedSegment
    }
    @IBAction func showMainWindow(_ sender: Any?){
        for window in NSApplication.shared.windows {
            if (window.delegate?.isKind(of: MainWindowController.self)) == true {
                window.makeKeyAndOrderFront(self)
            }
        }
    }
}
