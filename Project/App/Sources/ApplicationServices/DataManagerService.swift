//
//  DataManagerService.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 12.06.2023.
//

import Foundation

class DataManagerService {

  static let shared = DataManagerService()

  private init() {}

  let mockDictionaryVB: [String: String] = [
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
