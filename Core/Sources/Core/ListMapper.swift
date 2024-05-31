//
//  ListMapper.swift
//  Core
//
//  Created by Benjamin Mecanović on 12.02.2023..
//

import Foundation

public enum ListMapper {
    public static func map<I, O>(_ input: [I], mapper: (I) -> O) -> [O] {
        input.map(mapper)
    }
    
    public static func mapNullableInput<I, O>(_ input: [I]?, mapper: (I) -> O) -> [O] {
        input?.map(mapper) ?? []
    }
    
    public static func mapNullableOutput<I, O>(_ input: [I], mapper: (I) -> O) -> [O]? {
        let output = input.map(mapper)
        
        return output.isEmpty ? nil : output
    }
}
