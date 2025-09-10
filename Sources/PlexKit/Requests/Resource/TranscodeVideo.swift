//
//  TranscodeVideo.swift
//  PlexKit
//
//  Created by Markus Rosenhave on 28/04/2025.
//



import Foundation

public extension Plex.Request {
    /// - Note: Not designed to be consumed for anything other than playback (e.g. via AVPlayer).
    struct TranscodeVideo: PlexResourceRequest {
        public let path = "video/:/transcode/universal/start.m3u8"
        public let accept = "*/*"

        public var queryItems: [URLQueryItem]? {
            var items: [URLQueryItem] = [
                .init(name: "path", value: "/library/metadata/\(ratingKey)"),
                .init(name: "mediaIndex", value: 0),
                .init(name: "partIndex", value: 0),
                .init(name: "directStream", value: !autoAdjustQuality),
                .init(name: "mediaBufferSize", value: mediaBufferSize),
                .init(name: "session", value: UUID().uuidString), // Always(?) create a new transcode session.
                .init(name: "autoAdjustQuality", value: autoAdjustQuality),
                .init(name: "protocol", value: `protocol`),
                .init(name: "directPlay", value: false),
                .init(name: "hasMDE", value: true),
                .init(name: "X-Plex-Platform", value: "iOS"),
                .init(name: "X-Plex-Client-Identifier", value: clientIdentifier),
                .init(name: "X-Plex-Token", value: token),
            ]


            // Add client info as URL params.
//            for (key, value) in clientInfo.asMap() {
//                items.append(URLQueryItem(name: key.rawValue, value: value))
//            }

            return items
        }

        /// The id of the track.
        /// - SeeAlso: `ratingKey` property of `MediaItem.Part`.
        private let ratingKey: String

        /// The playback session ID.
        /// This is used by the server to relate a transcode session to the timeline item.
        /// - SeeAlso: `session` property of `Timeline` request.
        private let session: UUID

      
        private let autoAdjustQuality: Bool

        /// Default value taken from plex web.
        private let mediaBufferSize: Int

        /// The streaming protocol to use. Known supported values: `hls`, `dash`.
        /// - Warning: Everything other than 'hls' has not been tested.
        private let `protocol` = "hls"

        /// Client info to add as URL parameters.
      private let clientIdentifier: String
      private let token: String

        public init(
            ratingKey: String,
            session: UUID,
            autoAdjustQuality: Bool,
            mediaBufferSize: Int = 12288,
            clientIdentifier: String,
            token: String
        ) {
            self.ratingKey = ratingKey
            self.session = session
            self.autoAdjustQuality = autoAdjustQuality
            self.mediaBufferSize = mediaBufferSize
            self.clientIdentifier = clientIdentifier
            self.token = token
        }

//        public func asURLRequest(from url: URL) throws -> URLRequest {
//            guard let token = clientInfo.token else {
//                throw PlexError.notAuthenticated
//            }
//            return try asURLRequest(from: url, using: token)
//        }

        public static func response(from data: Data) throws -> Data {
            data
        }

        /// The HLS index (m3u8), left for the client to decode.
        public typealias Response = Data
    }
}
