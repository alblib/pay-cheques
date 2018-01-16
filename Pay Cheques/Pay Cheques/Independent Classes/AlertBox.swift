//
//  AlertBox.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-15.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa

func alertBox(message : String, description: String) {
    let alert = NSAlert()
    alert.messageText = message
    alert.informativeText = description
    alert.alertStyle = .warning
    alert.addButton(withTitle: NSLocalizedString("Confirm", comment: ""))
    alert.runModal()
}
