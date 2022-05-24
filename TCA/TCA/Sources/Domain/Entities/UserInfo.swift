//
//  UserInfo.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Foundation

class UserInfo: NSObject, Codable, NSCoding {
  
  let id: Int
  let name: String
  let thumbnail: String
  let email: String
  let bio: String
  let followers: Int
  let following: Int
  
  init(
    id: Int = -1,
    name: String = "",
    thumbnail: String = "",
    email: String = "",
    bio: String = "",
    followers: Int = -1,
    following: Int = -1
  ) {
    self.id = id
    self.name = name
    self.thumbnail = thumbnail
    self.email = email
    self.bio = bio
    self.followers = followers
    self.following = following
    super.init()
  }
  
  required init(from decoder: Decoder) throws {
    let container =  try decoder.container(keyedBy: CodingKeys.self)
    
    self.id =        try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
    self.name =      try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    self.thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail) ?? ""
    self.email =     try container.decodeIfPresent(String.self, forKey: .email) ?? ""
    self.bio     =   try container.decodeIfPresent(String.self, forKey: .bio) ?? ""
    self.followers = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
    self.following = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encodeIfPresent(id, forKey: .id)
    try container.encodeIfPresent(name, forKey: .name)
    try container.encodeIfPresent(thumbnail, forKey: .thumbnail)
    try container.encodeIfPresent(email, forKey: .email)
    try container.encodeIfPresent(bio, forKey: .bio)
    try container.encodeIfPresent(followers, forKey: .followers)
    try container.encodeIfPresent(following, forKey: .following)
  }
  
  required init?(coder: NSCoder) {
    self.id =        coder.decodeInteger(forKey: CodingKeys.id.rawValue)
    self.name =      coder.decodeObject(forKey: CodingKeys.name.rawValue) as? String ?? ""
    self.thumbnail = coder.decodeObject(forKey: CodingKeys.thumbnail.rawValue) as? String ?? ""
    self.email =     coder.decodeObject(forKey: CodingKeys.email.rawValue) as? String ?? ""
    self.bio =       coder.decodeObject(forKey: CodingKeys.bio.rawValue) as? String ?? ""
    self.followers = coder.decodeInteger(forKey: CodingKeys.followers.rawValue)
    self.following = coder.decodeInteger(forKey: CodingKeys.following.rawValue)
  }
  
  func encode(with coder: NSCoder) {
    coder.encode(id, forKey: CodingKeys.id.rawValue)
    coder.encode(name, forKey: CodingKeys.name.rawValue)
    coder.encode(thumbnail, forKey: CodingKeys.thumbnail.rawValue)
    coder.encode(email, forKey: CodingKeys.email.rawValue)
    coder.encode(bio, forKey: CodingKeys.bio.rawValue)
    coder.encode(followers, forKey: CodingKeys.followers.rawValue)
    coder.encode(following, forKey: CodingKeys.following.rawValue)
  }
  
  enum CodingKeys: String, CodingKey {
    case name = "login"
    case id
    case thumbnail = "avatar_url"
    case email
    case bio
    case followers
    case following
  }
}
