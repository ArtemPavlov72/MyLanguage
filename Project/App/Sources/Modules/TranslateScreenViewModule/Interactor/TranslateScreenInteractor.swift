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

  func getRightAnswer(_ text: String?)

  func getWrongAnswer(_ text: String?)
}

/// События которые отправляем от Presenter к Interactor
protocol TranslateScreenInteractorInput {

  /// Получить слова для перевода
  func getContent()

  /// Пользователь нажал на кнопку ответа
  func translateButtonAction(with answerWord: String, translation: String?)
}

/// Интерактор
final class TranslateScreenInteractor: TranslateScreenInteractorInput {

  // MARK: - Internal properties
  
  weak var output: TranslateScreenInteractorOutput?

  // MARK: - Private property

  private var cashedWords: [TranslateWordModel] = []
  private var rightCount = 0
  private var wrongCount = 0
  
  // MARK: - Internal func

  func getContent() {
    cashedWords = DataManagerService.shared.getMockWordsForTranslate().shuffled()
    getWordForTranslation()
  }

  func translateButtonAction(with answerWord: String, translation: String?) {
    let correctTranslation = cashedWords.filter { $0.word == answerWord }.first?.translation

    cashedWords.removeLast()

    if correctTranslation == translation {
      rightCount += 1
      output?.getRightAnswer("Верно: \(rightCount)")
    } else {
      wrongCount += 1
      output?.getWrongAnswer("Не верно: \(wrongCount)")
    }
    getWordForTranslation()
  }
}

// MARK: - Private

private extension TranslateScreenInteractor {
  func getWordForTranslation() {
    output?.didReceive(cashedWords.last?.word)
  }
}

// MARK: - Appearance

private extension TranslateScreenInteractor {
  struct Appearance {}
}
