//
//  ProductionEnum.swift
//  BBQuotes
//
//  Created by Moataz on 19/10/2025.
//
import Foundation
import SwiftUI

enum ProductionType: String, CaseIterable, Identifiable{
    var id: Self { self } 

    
    case breakingBad = "Breaking Bad"
    case betterCallSaul = "Better Call Saul"
    case elCamino = "El Camino"
    
    var backgroundImage: Image {
        switch self {
        case .breakingBad:
            Image(.breakingbad)
        case .betterCallSaul:
            Image(.bettercallsaul)
        case .elCamino:
            Image(.elcamino)
        }
    }
    
    var buttonColor: Color {
        switch self {
        case .breakingBad:
            Color(.breakingBadGreen)
        case .betterCallSaul:
            Color(.betterCallSaulBlue)
        case .elCamino:
            Color(.elCaminoRed)
        }
    }
    
    var shadowColor: Color {
        switch self {
        case .breakingBad:
            Color(.breakingBadYellow)
        case .betterCallSaul:
            Color(.betterCallSaulBrown)
        case .elCamino:
            Color(.black)
        }
    }
    
    var tabIcon: String {
        switch self {
        case .breakingBad:
            "tortoise"
        case .betterCallSaul:
            "briefcase"
        case .elCamino:
            "car"
        }
    }
    
}
