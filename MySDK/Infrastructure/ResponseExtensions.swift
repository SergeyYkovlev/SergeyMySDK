//
//  ResponseExtensions.swift
//  MySDK
//
//  Created by Creonit on 26.06.2024.
//

import Foundation
import Foundation

extension HTTPURLResponse {
    /**
     * Расширение для проверки, является ли ответ кодом 1xx
     */
    var isInformational: Bool {
        return (100...199).contains(self.statusCode)
    }

    /**
     * Расширение для проверки, является ли ответ кодом 3xx
     */
    var isRedirect: Bool {
        return (300...399).contains(self.statusCode)
    }

    /**
     * Расширение для проверки, является ли ответ кодом 4xx
     */
    var isClientError: Bool {
        return (400...499).contains(self.statusCode)
    }

    /**
     * Расширение для проверки, является ли ответ кодом 5xx (стандартным) до 999 (нестандартным)
     */
    var isServerError: Bool {
        return (500...999).contains(self.statusCode)
    }
}
