//
//  ApiAbstractions.swift
//  MySDK
//
//  Created by Creonit on 26.06.2024.
//

import Foundation
import Foundation

typealias MultiValueMap = [String: [String]]

func collectionDelimiter(_ collectionFormat: String) -> String {
    switch collectionFormat {
    case "csv":
        return ","
    case "tsv":
        return "\t"
    case "pipes":
        return "|"
    case "ssv":
        return " "
    default:
        return ""
    }
}

let defaultMultiValueConverter: (Any?) -> String = { item in
    return "\(item ?? "")"
}

func toMultiValue<T>(_ items: [T], collectionFormat: String, map: (Any?) -> String = defaultMultiValueConverter) -> [String] {
    switch collectionFormat {
    case "multi":
        return items.map { map($0) }
    default:
        return [items.map { map($0) }.joined(separator: collectionDelimiter(collectionFormat))]
    }
}
