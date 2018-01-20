//
//  AlertBox.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-15.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Cocoa

enum MyError : Error {
    case RuntimeError(String)
}

func alertBox(message : String, description: String) {
    let alert = NSAlert()
    alert.messageText = message
    alert.informativeText = description
    alert.alertStyle = .warning
    alert.addButton(withTitle: NSLocalizedString("Confirm", comment: ""))
    alert.runModal()
}

func criticalError(message: String, description: String){
    let alert = NSAlert()
    alert.messageText = message
    alert.informativeText = description
    alert.alertStyle = .critical
    alert.addButton(withTitle: NSLocalizedString("Confirm", comment: ""))
    alert.runModal()
}

func throwException(_ description: String) throws{
    NSLog("Critical Error: " + description)
    criticalError(message: NSLocalizedString("Critical Error", comment: ""), description: description)
    throw MyError.RuntimeError(description)
}

func throwException(nilObject: String) throws{
    try? throwException(nilObject + " is not initialized.")
}

func yesNoQuestionBox(message: String, description: String) -> Bool{
    let alert = NSAlert()
    alert.messageText = message
    alert.informativeText = description
    alert.alertStyle = .informational
    alert.addButton(withTitle: NSLocalizedString("Yes", comment: ""))
    alert.addButton(withTitle: NSLocalizedString("No", comment: ""))
    return alert.runModal() == .alertFirstButtonReturn
}
/*
func NotOptional(_ object: Any?) throws -> Any {
    if (object == nil){
        try? throwException(nilObject: String(describing: object))
        return 0
    }else{
        return object!
    }
}*/

func NotOptional<T>(_ object: T!, comment: String = "") throws -> T{
    if (object == nil){
        try? throwException(nilObject: String(describing: object) + "(comment: " + comment + ")")
    }
    return object!
}
