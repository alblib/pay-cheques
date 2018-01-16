//
//  CurrencyListWidget.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-16.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa

/**
 A table view displaying currency list. The first column displays ISO codes and the second column displays common name in system language.
 */
class CurrencyListWidget: NSScrollView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func initialize(){
        //documentView.
        //contentView
    }
    
}
