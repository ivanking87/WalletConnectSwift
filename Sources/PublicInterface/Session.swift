//
//  Copyright © 2019 Gnosis Ltd. All rights reserved.
//

import Foundation

/// Each session is a communication channel between dApp and Wallet on dAppInfo.peerId topic
public struct Session: Codable {
    // TODO: handle protocol version
    public let url: WCURL
    public let dAppInfo: DAppInfo
    public var walletInfo: WalletInfo?

    public init(url: WCURL, dAppInfo: DAppInfo, walletInfo: WalletInfo?) {
        self.url = url
        self.dAppInfo = dAppInfo
        self.walletInfo = walletInfo
    }

    public struct DAppInfo: Codable, Equatable {
        public let peerId: String
        public let peerMeta: ClientMeta
        public let chainId: Int?
        public let approved: Bool?

        public init(peerId: String, peerMeta: ClientMeta, chainId: Int? = nil, approved: Bool? = nil) {
            self.peerId = peerId
            self.peerMeta = peerMeta
            self.chainId = chainId
            self.approved = approved
        }

        func with(approved: Bool) -> DAppInfo {
            return DAppInfo(peerId: self.peerId,
                            peerMeta: self.peerMeta,
                            chainId: self.chainId,
                            approved: approved)
        }
    }

    public struct ClientMeta: Codable, Equatable {
        public let name: String?
        public let description: String?
        public let icons: [URL]
        public let url: URL
        public let scheme: String?

        public init(name: String?, description: String?, icons: [URL], url: URL, scheme: String? = nil) {
            self.name = name
            self.description = description
            self.icons = icons
            self.url = url
            self.scheme = scheme
        }
        
        
        enum CodingKeys: String, CodingKey {
            case name
            case description
            case icons
            case url
            case scheme
            
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            description = try container.decodeIfPresent(String.self, forKey: .description)
            icons = try container.decodeIfPresent([URL].self, forKey: .icons) ?? []
            url = try container.decodeIfPresent(URL.self, forKey: .url) ?? URL(string: "https://nftst.net")!
            scheme = try container.decodeIfPresent(String.self, forKey: .scheme)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(name, forKey: .name)
            try container.encodeIfPresent(description, forKey: .description)
            try container.encodeIfPresent(icons, forKey: .icons)
            try container.encodeIfPresent(url, forKey: .url)
            try container.encodeIfPresent(scheme, forKey: .scheme)
        }
    }

    public struct WalletInfo: Codable, Equatable {
        public let approved: Bool
        public let accounts: [String]
        public let chainId: Int
        public let peerId: String
        public let peerMeta: ClientMeta

        public init(approved: Bool, accounts: [String], chainId: Int, peerId: String, peerMeta: ClientMeta) {
            self.approved = approved
            self.accounts = accounts
            self.chainId = chainId
            self.peerId = peerId
            self.peerMeta = peerMeta
        }

        public func with(approved: Bool) -> WalletInfo {
            return WalletInfo(approved: approved,
                              accounts: self.accounts,
                              chainId: self.chainId,
                              peerId: self.peerId,
                              peerMeta: self.peerMeta)
        }
    }
}
