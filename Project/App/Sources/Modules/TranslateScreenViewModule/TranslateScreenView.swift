//
//  TranslateScreenView.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 19.05.2023.
//

import UIKit

/// События которые отправляем из View в Presenter
protocol TranslateScreenViewOutput: AnyObject {

  /// Было нажатие на кнопку ответить
  func answerButtonAction()

}

/// События которые отправляем от Presenter ко View
protocol TranslateScreenViewInput {}

/// Псевдоним протокола UIView & TranslateScreenViewInput
typealias TranslateScreenViewProtocol = UIView & TranslateScreenViewInput

/// View для экрана
final class TranslateScreenView: TranslateScreenViewProtocol {
  
  // MARK: - Internal properties
  
  weak var output: TranslateScreenViewOutput?
  
  // MARK: - Private properties

  private let questionLabel = UILabel()
  private let textQuestionLabel = UILabel()
  private let answerStackView = UIStackView()
  private let answerLabel = UILabel()
  private let answerTextField = UITextField()
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

private extension TranslateScreenView {
  func configureLayout() {
    let appearance = Appearance()

    [answerLabel, answerTextField].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      answerStackView.addArrangedSubview($0)
    }

    [questionLabel, textQuestionLabel, answerStackView, answerButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    answerStackView.axis = .vertical
    answerStackView.distribution = .fillEqually
    answerStackView.spacing = appearance.defaultInset

    NSLayoutConstraint.activate([
      questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                             constant: appearance.defaultInset),
      questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                              constant: -appearance.defaultInset),
      questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: appearance.defaultInset),

      textQuestionLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: appearance.defaultInset),
      textQuestionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                  constant: -appearance.defaultInset),
      textQuestionLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: appearance.defaultInset),

      answerStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: appearance.defaultInset),
      answerStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -appearance.defaultInset),
      answerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      answerStackView.centerYAnchor.constraint(equalTo: centerYAnchor),

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

    backgroundColor = .systemBackground
    
    answerButton.setTitle(appearance.buttonTitle, for: .normal)
    answerButton.backgroundColor = appearance.buttonColor
    answerTextField.placeholder = appearance.answerPlaceholderText
    questionLabel.text = appearance.labelText
    answerLabel.text = appearance.answerLabelText
  }
}

// MARK: - UITextFieldDelegate

extension TranslateScreenView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - Appearance

private extension TranslateScreenView {
  struct Appearance {
    let defaultInset: CGFloat = 16
    let labelText = "Вопрос"
    let answerLabelText = "Ответ"
    let answerPlaceholderText = "Введите ответ"
    let buttonTitle = "Ответить"
    let buttonColor: UIColor = .gray
  }
}
