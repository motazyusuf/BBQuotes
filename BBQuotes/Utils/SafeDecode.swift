//
//  SafeDecode.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//
import Foundation

extension KeyedDecodingContainer where Key == DynamicCodingKey {
    func safeStringDecode(forKey key: String) -> String {
        let dynamicKey = DynamicCodingKey(stringValue: key)!
        return (try? decodeIfPresent(String.self, forKey: dynamicKey)) ?? ""
    }
    
    func safeNumDecode<T: Numeric & Decodable>(forKey key: String) -> T {
        let dynamicKey = DynamicCodingKey(stringValue: key)!
        return (try? decodeIfPresent(T.self, forKey: dynamicKey)) ?? 0
    }
    
    func safeBoolDecode(forKey key: String) -> Bool {
        let dynamicKey = DynamicCodingKey(stringValue: key)!
        return (try? decodeIfPresent(Bool.self, forKey: dynamicKey)) ?? false
    }
    
    func safeURLDecode(forKey key: String) -> URL? {
        let dynamicKey = DynamicCodingKey(stringValue: key)!
        if let url = try? decodeIfPresent(URL.self, forKey: dynamicKey) {
            return url
        }
        if let urlString = try? decodeIfPresent(String.self, forKey: dynamicKey),
           let url = URL(string: urlString) {
            return url
        }
        return nil
    }
    
    func safeListDecode<T: Decodable>(forKey key: String) -> [T] {
        let dynamicKey = DynamicCodingKey(stringValue: key)!
        
        if T.self == URL.self {
            if let urlArray = try? decodeIfPresent([URL].self, forKey: dynamicKey) {
                return urlArray as! [T]
            }
            if let stringArray = try? decodeIfPresent([String].self, forKey: dynamicKey) {
                let urls = stringArray.compactMap { URL(string: $0) }
                return urls as! [T]
            }
            return []
        }
        
        return (try? decodeIfPresent([T].self, forKey: dynamicKey)) ?? []
    }
    
    func safeObjectDecode<T: Decodable>(forKey key: String, defaultValue: T? = nil) -> T? {
        let dynamicKey = DynamicCodingKey(stringValue: key)!
        return (try? decodeIfPresent(T.self, forKey: dynamicKey)) ?? defaultValue
    }
}

struct DynamicCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int? { nil }
    init?(stringValue: String) { self.stringValue = stringValue }
    init?(intValue: Int) { return nil }
}

