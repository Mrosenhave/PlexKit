//
//  Scrobble.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 20/07/2025.
//

import Foundation

public extension Plex.Request {
    struct Scrobble: PlexResourceRequest {
        public var path: String { "/:/scrobble" }

      public var queryItems: [URLQueryItem]? {
        [
          .init(name: "key", value: ratingKey),
          .init(name: "identifier", value: "com.plexapp.plugins.library")
        ]
      }
      
      private let ratingKey: String

        public init(
          ratingKey: String,
        ) {
          self.ratingKey = ratingKey
        }

      public static func response(from data: Data) throws -> Void {
              // Do nothing – just validate response exists
              return ()
          }
    }
}
