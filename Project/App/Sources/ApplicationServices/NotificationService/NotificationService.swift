//
//  NotificationService.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 21.07.2023.
//

import UIKit

protocol NotificationService {

  /// Показать уведомление
  ///  - Parameters:
  ///   - viewController: где показываем
  ///   - title: Заголовок уведомления
  ///   - massage: Сообщение уведомления
  func showAlert(in viewController: UIViewController, with title: String, and massage: String)

}

final class NotificationServiceImpl: NotificationService {

  func showAlert(in viewController: UIViewController, with title: String, and massage: String) {
    let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    alert.addAction(okAction)
    viewController.present(alert, animated: true)
  }
}
