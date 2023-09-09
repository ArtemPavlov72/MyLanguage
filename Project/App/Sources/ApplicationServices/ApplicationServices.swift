//
//  ApplicationServices.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 21.07.2023.
//

import Foundation

protocol ApplicationServices {
  
  /// Сервис по работе с уведомлениями
  var notificationService: NotificationService { get }
  
}

// MARK: - Реализация ApplicationServices

final class ApplicationServicesImpl: ApplicationServices {
  var notificationService: NotificationService {
    notificationServiceImpl
  }

  // MARK: - Private property

  let notificationServiceImpl = NotificationServiceImpl()
}
