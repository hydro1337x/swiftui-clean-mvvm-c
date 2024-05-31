//
//  StoryViewModel.swift
//  UI
//
//  Created by Benjamin Mecanović on 14.02.2023..
//

import Foundation

public struct StoryViewModel: Identifiable, Hashable {
    public let id: String
    public let backgroundURL: URL
    let locationName: String
    let locationURL: URL
}
