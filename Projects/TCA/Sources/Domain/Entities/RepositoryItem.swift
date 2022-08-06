//
//  RepositoryItem.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

struct RepositoryItem: Identifiable, Equatable, Codable {
  let id: Int
  let repositoryName: String
  let description: String
  let language: String
  let owner: Owner
  let url: String
  var updatedDate: String
  let numberOfStars: Int
  var isStarred: Bool = false
  
  init(from decoder: Decoder) throws {
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
  init(
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

struct Owner: Equatable, Codable {
  let name: String
  let thumbnailURLString: String
  
  init(from decoder: Decoder) throws {
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
  init(name: String = "", thumbnailURLString: String = "") {
    self.name = name
    self.thumbnailURLString = thumbnailURLString
  }
}
