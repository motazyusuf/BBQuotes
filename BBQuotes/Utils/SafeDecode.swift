//
//  SafeDecode.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//
import Foundation

extension KeyedDecodingContainer {
    func safeStringDecode(forKey key: Key) -> String {
        return (try? decodeIfPresent(String.self, forKey: key)) ?? ""
    }
    
    func safeNumDecode<T: Numeric & Decodable>(forKey key: Key) -> T {
        return (try? decodeIfPresent(T.self, forKey: key)) ?? 0
    }
    
    func safeBoolDecode(forKey key: Key) -> Bool {
        return (try? decodeIfPresent(Bool.self, forKey: key)) ?? false
    }
    
    func safeURLDecode(forKey key: Key) -> URL? {
        if let url = try? decodeIfPresent(URL.self, forKey: key) {
            return url
        }
        if let urlString = try? decodeIfPresent(String.self, forKey: key),
           let url = URL(string: urlString) {
            return url
        }
        return nil
    }
    
    func safeListDecode<T: Decodable>(forKey key: Key) -> [T] {
        if T.self == URL.self {
            if let urlArray = try? decodeIfPresent([URL].self, forKey: key) {
                return urlArray as! [T]
            }
            if let stringArray = try? decodeIfPresent([String].self, forKey: key) {
                return stringArray.compactMap { URL(string: $0) } as! [T]
            }
            return []
        }
        return (try? decodeIfPresent([T].self, forKey: key)) ?? []
    }
    
    func safeObjectDecode<T: Decodable>(forKey key: Key, defaultValue: T? = nil) -> T? {
        return (try? decodeIfPresent(T.self, forKey: key)) ?? defaultValue
    }
}

//struct DynamicCodingKey: CodingKey {
//    var stringValue: String
//    var intValue: Int? { nil }
//    init?(stringValue: String) { self.stringValue = stringValue }
//    init?(intValue: Int) { return nil }
//}

