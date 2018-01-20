
//
//  PayPrefViewController.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-19.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa

class PayPrefViewController: PrefTabChildViewController, NSTabViewDelegate {
    @IBOutlet weak var childTabView: NSTabView!
    @IBOutlet var touchBarTabControl: NSSegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        touchBarTabControl!.selectedSegment = childTabView.indexOfTabViewItem(childTabView.selectedTabViewItem!)
    }
    
    func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        try? NotOptional(touchBarTabControl, comment: "PayPrefViewController(self).touchBarTabControl").selectedSegment = tabView.indexOfTabViewItem(tabViewItem!)
    }
    
    @IBAction func touchBarAction(tab: NSSegmentedControl){
        try? NotOptional(childTabView, comment: "PayPrefViewController(self).childTabView").selectTabViewItem(at: tab.selectedSegment)
    }
    
}
