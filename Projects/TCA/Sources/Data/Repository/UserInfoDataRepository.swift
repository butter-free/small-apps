//
//  UserInfoDataRepository.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Combine
import Foundation

class UserInfoDataRepository: UserInfoRepository {
  
  let apiService: ApiService
  
  init(apiService: ApiService = ApiManager.shared) {
    self.apiService = apiService
  }
}

extension UserInfoDataRepository {
  func requestUserInfo(accessToken: String) -> AnyPublisher<UserInfo, URLError> {
    return apiService.request(
      endPoint: .init(path: .userInfo(accessToken))
    )
    .map { (data: UserInfo) in
      return data
    }.eraseToAnyPublisher()
  }
}
