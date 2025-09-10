//
//  Search.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 28/04/2025.
//

import Foundation

public extension Plex.Request {
    typealias Search = _Search<PlexMediaItem>

    struct _Search<MediaItem: PlexMediaItemType>: PlexResourceRequest {
        public var path: String { "search" }
        public var queryItems: [URLQueryItem]?

        var query: String

        public init(
          query: String
        ) {
            self.query = query
          self.queryItems = [
            URLQueryItem(name: "query", value: query),
        ]
        }

        public struct Response: Codable {
            public let mediaContainer: MediaContainer
          
          enum CodingKeys: String, CodingKey {
              case mediaContainer = "MediaContainer"
          }
        }
    }
}

public extension Plex.Request._Search {
    struct MediaContainer: Codable {
        public let size: Int
      public let identifier: String?
      public let mediaTagPrefix: String?
      public let mediaTagVersion: Int?
        private let Metadata: [MediaItem]?

        public var metadata: [MediaItem] {
            Metadata ?? []
        }
    }
}
