//
//  RepositoryItem.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

public struct RepositoryItem: Identifiable, Equatable, Codable {
  public let id: Int
  public let repositoryName: String
  public let description: String
  public let language: String
  public let owner: Owner
  public let url: String
  public var updatedDate: String
  public let numberOfStars: Int
  public var isStarred: Bool = false
  
  public init(from decoder: Decoder) throws {
    let container =       try decoder.container(keyedBy: CodingKeys.self)
    
    self.id =             try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
    self.repositoryName = try container.decodeIfPresent(String.self, forKey: .repositoryName) ?? ""
    self.description =    try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    self.language =       try container.decodeIfPresent(String.self, forKey: .language) ?? ""
    self.owner =          try container.decodeIfPresent(Owner.self, forKey: .owner) ?? .init()
    self.url =            try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    self.updatedDate =    try container.decodeIfPresent(String.self, forKey: .updatedDate) ?? ""
    self.numberOfStars =  try container.decodeIfPresent(Int.self, forKey: .numberOfStars) ?? -1
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case repositoryName = "name"
    case description
    case language
    case owner
    case url = "html_url"
    case updatedDate = "updated_at"
    case numberOfStars = "stargazers_count"
  }
}

extension RepositoryItem {
  public init(
    id: Int = -1,
    repositoryName: String = "",
    description: String = "",
    language: String = "",
    owner: Owner = .init(),
    url: String = "",
    updatedDate: String = "",
    numberOfStars: Int = -1,
    isStarred: Bool = false
  ) {
    self.id = id
    self.repositoryName = repositoryName
    self.description = description
    self.language = language
    self.owner = owner
    self.url = url
    self.updatedDate = updatedDate
    self.numberOfStars = numberOfStars
    self.isStarred = isStarred
  }
}

public struct Owner: Equatable, Codable {
  public let name: String
  public let thumbnailURLString: String
  
  public init(from decoder: Decoder) throws {
    let container =           try decoder.container(keyedBy: CodingKeys.self)

    self.name =               try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    self.thumbnailURLString = try container.decodeIfPresent(String.self, forKey: .thumbnailURLString) ?? ""
  }
  
  enum CodingKeys: String, CodingKey {
    case name = "login"
    case thumbnailURLString = "avatar_url"
  }
}

extension Owner {
  public init(name: String = "", thumbnailURLString: String = "") {
    self.name = name
    self.thumbnailURLString = thumbnailURLString
  }
}
