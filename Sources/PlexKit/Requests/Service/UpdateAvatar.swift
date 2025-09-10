//
//  UpdateAvatar.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 19/07/2025.
//

import Foundation

public extension Plex.ServiceRequest {
    struct UpdateAvatar: PlexServiceRequest {
        public let imageData: Data
        public let path = "api/v2/user"
        public let httpMethod = "PUT"
      private let boundary: String

        public init(imageData: Data) {
            self.imageData = imageData
          self.boundary = "Boundary-\(UUID().uuidString)"
        }

        public func asURLRequest(using token: String?) throws -> URLRequest {
            let urlString = "https://plex.tv/\(path)"
            var request = URLRequest(url: URL(string: urlString)!)
            request.httpMethod = httpMethod
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            if let t = token {
                request.addValue(t, forHTTPHeaderField: "X-Plex-Token")
            }
            let body = try makeBody()
            request.httpBody = body
            return request
        }


        private func makeBody() throws -> Data {
            var data = Data()
            let lineBreak = "\r\n"

          data.append("--\(boundary)\(lineBreak)".data(using: .utf8)!)
          data.append("Content-Disposition: form-data; name=\"avatar\"; filename=\"blob\"\(lineBreak)".data(using: .utf8)!)
          data.append("Content-Type: image/png\(lineBreak)\(lineBreak)".data(using: .utf8)!)
          data.append(imageData)
          data.append("\(lineBreak)--\(boundary)--\(lineBreak)".data(using: .utf8)!)
            return data
        }

        public struct Response: Decodable {
            // parse necessary response (optional)
        }

        public static func response(from data: Data) throws -> Response {
            // If empty, just ignore
            return Response()
        }
    }
}

