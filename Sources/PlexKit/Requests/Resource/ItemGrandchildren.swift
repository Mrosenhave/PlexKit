//
//  ItemGrandchildren.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 19/04/2025.
//


//
//  ItemChildren.swift
//
//
//  Created by Markus Rosenhave on 05/09/2024.
//

import Foundation

public extension Plex.Request {
    /// Fetch children for a `PlexMediaItem`.
    
    typealias ItemGrandchildren = _ItemGrandchildren<PlexMediaItem>
    
    struct _ItemGrandchildren<MediaItem: PlexMediaItemType>: PlexResourceRequest {
        public var path: String { "library/metadata/\(ratingKey)/grandchildren" }
        
        
        private let ratingKey: String
        
        
        public init(
            ratingKey: String
        ) {
            self.ratingKey = ratingKey
        }
        
        public struct Response: Codable {
            public let mediaContainer: MediaContainer
        }
    }
}

public extension Plex.Request._ItemGrandchildren.Response {
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

        private let Metadata: [MediaItem]?

        public var metadata: [MediaItem] {
            Metadata ?? []
        }
    }
}
