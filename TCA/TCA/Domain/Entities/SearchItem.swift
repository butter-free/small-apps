//
//  SearchItem.swift
//  TCA
//
//  Created by sean on 2022/04/21.
//

import Foundation

struct SearchItem: Identifiable, Decodable {
  let id: Int
//  let thumbnailURLString: String
  let repositoryName: String
  let repositoryURLString: String
  let description: String
  let language: String
  let updatedDate: String
  let countOfStars: Int
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id =                  try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
    self.repositoryName =      try container.decodeIfPresent(String.self, forKey: .repositoryName) ?? ""
    self.repositoryURLString = try container.decodeIfPresent(String.self, forKey: .repositoryURLString) ?? ""
    self.description =         try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    self.language =            try container.decodeIfPresent(String.self, forKey: .language) ?? ""
    self.updatedDate =         try container.decodeIfPresent(String.self, forKey: .updatedDate) ?? ""
    self.countOfStars =        try container.decodeIfPresent(Int.self, forKey: .countOfStars) ?? -1
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case repositoryName = "name"
    case repositoryURLString = "html_url"
    case description
    case language
    case updatedDate = "updated_at"
    case countOfStars = "stargazers_count"
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
    countOfStars: Int = 0
  ) {
    self.id = id
//    self.thumbnailURLString = thumbnailURLString
    self.repositoryName = repositoryName
    self.repositoryURLString = repositoryURLString
    self.description = description
    self.language = language
    self.updatedDate = updatedDate
    self.countOfStars = countOfStars
  }
}
