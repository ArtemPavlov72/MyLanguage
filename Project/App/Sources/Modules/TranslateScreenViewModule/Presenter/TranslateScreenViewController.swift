//
//  TranslateScreenViewController.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 19.05.2023.
//

import UIKit

/// События которые отправляем из `текущего модуля` в `другой модуль`
protocol TranslateScreenModuleOutput: AnyObject {}

/// События которые отправляем из `другого модуля` в `текущий модуль`
protocol TranslateScreenModuleInput {
  
  /// События которые отправляем из `текущего модуля` в `другой модуль`
  var moduleOutput: TranslateScreenModuleOutput? { get set }
}

/// Готовый модуль `TranslateScreenModule`
typealias TranslateScreenModule = UIViewController & TranslateScreenModuleInput

/// Презентер
final class TranslateScreenViewController: TranslateScreenModule {
  
  // MARK: - Internal properties
  
  weak var moduleOutput: TranslateScreenModuleOutput?
  
  // MARK: - Private properties
  
  private let interactor: TranslateScreenInteractorInput
  private let moduleView: TranslateScreenViewProtocol
  private let factory: TranslateScreenFactoryInput
  
  // MARK: - Initialization
  
  /// - Parameters:
  ///   - moduleView: вью
  ///   - interactor: интерактор
  ///   - factory: фабрика
  init(moduleView: TranslateScreenViewProtocol,
       interactor: TranslateScreenInteractorInput,
       factory: TranslateScreenFactoryInput) {
    self.moduleView = moduleView
    self.interactor = interactor
    self.factory = factory
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life cycle
  
  override func loadView() {
    view = moduleView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    interactor.getContent()
  }
}

// MARK: - TranslateScreenViewOutput

extension TranslateScreenViewController: TranslateScreenViewOutput {
  func answerButtonAction() {

  }
}

// MARK: - TranslateScreenInteractorOutput

extension TranslateScreenViewController: TranslateScreenInteractorOutput {
  func didReceive(_ word: String?) {
    moduleView.setWordForTranslate(word)
  }

  func somethingWentWrong() {

  }
}

// MARK: - TranslateScreenFactoryOutput

extension TranslateScreenViewController: TranslateScreenFactoryOutput {}

// MARK: - Private

private extension TranslateScreenViewController {}

// MARK: - Appearance

private extension TranslateScreenViewController {
  struct Appearance {}
}
