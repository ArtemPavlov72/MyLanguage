//
//  MainScreenFactory.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 19.05.2023.
//

import UIKit

/// Cобытия которые отправляем из Factory в Presenter
protocol MainScreenFactoryOutput: AnyObject {}

/// Cобытия которые отправляем от Presenter к Factory
protocol MainScreenFactoryInput {}

/// Фабрика
final class MainScreenFactory: MainScreenFactoryInput {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenFactoryOutput?
  
  // MARK: - Internal func
}

// MARK: - Appearance

private extension MainScreenFactory {
  struct Appearance {}
}
