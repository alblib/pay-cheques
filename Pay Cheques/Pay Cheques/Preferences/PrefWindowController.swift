//
//  PreferencesWindowController.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-16.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa

class PrefWindowController: NSWindowController {
    /*
    private var touchBarTabControl: NSSegmentedControl!{
        let item = touchBar?.item(forIdentifier: NSTouchBarItem.Identifier(rawValue: "pref_tabtouch"))
        return item?.view as! NSSegmentedControl
    }
    
    var subTouchBarGroup: NSGroupTouchBarItem!{
        return touchBar?.item(forIdentifier: NSTouchBarItem.Identifier(rawValue: "pref_submenu")) as! NSGroupTouchBarItem!
    }*/
     
    @IBOutlet weak var touchBarTabControl: NSSegmentedControl!
    @IBOutlet weak var subTouchBarGroup: NSGroupTouchBarItem!
    
    var subTouchBar: NSTouchBar!{
        get{
            return subTouchBarGroup?.groupTouchBar
        }
        set(newValue){
            subTouchBarGroup?.groupTouchBar = newValue ?? NSTouchBar()
        }
    }
   
    var tabViewController: PrefTabViewController!{
        return (contentViewController as? PrefTabViewController!)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        tabViewController.parentWindowController = self
        tabViewController.preferredContentSize = NSSize(width: 640, height: 640)
        touchBarTabControl?.selectedSegment = (tabViewController?.selectedTabViewItemIndex)!
        //subTouchBar? = (tabViewController?.currentViewController as! PrefTabChildViewController).subTouchBar
        
        touchBarTabControl?.target = self
        touchBarTabControl?.action = #selector(self.touchBarTabChanged)
    }

    @objc func touchBarTabChanged(tabControl: NSSegmentedControl!){
        tabViewController?.selectedTabViewItemIndex = (tabControl?.selectedSegment)!
        subTouchBar? = (tabViewController?.currentViewController as! PrefTabChildViewController).subTouchBar
    }
    @IBAction func showMainWindow(_ sender: Any?){
        for window in NSApplication.shared.windows {
            if (window.delegate?.isKind(of: MainWindowController.self)) == true {
                window.makeKeyAndOrderFront(self)
            }
        }
    }
}
