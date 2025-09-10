//
//  PlexFieldType.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 25/04/2025.
//

import Foundation

public enum PlexFieldType: Codable, Hashable, Equatable {
  case title
  case titleSort
  case originalTitle
  case studio
  case tagline
  case summary
  case contentRating
  case thumb
  case art
  case originallyAvailableAt
  case year
  case genre
  case collection
  case label
  case editionTitle
  case unknown(String)
}

extension PlexFieldType: RawRepresentable {
  public init?(rawValue: String) {
      switch rawValue {
      case "title": self = .title
      case "titleSort": self = .titleSort
      case "originalTitle": self = .originalTitle
      case "studio": self = .studio
      case "tagline": self = .tagline
      case "summary": self = .summary
      case "contentRating": self = .contentRating
      case "thumb": self = .thumb
      case "art": self = .art
      case "originallyAvailableAt": self = .originallyAvailableAt
      case "year": self = .year
      case "genre": self = .genre
      case "collection": self = .collection
      case "label": self = .label
      case "editionTitle": self = .editionTitle
      default: self = .unknown(rawValue)
      }
  }

  public var rawValue: String {
      switch self {
      case .title: return "title"
      case .titleSort: return "titleSort"
      case .originalTitle: return "originalTitle"
      case .studio: return "studio"
      case .tagline: return "tagline"
      case .summary: return "summary"
      case .contentRating: return "contentRating"
      case .thumb: return "thumb"
      case .art: return "art"
      case .originallyAvailableAt: return "originallyAvailableAt"
      case .year: return "year"
      case .genre: return "genre"
      case .collection: return "collection"
      case .label: return "label"
      case .editionTitle: return "editionTitle"
      case .unknown(let value): return value
      }
  }
}
