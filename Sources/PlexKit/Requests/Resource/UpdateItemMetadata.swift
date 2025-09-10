//
//  UpdateItemMetadata.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 25/04/2025.
//

import Foundation

public extension Plex.Request {
    struct UpdateItemMetadata: PlexResourceRequest {
        public var path: String { "/library/metadata/\(ratingKey)" }
      
      public var httpMethod: String {"PUT"}
      
      private let ratingKey: String

        public var queryItems: [URLQueryItem]?
      
      

        public init(
          ratingKey: String,
          fields: [PlexFieldQueryItem]
        ) {
            self.ratingKey = ratingKey
          self.queryItems = []
          for field in fields {
              let queryItem = URLQueryItem(name: field.queryKey, value: field.queryValue)
            self.queryItems?.append(queryItem)
          }
        }

      public static func response(from data: Data) throws -> Void {
              // Do nothing – just validate response exists
              return ()
          }
    }
}

public extension Plex.Request.UpdateItemMetadata {
  public enum PlexFieldQueryItem {
      case title(String)
      case titleLocked(Bool)

      case sortTitle(String)
      case sortTitleLocked(Bool)

      case originalTitle(String)
      case originalTitleLocked(Bool)

      case tagline(String)
      case taglineLocked(Bool)

      case summary(String)
      case summaryLocked(Bool)

      case studio(String)
      case studioLocked(Bool)

      case contentRating(String)
      case contentRatingLocked(Bool)

      case originallyAvailableAt(String) // Use String like "YYYY-MM-DD"
      case originallyAvailableAtLocked(Bool)

      case userRating(String)
      
      case editionTitle(String)
      case editionTitleLocked(Bool)

      case directorLocked(Bool)
      case countryLocked(Bool)
      case genreLocked(Bool)
      case writerLocked(Bool)
      case producerLocked(Bool)
      case collectionLocked(Bool)
      case labelLocked(Bool)

      var queryKey: String {
          switch self {
          case .title: return "title.value"
          case .titleLocked: return "title.locked"

          case .sortTitle: return "titleSort.value"
          case .sortTitleLocked: return "titleSort.locked"

          case .originalTitle: return "originalTitle.value"
          case .originalTitleLocked: return "originalTitle.locked"

          case .tagline: return "tagline.value"
          case .taglineLocked: return "tagline.locked"

          case .summary: return "summary.value"
          case .summaryLocked: return "summary.locked"

          case .studio: return "studio.value"
          case .studioLocked: return "studio.locked"

          case .contentRating: return "contentRating.value"
          case .contentRatingLocked: return "contentRating.locked"

          case .originallyAvailableAt: return "originallyAvailableAt.value"
          case .originallyAvailableAtLocked: return "originallyAvailableAt.locked"

          case .userRating: return "userRating.value"

          case .editionTitle: return "editionTitle.value"
          case .editionTitleLocked: return "editionTitle.locked"

          case .directorLocked: return "director.locked"
          case .countryLocked: return "country.locked"
          case .genreLocked: return "genre.locked"
          case .writerLocked: return "writer.locked"
          case .producerLocked: return "producer.locked"
          case .collectionLocked: return "collection.locked"
          case .labelLocked: return "label.locked"
          }
      }

      var queryValue: String {
          switch self {
          case .title(let val),
               .sortTitle(let val),
               .originalTitle(let val),
               .tagline(let val),
               .summary(let val),
               .studio(let val),
               .contentRating(let val),
               .originallyAvailableAt(let val),
               .userRating(let val),
               .editionTitle(let val):
              return val

          case .titleLocked(let locked),
               .sortTitleLocked(let locked),
               .originalTitleLocked(let locked),
               .taglineLocked(let locked),
               .summaryLocked(let locked),
               .studioLocked(let locked),
               .contentRatingLocked(let locked),
               .originallyAvailableAtLocked(let locked),
               .editionTitleLocked(let locked),
               .directorLocked(let locked),
               .countryLocked(let locked),
               .genreLocked(let locked),
               .writerLocked(let locked),
               .producerLocked(let locked),
               .collectionLocked(let locked),
               .labelLocked(let locked):
              return locked ? "1" : "0"
          }
      }
  }

}
