//
//  SimpleFunction.swift
//  MySDK
//
//  Created by Creonit on 26.06.2024.
//

import Foundation

public class SimpleFunction {
    
    public init() {}
    
    public func sayHello() -> String {
        return "Hello from YourSDKName!"
    }
    
    public func newSayHello(name: String ) -> String {
        return "Hello \(name)"
    }
}
