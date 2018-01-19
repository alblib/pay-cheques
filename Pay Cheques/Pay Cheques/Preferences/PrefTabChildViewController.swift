//
//  PrefTabChildViewController.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-19.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa

class PrefTabChildViewController: NSViewController {
<<<<<<< HEAD
    @IBOutlet weak var subTouchBar: NSTouchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
=======
    @IBOutlet weak var touchbarMainTabs: NSSegmentedControl!
    var parentController: NSTabViewController!{
        return parent as! NSTabViewController!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        touchbarMainTabs?.selectedSegment = parentController.tabViewItems.index(of: parentController.tabViewItem(for: self)!)!
        touchbarMainTabs?.target = self
        touchbarMainTabs?.action = #selector(self.touchBarChanged)
    }
    @objc private func touchBarChanged(mainTabControl: NSSegmentedControl!){
        let toGoIndex = mainTabControl?.selectedSegment
        parentController?.selectedTabViewItemIndex = toGoIndex!
        mainTabControl?.selectedSegment = parentController.tabViewItems.index(of: parentController.tabViewItem(for: self)!)!
>>>>>>> df306abdd8da77c8d00fa01388ec8c49148bb2c8
    }
}
