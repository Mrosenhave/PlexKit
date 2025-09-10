//
//  Hubs.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 16/07/2025.
//


import Foundation

public extension Plex.Request {
  // fetches the home page content
    typealias Hubs = _Hubs<PlexMediaItem>

    struct _Hubs<MediaItem: PlexMediaItemType>: PlexResourceRequest {
        public var path: String
        public var queryItems: [URLQueryItem]?
      

        public init(
          key: String = "hubs",
          includedLibraries: String? = nil,
          count: Int = 25,
          excludeContinueWatching: Bool = false
        ) {
          self.path = key
          self.queryItems = [
            .init(name: "count", value: count),
            .init(name: "excludeContinueWatching", value: excludeContinueWatching),
            .init(name: "includeMeta", value: true)
        ]
          if let includedLibraries {
            self.queryItems?.append(
              .init(name: "contentDirectoryID", value: includedLibraries))
          }
        }

        public struct Response: Codable {
            public let mediaContainer: MediaContainer
          
          enum CodingKeys: String, CodingKey {
              case mediaContainer = "MediaContainer"
          }
        }
    }
}

public extension Plex.Request._Hubs {
    struct MediaContainer: Codable {
        public let size: Int
      private let Hub: [Hub]?

      public var hub: [Hub] {
          Hub ?? []
      }
  }
  struct Hub: Codable, Hashable {
      public let hubIdentifier, title, type, key: String
      public let more: Bool
      public let size: Int
      private let Metadata: [MediaItem]?

      public var metadata: [MediaItem] {
          Metadata ?? []
      }
  }
}
