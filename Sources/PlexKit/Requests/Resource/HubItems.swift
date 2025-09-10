//
//  HubItems.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 17/07/2025.
//


import Foundation

public extension Plex.Request {
  // fetches the home page content
    typealias HubItems = _HubItems<PlexMediaItem>

    struct _HubItems<MediaItem: PlexMediaItemType>: PlexResourceRequest {
        public var path: String
        public var queryItems: [URLQueryItem]?
      

        public init(
          key: String,
        ) {
          self.path = key
          let safeInput = "https://example.com" + key
          if let components = URLComponents(string: safeInput) {
            self.path = components.path
            self.queryItems = components.queryItems ?? []
            print(path, queryItems)
          }
          self.queryItems?.append(contentsOf: [
            .init(name: "includeMeta", value: false)
        ])
        }

        public struct Response: Codable {
            public let mediaContainer: MediaContainer
          
          enum CodingKeys: String, CodingKey {
              case mediaContainer = "MediaContainer"
          }
        }
    }
}

public extension Plex.Request._HubItems {
    struct MediaContainer: Codable {
        public let size: Int
      private let Meta: [MediaItem]?

      public var meta: [MediaItem] {
          Meta ?? []
      }
      private let Metadata: [MediaItem]?

      public var metadata: [MediaItem] {
          Metadata ?? []
      }
  }
  
  struct Meta: Codable {
      public let type: [TypeElement]

      enum CodingKeys: String, CodingKey {
          case type = "Type"
      }
  }
  
  struct TypeElement: Codable {
      let key, type, title: String
      let active: Bool
  }
}
