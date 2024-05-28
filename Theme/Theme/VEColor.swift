//
//  VEColor.swift
//  Core
//
//  Created by Benjamin Mecanović on 30.05.2022..
//

public enum VEColor {
    case foreground
    case foregroundSecondary
    case foregroundTertiary
    case accent
    case background
//    case failure
//    case warning
//    case success

    public var hex: String {
        switch self {
        case .foreground:
            return "#FFFFFF"
        case .foregroundSecondary:
            return "#ADA4A9"
        case .foregroundTertiary:
            return "#6E686B"
        case .accent:
            return "#E31362"
        case .background:
            return "#111111"
//        case .failure:
//            return "#EE4B2B"
//        case .warning:
//            return "#FFA500"
//        case .success:
//            return "#42C0FB"
        }
    }
}
