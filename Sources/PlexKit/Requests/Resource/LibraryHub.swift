//
//  LibraryHub.swift
//  PlexMusicMac
//
//  Created by Markus Rosenhave on 09/09/2024.
//

import Foundation


public extension Plex.Request {
    /// Fetch children for a `PlexMediaItem`.
    
    typealias LibraryHub = _LibraryHub<PlexMediaItem>
    
    struct _LibraryHub<MediaItem: PlexMediaItemType>: PlexResourceRequest {
        public var path: String { "hubs/sections/\(key)" }
        public var queryItems: [URLQueryItem]? {
            [
                .init(name: "count", value: count),
                .init(name: "includeCollections", value: includeCollections),
                .init(name: "includeExternalMedia", value: includeExternalMedia),
                .init(name: "includeExternalMetadata", value: includeExternalMetadata),
                .init(name: "includeLibraryPlaylists", value: includeLibraryPlaylists),
                .init(name: "includeMeta", value: includeMeta),
                .init(name: "includeRecentChannels", value: includeRecentChannels),
                .init(name: "includeRelated", value: includeRelated),
                .init(name: "includeStations", value: includeStations),
                .init(name: "includeTrailers", value: includeTrailers),
                .init(name: "includeTypeFirst", value: includeTypeFirst),
            ]
        }

        /// - SeeAlso: `ratingKey` property of `MediaItem`.

        private let key: String

        private let count: Int
        private let includeCollections: Bool
        private let includeExternalMedia: Bool
        private let includeExternalMetadata: Bool
        private let includeLibraryPlaylists: Bool
        private let includeMeta: Bool
        private let includeRecentChannels: Bool
        private let includeRelated: Bool
        private let includeStations: Bool
        private let includeTrailers: Bool
        private let includeTypeFirst: Bool

        public init(
            key: String,
            count: Int = 25,
            includeCollections: Bool = true,
            includeExternalMedia: Bool = true,
            includeExternalMetadata: Bool = true,
            includeLibraryPlaylists: Bool = false,
            includeMeta: Bool = true,
            includeRecentChannels: Bool = true,
            includeRelated: Bool = true,
            includeStations: Bool = false,
            includeTrailers: Bool = true,
            includeTypeFirst: Bool = true
        ) {
            self.key = key
            self.count = count
            self.includeCollections = includeCollections
            self.includeExternalMedia = includeExternalMedia
            self.includeExternalMetadata = includeExternalMetadata
            self.includeLibraryPlaylists = includeLibraryPlaylists
            self.includeMeta = includeMeta
            self.includeRecentChannels = includeRecentChannels
            self.includeRelated = includeRelated
            self.includeStations = includeStations
            self.includeTrailers = includeTrailers
            self.includeTypeFirst = includeTypeFirst
        }

        public struct Response: Codable {
            public let mediaContainer: MediaContainer
        }
    }
}

public extension Plex.Request._LibraryHub.Response {
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

        private let Hub: [Hub]?

        public var hub: [Hub] {
            Hub ?? []
        }
    }
    struct Hub: Codable {
        let hubKey, key: String?
        let title, type: String
        private let Metadata: [MediaItem]?

        public var metadata: [MediaItem] {
            Metadata ?? []
        }
    }
    
}
