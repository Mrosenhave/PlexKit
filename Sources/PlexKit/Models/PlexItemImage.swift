//
//  PlexItemImage.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 23/04/2025.
//


import Foundation

public struct PlexItemImage: Codable, Hashable {
  public let key: String
  public let ratingKey: String
  public let thumb: String
  public var selected: Bool
  public let provider: String?
}
