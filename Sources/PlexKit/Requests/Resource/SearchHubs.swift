//
//  SearchHubs.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 28/04/2025.
//



import Foundation

public extension Plex.Request {
    typealias SearchHubs = _SearchHubs<PlexMediaItem>

    struct _SearchHubs<MediaItem: PlexMediaItemType>: PlexResourceRequest {
        public var path: String { "hubs/search" }
        public var queryItems: [URLQueryItem]?

        var query: String

        public init(
          query: String,
          limit: Int = 3
        ) {
            self.query = query
          self.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "limit", value: limit),
            URLQueryItem(name: "includeOnDeck", value: true)
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

public extension Plex.Request._SearchHubs {
    struct MediaContainer: Codable {
        public let size: Int
      private let Hub: [Hub]?

      public var hub: [Hub] {
          Hub ?? []
      }
  }
  struct Hub: Codable {
      public let hubIdentifier, title, type: String
      private let Metadata: [MediaItem]?

      public var metadata: [MediaItem] {
          Metadata ?? []
      }
  }
}
