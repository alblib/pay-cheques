//
//  Currency.swift
//  Pay Cheques
//
//  Created by WOOHYUN RIM on 2018-01-16.
//  Copyright © 2018 Protelum Liberium. All rights reserved.
//

import Foundation

class Currency{
    
    /** ISO currency codes for commonly used currencies defined by the Apple system, which is equivalent to NSLocale.commonISOCurrencyCodes. */
    static var famousList: [String]{
        return [NSLocale.current.currencyCode!] + NSLocale.commonISOCurrencyCodes.filter{$0 != NSLocale.current.currencyCode}
    }

    /** ISO currency codes for all currencies known by the Apple system, which is equivalent to NSLocale.isoCurrencyCodes. */
    static var knownList: [String]{
        return famousList + NSLocale.isoCurrencyCodes.filter { !famousList.contains($0) }
    }
    
    init(_ isoCode: String){
        self.isoCode = isoCode
    }
    /** ISO currency codes for current object. */
    var isoCode: String
    /** Commonly used currency symbol for current object. */
    var symbol: String! {
        let locale = NSLocale(localeIdentifier: isoCode)
        if locale.displayName(forKey: .currencySymbol, value: isoCode) == isoCode {
            let newlocale = NSLocale(localeIdentifier: isoCode.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: isoCode)
        }
        return locale.displayName(forKey: .currencySymbol, value: isoCode)
    }
    /** English common name used for specified currency. */
    var commonName: String{
        return NSLocale.system.localizedString(forCurrencyCode: isoCode)!
    }
    /** Common name used for specified currency in current system language. */
    var localizedName: String{
        return Locale.current.localizedString(forCurrencyCode: isoCode)!
    }
    
    /** Currency object of current system locale. */
    static let current = Currency(NSLocale.current.currencyCode!)
}
