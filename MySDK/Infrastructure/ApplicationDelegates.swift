//
//  ApplicationDelegates.swift
//  MySDK
//
//  Created by Creonit on 26.06.2024.
//

import Foundation

class ApplicationDelegates {
    /**
     * Предоставляет делегата свойства, позволяя установить свойство один раз и только один раз.
     *
     * Если не установлено (без значения по умолчанию), получение свойства вызовет [IllegalStateException].
     */
    static func setOnce<T>(defaultValue: T? = nil) -> ReadWriteProperty<T> {
        return ReadWriteProperty(defaultValue: defaultValue)
    }

    class ReadWriteProperty<T> {
        private var isSet = false
        private var value: T?

        init(defaultValue: T? = nil) {
            self.value = defaultValue
        }

        var wrappedValue: T {
            get {
                guard let value = value else {
                    fatalError("Свойство не инициализировано")
                }
                return value
            }
            set {
                synchronized(self) {
                    if !isSet {
                        value = newValue
                        isSet = true
                    }
                }
            }
        }
        
        private func synchronized(_ lock: AnyObject, closure: () -> Void) {
            objc_sync_enter(lock)
            closure()
            objc_sync_exit(lock)
        }
    }
}
