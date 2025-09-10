//
//  PlexImageType.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 21/04/2025.
//

import Foundation

public enum PlexImageType: String, Codable,  Hashable {
    case coverPoster
    case snapshot
    case background
    case clearLogo
  
  public func title() -> String {
    switch self {
    case .coverPoster:
      "Poster"
    case .snapshot:
      "Snapshot"
    case .background:
      "Background"
    case .clearLogo:
      "Logo"
    }
  }
}
