//
//  PreferencesWindowController.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-16.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa
//import ReactiveSwift
//import Result

class PrefWindowController: NSWindowController {
    
    // Touch Bar Main Button Variables
    
    @IBOutlet var touchBarMainButton: NSButton!
    func initTouchBarMainButton(){
        touchBarMainButton?.bezelColor = NSColor.labelColor
        touchBarMainButton?.image = NSImage(named: NSImage.Name.smartBadgeTemplate)
        touchBarMainButton?.target = self
        touchBarMainButton?.action = #selector(touchBarMainButtonClicked)
    }
    @objc private func touchBarMainButtonClicked(mainButton: NSButton!){
        if (mainButtonToggled){
            closeWindow(mainButton)
        }else{
            mainButtonToggled = true
        }
    }
    /** Makes touchbar main button to toggle to close button. The button toggles into default state automatically in specific time. */
    var mainButtonToggled: Bool = false{
        didSet{
            if (mainButtonToggled){
                touchBarMainButton?.bezelColor = nil
                touchBarMainButton?.image = NSImage(named: NSImage.Name.stopProgressTemplate)
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
                    self.mainButtonToggled = false
                })
            }else{
                touchBarMainButton?.bezelColor = NSColor.labelColor
                touchBarMainButton?.image = NSImage(named: NSImage.Name.smartBadgeTemplate)
            }
        }
    }
    /** Closes current preferences window. Equivalent to close(). */
    @objc func closeWindow(_ sender: NSButton){
        close()
    }
    
     
    
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
    
    var currentViewController: PrefTabChildViewController!{
        return tabViewController?.currentViewController as? PrefTabChildViewController!
    }
    
    var currentSubTouchBar: NSTouchBar{
        return currentViewController?.subTouchBar ?? NSTouchBar()
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        tabViewController.preferredContentSize = NSSize(width: 640, height: 640)
        touchBarTabControl?.selectedSegment = (tabViewController?.selectedTabViewItemIndex)!
        subTouchBar = currentSubTouchBar
        
        initTouchBarMainButton()
        touchBarTabControl?.target = self
        touchBarTabControl?.action = #selector(self.touchBarTabChanged)
    }
    
    @objc private func touchBarTabChanged(tabControl: NSSegmentedControl!){
        tabViewController?.selectedTabViewItemIndex = (tabControl?.selectedSegment)!
        subTouchBar = (tabViewController?.tabView.selectedTabViewItem?.viewController as! PrefTabChildViewController).subTouchBar ?? NSTouchBar()
    }
    @IBAction func showMainWindow(_ sender: Any?){
        for window in NSApplication.shared.windows {
            if (window.delegate?.isKind(of: MainWindowController.self)) == true {
                window.makeKeyAndOrderFront(self)
            }
        }
    }

}
