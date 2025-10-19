//
//  NetworkLogger.swift
//  BBQuotes
//
//  Created by Moataz on 19/10/2025.
//

import Foundation


struct NetworkLogger {
    static func logRequest(_ request: URLRequest) {
        print("🚀 [REQUEST START]")
        print("➡️ URL: \(request.url?.absoluteString ?? "❌ No URL")")
        print("➡️ Method: \(request.httpMethod ?? "❌ No Method")")
        
        if let headers = request.allHTTPHeaderFields {
            print("📋 Headers: \(headers)")
        }
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("📦 Body: \(bodyString)")
        }
        
        print("🚀 [REQUEST END]\n")
    }
    
    static func logResponse(_ response: URLResponse?, data: Data?) {
        print("📬 [RESPONSE START]")
        
        if let httpResponse = response as? HTTPURLResponse {
            print("✅ Status Code: \(httpResponse.statusCode)")
            print("📍 URL: \(httpResponse.url?.absoluteString ?? "❌ No URL")")
            print("📋 Headers: \(httpResponse.allHeaderFields)")
        } else {
            print("❌ No valid HTTP response")
        }
        
        if let data = data,
           let responseBody = String(data: data, encoding: .utf8) {
            print("🧾 Body: \(responseBody)")
        }
        
        print("📬 [RESPONSE END]\n")
    }
    
    static func logError(_ error: Error) {
        print("🔥 [ERROR]: \(error.localizedDescription)")
    }
}


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}


struct NetworkHelper {
    
    // Request without a body
    static func request<T: Decodable>(
        url: URL,
        method: HttpMethod = .get,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        var finalURL = url
        if let queryItems = queryParams {
            finalURL = finalURL.appending(queryItems: queryItems)
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        NetworkLogger.logRequest(request)
        let (data, response) = try await URLSession.shared.data(for: request)
        NetworkLogger.logResponse(response, data: data)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // Request with an Encodable body
    static func request<T: Decodable, B: Encodable>(
        url: URL,
        method: HttpMethod = .post,
        queryItems: [URLQueryItem]? = nil,
        body: B,
        headers: [String: String]? = nil,
        responseType: T.Type
    ) async throws -> T {
        var finalURL = url
        if let queryItems = queryItems {
            finalURL = finalURL.appending(queryItems: queryItems)
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try JSONEncoder().encode(body)
        
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        NetworkLogger.logRequest(request)
        let (data, response) = try await URLSession.shared.data(for: request)
        NetworkLogger.logResponse(response, data: data)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
