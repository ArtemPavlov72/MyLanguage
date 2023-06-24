//
//  DataManager.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 12.06.2023.
//

import Foundation

class DataManager {

  static let shared = DataManager()

  private init() {}

  let dictionary: [String: String] = [
    "Officiator" : "Судья",
    "Court": "Суд",
    "Solemn": "Торжественный",
    "Mention": "Упомянуть",
    "Witness": "Свидетель",
    "Entirely": "Полностью",
    "Forbidden": "Запрещенный",
    "Swear": "Ругаться",
    "Restricted": "Ограниченный",
    "Hire": "Нанимать"
  ]
}
