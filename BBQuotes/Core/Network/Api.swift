//
//  Api.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//
import Foundation

struct Api {
    static var quotes: URL { URL(string: Constants.apiBaseUrl + "quotes/random")! }
    static var characters: URL { URL(string: Constants.apiBaseUrl + "characters")! }
    static var deaths: URL { URL(string: Constants.apiBaseUrl + "deaths")! }
}
