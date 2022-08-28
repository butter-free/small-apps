//
//  UserInfoRepository.swift
//  TCA
//
//  Created by sean on 2022/05/14.
//  Copyright © 2022 butterfree. All rights reserved.
//

import Combine
import Foundation

public protocol UserInfoRepository {
  func requestUserInfo(accessToken: String) -> AnyPublisher<UserInfo, URLError>
}
