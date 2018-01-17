//
//  PreferencesTabViewController.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-18.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa

class PreferencesTabViewController: NSTabViewController{
    private var tabTouchBar : NSSegmentedControl!
    func setTouchBarTabSegment(_ segment: NSSegmentedControl){
        tabTouchBar = segment
    }
    override func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        tabTouchBar?.selectedSegment = (tabView.indexOfTabViewItem(tabViewItem!))
    }
}
