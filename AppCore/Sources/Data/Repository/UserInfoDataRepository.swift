//
//  UserInfoDataRepository.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Combine
import Foundation

public final class UserInfoDataRepository: UserInfoRepository {
  
  let apiService: ApiService
  
  public init(apiService: ApiService = ApiManager.shared) {
    self.apiService = apiService
  }
}

extension UserInfoDataRepository {
  public func requestUserInfo(accessToken: String) -> AnyPublisher<UserInfo, URLError> {
    return apiService.request(
      endPoint: .init(path: .userInfo(accessToken))
    )
    .map { (data: UserInfo) in
      return data
    }.eraseToAnyPublisher()
  }
}
