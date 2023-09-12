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
  func translateButtonPressed(with answerWord: String, translation: String?)
}

/// События которые отправляем от Presenter ко View
protocol TranslateScreenViewInput {

  /// Устанавливаем данные в result
  ///  - Parameter result: результат генерации
  func setWordForTranslate(_ word: String?)

  func setRightAnswerCount(_ text: String?)

  func setWrongAnswerCount(_ text: String?)
}

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

  private let rightAnswersLabel = UILabel()
  private let wrongAnswersLabel = UILabel()
  private let rightWrongStackView = UIStackView()

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

  func setWordForTranslate(_ word: String?) {
    textQuestionLabel.text = word
  }

  func setRightAnswerCount(_ text: String?) {
    rightAnswersLabel.text = text
  }

  func setWrongAnswerCount(_ text: String?) {
    wrongAnswersLabel.text = text
  }
}

// MARK: - Private

private extension TranslateScreenView {
  func configureLayout() {
    let appearance = Appearance()

    [answerLabel, answerTextField].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      answerStackView.addArrangedSubview($0)
    }

    [rightAnswersLabel, wrongAnswersLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      rightWrongStackView.addArrangedSubview($0)
    }

    [questionLabel, textQuestionLabel, answerStackView, rightWrongStackView, answerButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }

    answerStackView.axis = .vertical
    answerStackView.distribution = .fillEqually
    answerStackView.spacing = appearance.defaultInset

    rightWrongStackView.axis = .horizontal
    rightWrongStackView.distribution = .fillEqually
    rightWrongStackView.spacing = appearance.defaultInset

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

      rightWrongStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: appearance.defaultInset),
      rightWrongStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                    constant: -appearance.defaultInset),
      rightWrongStackView.bottomAnchor.constraint(equalTo: answerButton.topAnchor,
                                                  constant: -appearance.defaultInset),

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
    answerButton.addTarget(self, action: #selector(answerButtonAction), for: .touchUpInside)
    answerButton.layer.cornerRadius = 8
    answerButton.setTitleColor(.darkText, for: .highlighted)

    rightAnswersLabel.text = "Верно: 0"
    rightAnswersLabel.textColor = .systemGreen
    wrongAnswersLabel.text = "Не верно: 0"
    wrongAnswersLabel.textColor = .systemRed

    answerTextField.placeholder = appearance.answerPlaceholderText
    answerTextField.returnKeyType = .done
    answerTextField.delegate = self
    questionLabel.text = appearance.labelText
    answerLabel.text = appearance.answerLabelText
  }

  @objc
  func answerButtonAction() {
    guard let translationText = answerTextField.text,
          !translationText.isEmpty,
          let answerText = textQuestionLabel.text else {
      return
    }

    output?.translateButtonPressed(with: answerText, translation: translationText)
    answerTextField.text = ""
  }
}

// MARK: - UITextFieldDelegate

extension TranslateScreenView: UITextFieldDelegate {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    self.endEditing(true)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    answerButtonAction()
    return true
  }
}

// MARK: - Appearance

private extension TranslateScreenView {
  struct Appearance {
    let defaultInset: CGFloat = 16
    let labelText = "Слово для перевода"
    let answerLabelText = "Ваш ответ"
    let answerPlaceholderText = "Введите ответ"
    let buttonTitle = "Ответить"
    let buttonColor: UIColor = .gray
  }
}
