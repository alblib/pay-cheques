//
//  PreferencesWindowController.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-16.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa

class PrefWindowController: NSWindowController {
    //@IBOutlet weak var tabTouchBar: NSSegmentedControl!
    
    private var touchBarTabControl: NSSegmentedControl!{
        let item = touchBar?.item(forIdentifier: NSTouchBarItem.Identifier(rawValue: "pref_tabtouch"))
        return item?.view as! NSSegmentedControl
    }
    
    var subTouchBarGroup: NSGroupTouchBarItem!{
        return touchBar?.item(forIdentifier: NSTouchBarItem.Identifier(rawValue: "pref_submenu")) as! NSGroupTouchBarItem!
    }
    
    //@IBOutlet weak var touchBarTabControl: NSSegmentedControl!
    //@IBOutlet weak var subTouchBarGroup: NSGroupTouchBarItem!
    
    var subTouchBar: NSTouchBar!{//NSGroupTouchBarItem! {
        get{
            return subTouchBarGroup?.groupTouchBar
        }
        set(newValue){
            subTouchBarGroup?.groupTouchBar = newValue ?? NSTouchBar()
        }
    }
    
    var contentTabViewController: PreferencesTabViewController{
        return (contentViewController as! PreferencesTabViewController)
    }
    
    var selectedTabChildViewController: NSViewController?{
        return contentTabViewController.currentViewController
    }
    
    private var selectedTabViewItemIndex: Int{
        get{
            return contentTabViewController.selectedTabViewItemIndex
        }set(newValue){
            contentTabViewController.selectedTabViewItemIndex = newValue
        }
    }
    
    private var selectedTouchBarTabItemIndex: Int{
        get{
            return (touchBarTabControl?.selectedSegment)!
        }set(newValue){
            touchBarTabControl.selectedSegment = newValue
            subTouchBar = selectedTabChildViewController?.touchBar
        }
    }
    
    func refreshTouchBarTab(){
        selectedTouchBarTabItemIndex = selectedTabViewItemIndex
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        contentTabViewController.parentWindowController = self
        contentTabViewController.preferredContentSize = NSSize(width: 640, height: 640)
        refreshTouchBarTab()
    }

    @IBAction func touchBarTabChanged(tabControl: NSSegmentedControl){
        selectedTabViewItemIndex = tabControl.selectedSegment
        subTouchBar = selectedTabChildViewController?.touchBar
    }
    @IBAction func showMainWindow(_ sender: Any?){
        for window in NSApplication.shared.windows {
            if (window.delegate?.isKind(of: MainWindowController.self)) == true {
                window.makeKeyAndOrderFront(self)
            }
        }
    }
}
