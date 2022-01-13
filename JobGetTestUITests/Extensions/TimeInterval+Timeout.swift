//
//  Timeout.swift
//  NutmegUITests
//
//  Created by Kiryl Karabeika on 8/1/19.
//  Copyright © 2019 Nutmeg. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    /// Standard timeout to wait after regular animation, e.g. push or pop
    static let standardTimeout = 4.0
    
    /// Long timeout to wait after long animation, e.g. Log out
    static let longTimeout = 8.0
}
