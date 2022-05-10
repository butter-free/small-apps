//
//  SearchItem.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Foundation

struct SearchItem: Identifiable, Equatable, Decodable {
  let id: Int
  let owner: Owner
  let repositoryName: String
  let repositoryURLString: String
  let description: String
  let language: String
  var updatedDate: String
  let numberOfStars: Int
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id =                  try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
    self.owner =               try container.decodeIfPresent(Owner.self, forKey: .owner) ?? .init()
    self.repositoryName =      try container.decodeIfPresent(String.self, forKey: .repositoryName) ?? ""
    self.repositoryURLString = try container.decodeIfPresent(String.self, forKey: .repositoryURLString) ?? ""
    self.description =         try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    self.language =            try container.decodeIfPresent(String.self, forKey: .language) ?? ""
    self.updatedDate =         try container.decodeIfPresent(String.self, forKey: .updatedDate) ?? ""
    self.numberOfStars =       try container.decodeIfPresent(Int.self, forKey: .numberOfStars) ?? -1
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case owner
    case repositoryName = "name"
    case repositoryURLString = "html_url"
    case description
    case language
    case updatedDate = "updated_at"
    case numberOfStars = "stargazers_count"
  }
}

extension SearchItem {
  internal init(
    id: Int = 0,
    thumbnailURLString: String = "",
    repositoryName: String = "",
    repositoryURLString: String = "",
    description: String = "",
    language: String = "",
    updatedDate: String = "",
    numberOfStars: Int = 0
  ) {
    self.id = id
    self.owner = .init(thumbnailURLString: thumbnailURLString)
    self.repositoryName = repositoryName
    self.repositoryURLString = repositoryURLString
    self.description = description
    self.language = language
    self.updatedDate = updatedDate
    self.numberOfStars = numberOfStars
  }
}

struct Owner: Equatable, Decodable {
  
  let thumbnailURLString: String
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.thumbnailURLString = try container.decodeIfPresent(String.self, forKey: .thumbnailURLString) ?? ""
  }
  
  enum CodingKeys: String, CodingKey {
    case thumbnailURLString = "avatar_url"
  }
}

extension Owner {
  internal init(thumbnailURLString: String = "") {
    self.thumbnailURLString = thumbnailURLString
  }
}
