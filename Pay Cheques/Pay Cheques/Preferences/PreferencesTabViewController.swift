//
//  PreferencesTabViewController.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-18.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa

class PreferencesTabViewController: NSTabViewController{
    var parentWindowController: PreferencesWindowController!
    var currentViewController: NSViewController?{
        return tabViewItems[selectedTabViewItemIndex].viewController
    }
    override func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, didSelect: tabViewItem)
        parentWindowController?.refreshTouchBarTab()
    }
}
