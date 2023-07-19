//
//  TranslateScreenFactory.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 19.05.2023.
//

import UIKit

/// Cобытия которые отправляем из Factory в Presenter
protocol TranslateScreenFactoryOutput: AnyObject {}

/// Cобытия которые отправляем от Presenter к Factory
protocol TranslateScreenFactoryInput {}

/// Фабрика
final class TranslateScreenFactory: TranslateScreenFactoryInput {
  
  // MARK: - Internal properties
  
  weak var output: TranslateScreenFactoryOutput?
  
  // MARK: - Internal func
}

// MARK: - Appearance

private extension TranslateScreenFactory {
  struct Appearance {}
}
