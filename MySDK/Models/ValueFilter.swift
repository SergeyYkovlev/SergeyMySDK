//
//  ValueFilter.swift
//  MySDK
//
//  Created by Creonit on 27.06.2024.
//

import Foundation

struct ValueFilter: Codable {
    let readableName: String
    let codeName: String
    let kind: ColumnKind
    let textFilter: TextFilter?
    let numberFilter: NumberFilter?
    let dateFilter: DateFilter?
    let relationFilter: RelationFilter?
    
    init(readableName: String, codeName: String, kind: ColumnKind, textFilter: TextFilter? = nil, numberFilter: NumberFilter? = nil, dateFilter: DateFilter? = nil, relationFilter: RelationFilter? = nil) {
        self.readableName = readableName
        self.codeName = codeName
        self.kind = kind
        self.textFilter = textFilter
        self.numberFilter = numberFilter
        self.dateFilter = dateFilter
        self.relationFilter = relationFilter
    }
}
