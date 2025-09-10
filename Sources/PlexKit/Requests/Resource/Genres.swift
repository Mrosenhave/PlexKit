//
//  Genres.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 18/07/2025.
//


import Foundation

public extension Plex.Request {
    struct Genres: PlexResourceRequest {
      public var path: String

        public init(
          libraryKey: String
        ) {
          self.path = "library/sections/\(libraryKey)/genre"
        }

        public struct Response: Codable {
            public let mediaContainer: MediaContainer
        }
    }
}

public extension Plex.Request.Genres.Response {
    enum CodingKeys: String, CodingKey {
        case mediaContainer = "MediaContainer"
    }

    struct MediaContainer: Codable {
        public let size: Int
        public let allowSync: Bool?
        public let identifier: String?
        public let mediaTagPrefix: String?
        public let mediaTagVersion: Int?
        public let title1: String?
        private let Directory: [Genre]?
        public var directory: [Genre] { Directory ?? [] }
    }
  struct Genre: Codable {
    public let fastKey, key, title: String
  }
}
