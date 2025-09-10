//
//  ItemImages.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 23/04/2025.
//

import Foundation

public extension Plex.Request {
    struct ItemImages: PlexResourceRequest {
        public var path: String { "/library/metadata/\(ratingKey)/\(imageKey)" }
      
      public var httpMethod: String {uploadUrl == nil ? "GET" : "POST"}
      
      private let ratingKey: String
      private let imageType: PlexImageType
      private var imageKey: String {
        switch imageType {
        case .coverPoster, .snapshot:
          "posters"
        case .background:
          "arts"
        case .clearLogo:
          "clearLogos"
        }
      }
      private var uploadUrl: String?

        public var queryItems: [URLQueryItem]?

        public init(
          ratingKey: String,
          imageType: PlexImageType,
          uploadUrl: String? = nil
        ) {
            self.ratingKey = ratingKey
            self.imageType = imageType
            self.uploadUrl = uploadUrl
          if let uploadUrl {
            self.queryItems = [.init(name: "url", value: uploadUrl)]
          } else {
            self.queryItems = nil
          }
        }

      // When uploading, the response is empty:
          public static func response(from data: Data) throws -> Response {
              // Check if body is empty
              if data.isEmpty {
                  return Response(mediaContainer: nil)
              }

              // Or if it's just whitespace (some servers return " \n")
              if let str = String(data: data, encoding: .utf8), str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                  return Response(mediaContainer: nil)
              }

              return try _response(from: data) // Default JSONDecoder decode
          }

        public struct Response: Codable {
            public let mediaContainer: MediaContainer?

            enum CodingKeys: String, CodingKey {
                case mediaContainer = "MediaContainer"
            }
        }
    }
}

public extension Plex.Request.ItemImages {
    struct MediaContainer: Codable {
        public let size: Int
        public let identifier: String?
        public let mediaTagPrefix: String?
        public let mediaTagVersion: Int?
        private let Metadata: [PlexItemImage]?

        public var metadata: [PlexItemImage] {
          Metadata ?? []
        }
      
    }
}
