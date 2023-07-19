//
//  QuestionsScreenAssembly.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 19.05.2023.
//

import UIKit

/// Сборщик `QuestionsScreen`
final class QuestionsScreenAssembly {
  
  /// Собирает модуль `QuestionsScreen`
  /// - Returns: Cобранный модуль `QuestionsScreen`
  func createModule() -> TranslateScreenModule {
    let interactor = TranslateScreenInteractor()
    let view = TranslateScreenView()
    let factory = TranslateScreenFactory()
    let presenter = TranslateScreenViewController(moduleView: view, interactor: interactor, factory: factory)
    
    view.output = presenter
    interactor.output = presenter
    factory.output = presenter
    return presenter
  }
}
