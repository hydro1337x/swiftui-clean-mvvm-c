//
//  GraphQLNullable+Extension.swift
//  Data
//
//  Created by Benjamin Mecanović on 11.02.2023..
//

import ApolloAPI

extension GraphQLNullable {
    init(value: Wrapped?) {
        self = value == nil ? nil : .some(value!)
    }
    
    init<T: EnumType>(`case`: T?) where Wrapped == GraphQLEnum<T> {
        self = `case` == nil ? nil : .some(.case(`case`!))
    }
}
