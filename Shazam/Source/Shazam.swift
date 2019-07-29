//
//  Shazam.swift
//
//  Created by Medi Assumani on 3/16/19.
// Copyright (c) 2019 Medi Assumani

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
// associated documentation files (the "Software"), to deal in the Software without restriction, including

// without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
// following conditions:

// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
// USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

// - MARK: Typealias

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?


// - MARK: Enums

public enum DownloadProgress {
    
    case idle, fired, downloading, completed, failed
}

public enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum HTTPNetworkError: String, Error {
    
    case parametersNil = "Error Found : Parameters are nil."
    case headersNil = "Error Found : Headers are Nil"
    case encodingFailed = "Error Found : Parameter Encoding failed."
    case decodingFailed = "Error Found : Unable to Decode the data."
    case missingURL = "Error Found : The URL is nil."
    case noData = "Error Found : No Data from the API was returned."
    case FragmentResponse = "Error Found : The API's response's body has fragments."
    case UnwrappingError = "Error Found : Unable to unwrape the data."
    case dataTaskFailed = "Error Found : The Data Task object failed."
    case success = "Successful Network Request"
    case authenticationError = "Error Found : Your request must be Authenticated"
    case badRequest = "Error Found : Bad Request"
    case pageNotFound = "Error Found : Page/Route rquested not found."
    case failed = "Error Found : Network Request failed"
    case serverSideError = "Error Found : Server Side Error"
}

// - MARK: Protocols

public protocol DownloadDelegate {
    
    var progress: DownloadProgress { get }
    
    func get<T> (parameters: HTTPParameters?, headers: HTTPHeaders?, completion: @escaping(Result<T?, Error>) -> ()) where T: Decodable
    
    func set (parameters: HTTPParameters?, headers: HTTPHeaders?, method: HTTPMethod, body: Data?, completion: @escaping(Result<Bool, Error>) -> ())
}

// - MARK: CLASS

@available(iOS 12.0, *)
public class Shazam: DownloadDelegate {
    
    // Keeps track of the download progress throughout the network call
    public var progress: DownloadProgress = .idle
    
    // The endpoint/route/url to make the request to
    public var urlString: String
    
    public init(withUrlString url: String) {
        self.urlString = url
    }
    
    
    /// Use to make `GET` requests to *urlString* with optional *headers* and *parameters*
    public func get<T>(parameters: HTTPParameters?, headers: HTTPHeaders?, completion: @escaping (Result<T?, Error>) -> ()) where T : Decodable {
        
        progress = .fired
        do {
            let request = try HTTPNetworkRequest.configureHTTPRequest(path: urlString, params: parameters, headers: headers, body: nil, method: .get, progress: &progress)
            
            URLSession.shared.dataTask(with: request) { (data, response, err) in
                
                self.progress = .downloading
                guard let unwrappedResponse = response as? HTTPURLResponse, let unwrappedData = data else { return }
                
                let responseResult = HTTPNetworkResponse.handleNetworkResponse(for: unwrappedResponse)
                
                switch responseResult{
                case .success:
                    do {
                        let result = try JSONDecoder().decode(T.self, from: unwrappedData)
                        self.progress = .completed
                        completion(.success(result))
                        
                    } catch {
                        completion(.failure(HTTPNetworkError.decodingFailed))
                        self.progress = .failed
                    }
                case let .failure(error):
                    
                    self.progress = .failed
                    completion(.failure(error))
                }
                }.resume()
        } catch {
            progress = .failed
            completion(.failure(error))
        }
    }
    
    /// Use to make `POST`, `PUT`, `PATCH`, `DELETE` requests
    public func set(parameters: HTTPParameters?, headers: HTTPHeaders?, method: HTTPMethod, body: Data?, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        progress = .fired
        do {
            
            let request = try HTTPNetworkRequest.configureHTTPRequest(path: urlString, params: parameters, headers: headers, body: body, method: method, progress: &progress)
            
            URLSession.shared.dataTask(with: request) { (data, res, err) in
                
                guard let unwrappedResponse = res as? HTTPURLResponse else { return }
                
                if (unwrappedResponse.statusCode >= 200 && unwrappedResponse.statusCode <= 299) {
                    completion(.success(true))
                } else {
                    completion(.failure(HTTPNetworkError.FragmentResponse))
                }
                
                }.resume()
        } catch {
            completion(.failure(HTTPNetworkError.badRequest))
        }
    }
}


// - MARK: STRUCT

public struct URLEncoder {
    
    /// Encode and set the parameters of a url request
    public static func encodeParameters(for urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        if parameters == nil { return }
        guard let url = urlRequest.url, let unwrappedParameters = parameters else { throw HTTPNetworkError.missingURL }
        
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !unwrappedParameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in unwrappedParameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
    }
    
    /// Set the http headers of the request, e.g: Auth Tokens
    public static func setHeaders(for urlRequest: inout URLRequest, with headers: HTTPHeaders) throws {
        
        if headers == nil { return }
        
        guard let unwrappedHeaders = headers else { throw HTTPNetworkError.headersNil }
        for (key, value) in unwrappedHeaders{
            urlRequest.setValue(value as? String, forHTTPHeaderField: key)
        }
    }
}


public struct HTTPNetworkResponse {
    
    /// Properly checks and handles the status code of the response
    public static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<String, Error>{
        
        guard let res = response else { return Result.failure(HTTPNetworkError.UnwrappingError)}
        
        switch res.statusCode {
        case 200...299: return .success(HTTPNetworkError.success.rawValue)
        case 401: return .failure(HTTPNetworkError.authenticationError)
        case 400...499: return .failure(HTTPNetworkError.badRequest)
        case 500...599: return .failure(HTTPNetworkError.serverSideError)
        default: return .failure(HTTPNetworkError.failed)
        }
    }
    
}


public struct HTTPNetworkRequest {
    
    /// Set the body, method, headers, and paramaters of the request
    public static func configureHTTPRequest(path: String, params: HTTPParameters?, headers: HTTPHeaders?, body: Data?, method: HTTPMethod, progress: inout DownloadProgress) throws -> URLRequest {
        
        guard let url = URL(string: path) else { throw HTTPNetworkError.missingURL }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        try configureParametersAndHeaders(parameters: params, headers: headers, request: &request, progress: &progress)
        
        return request
    }
    
    /// Configure the request parameters and headers before the API Call
    public static func configureParametersAndHeaders(parameters: HTTPParameters?,
                                                     headers: HTTPHeaders?,
                                                     request: inout URLRequest,
                                                     progress: inout DownloadProgress) throws {
        do {
            
            if let headers = headers, let parameters = parameters {
                try URLEncoder.encodeParameters(for: &request, with: parameters)
                try URLEncoder.setHeaders(for: &request, with: headers)
            }
        } catch {
            
            progress = .failed
            throw HTTPNetworkError.encodingFailed
        }
    }
}
