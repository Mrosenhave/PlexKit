//
//  RefreshItemMetadata.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 11/07/2025.
//


import Foundation

public extension Plex.Request {
    struct RefreshItemMetadata: PlexResourceRequest {
        public var path: String { "/library/metadata/\(ratingKey)/refresh" }
      
      public var httpMethod: String {"PUT"}
      
      private let ratingKey: String

      public var queryItems: [URLQueryItem] {[URLQueryItem]()}
      
      

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
