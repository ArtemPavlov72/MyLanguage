//
//  MainScreenView.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 19.05.2023.
//

import UIKit

/// События которые отправляем из View в Presenter
protocol MainScreenViewOutput: AnyObject {

  /// Текст в текстовом поле был изменен
  /// - Parameters:
  ///  - text: Значение для текстового поля
  func answerTextDidChange(_ text: String?)

  /// Было нажатие на кнопку ответить
  func answerButtonAction()

}

/// События которые отправляем от Presenter ко View
protocol MainScreenViewInput {}

/// Псевдоним протокола UIView & MainScreenViewInput
typealias MainScreenViewProtocol = UIView & MainScreenViewInput

/// View для экрана
final class MainScreenView: MainScreenViewProtocol {
  
  // MARK: - Internal properties
  
  weak var output: MainScreenViewOutput?
  
  // MARK: - Private properties

  private let questionLabel = UILabel()
  private let answerButton = UIButton()
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    applyDefaultBehavior()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Internal func
}

// MARK: - Private

private extension MainScreenView {
  func configureLayout() {
    let appearance = Appearance()

    [questionLabel, answerButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    NSLayoutConstraint.activate([
      questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                             constant: appearance.defaultInset),
      questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                              constant: -appearance.defaultInset),
      questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: appearance.defaultInset),

      answerButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: appearance.defaultInset),
      answerButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -appearance.defaultInset),
      answerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                             constant: -appearance.defaultInset)
    ])

  }
  
  func applyDefaultBehavior() {
    let appearance = Appearance()

    backgroundColor = .gray

    answerButton.setTitle(appearance.buttonTitle, for: .normal)
    questionLabel.text = appearance.labelText
  }
}

// MARK: - Appearance

private extension MainScreenView {
  struct Appearance {
    let defaultInset: CGFloat = 16
    let labelText = "Вопрос"
    let buttonTitle = "Ответить"
  }
}
