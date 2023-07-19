//
//  TranslateScreenInteractor.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 19.05.2023.
//

import UIKit

/// События которые отправляем из Interactor в Presenter
protocol TranslateScreenInteractorOutput: AnyObject {

  /// Были получены данные
  ///  - Parameter text: Текст со словом для перевода
  func didReceive(_ word: String?)

  /// Что-то пошло не так
  func somethingWentWrong()
}

/// События которые отправляем от Presenter к Interactor
protocol TranslateScreenInteractorInput {

  func getContent()

  func translateButtonAction()
}

/// Интерактор
final class TranslateScreenInteractor: TranslateScreenInteractorInput {

  // MARK: - Internal properties
  
  weak var output: TranslateScreenInteractorOutput?

  // MARK: - Private property

  private var cashedWords: [TranslateWordModel] = []
  
  // MARK: - Internal func

  func getContent() {
    cashedWords = DataManagerService.shared.getMockWordsForTranslate()
    getWordForTranslation()
  }

  func translateButtonAction() {
    
  }
}

// MARK: - Private

private extension TranslateScreenInteractor {
  func getWordForTranslation() {
    let wordForTranslate = cashedWords.randomElement()?.word ?? ""
    output?.didReceive(wordForTranslate)
  }

}

// MARK: - Appearance

private extension TranslateScreenInteractor {
  struct Appearance {}
}
