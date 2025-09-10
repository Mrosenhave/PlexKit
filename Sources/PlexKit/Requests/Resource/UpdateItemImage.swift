//
//  UpdateItemImage.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 23/04/2025.
//


import Foundation

public extension Plex.Request {
    struct UpdateItemImage: PlexResourceRequest {
        public var path: String { "/library/metadata/\(ratingKey)/\(imageKey)" }
      
      public var httpMethod: String {"PUT"}
      
      private let ratingKey: String
      private let imageType: PlexImageType
      private var imageKey: String {
        switch imageType {
        case .coverPoster, .snapshot:
          "poster"
        case .background:
          "art"
        case .clearLogo:
          "clearLogo"
        }
      }
      private var imageRatingKey: String

        public var queryItems: [URLQueryItem]?

        public init(
          ratingKey: String,
          imageType: PlexImageType,
          imageRatingKey: String
        ) {
            self.ratingKey = ratingKey
            self.imageType = imageType
            self.imageRatingKey = imageRatingKey
          self.queryItems = [
            .init(name: "url", value: imageRatingKey)
          ]
        }

      public static func response(from data: Data) throws -> String {
          guard let string = String(data: data, encoding: .utf8) else {
              throw URLError(.cannotDecodeRawData)
          }
          return string
      }
    }
}
