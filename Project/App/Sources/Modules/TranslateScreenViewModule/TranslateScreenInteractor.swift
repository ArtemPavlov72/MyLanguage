//
//  TranslateScreenInteractor.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 19.05.2023.
//

import UIKit

/// События которые отправляем из Interactor в Presenter
protocol TranslateScreenInteractorOutput: AnyObject {}

/// События которые отправляем от Presenter к Interactor
protocol TranslateScreenInteractorInput {}

/// Интерактор
final class TranslateScreenInteractor: TranslateScreenInteractorInput {


  
  // MARK: - Internal properties
  
  weak var output: TranslateScreenInteractorOutput?
  
  // MARK: - Internal func

}

// MARK: - Private

private extension TranslateScreenInteractor {}

// MARK: - Appearance

private extension TranslateScreenInteractor {
  struct Appearance {}
}
