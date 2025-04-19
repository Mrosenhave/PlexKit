//
//  RecentlyAdded.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 17/04/2025.
//


import Foundation

public extension Plex.Request {
    /// Fetch recently added PlexMediaItem  for a `PlexMediaType`.
    
    typealias RecentlyAdded = _RecentlyAdded<PlexMediaItem>
    
    struct _RecentlyAdded<MediaItem: PlexMediaItemType>: PlexResourceRequest {
        public var path: String { "hubs/home/recentlyAdded" }
        public var queryItems: [URLQueryItem]? {
            [
              .init(name: "type", value: type.key),
                .init(name: "X-Plex-Container-Size", value: count),
                .init(name: "X-Plex-Container-Start", value: offset)
              ]
        }

        /// - SeeAlso: `ratingKey` property of `MediaItem`.

        private let type: PlexMediaType

        private let count: Int
        private let offset: Int

        public init(
          type: Int,
            count: Int = 25,
            offset: Int = 0
        ) {
            self.type = type
            self.count = count
            self.offset = offset
        }

        public struct Response: Codable {
            public let mediaContainer: MediaContainer
        }
    }
}

public extension Plex.Request._RecentlyAdded.Response {
    enum CodingKeys: String, CodingKey {
        case mediaContainer = "MediaContainer"
    }

    struct MediaContainer: Codable {
        public let size: Int
        public let allowSync: Bool?
        public let augmentationKey: String?
        public let identifier: String?
        public let librarySectionID: Int?
        public let librarySectionTitle: String?
        public let librarySectionUUID: String?
        public let mediaTagPrefix: String?
        public let mediaTagVersion: Int?

        private let Metadata: [PlexMediaItem]?

        public var metadata: [PlexMediaItem] {
          Metadata ?? []
        }
    }
    
}
