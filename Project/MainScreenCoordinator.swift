//
//  MainScreenCoordinator.swift
//  MyLanguage
//
//  Created by Artem Pavlov on 02.06.2023.
//

import UIKit

/// События которые отправляем из `текущего координатора` в `другой координатор`
protocol MainScreenCoordinatorOutput: AnyObject {}

/// События которые отправляем из `другого координатора` в `текущий координатор`
protocol MainScreenCoordinatorInput {

  /// Приложение стало активным
  func sceneDidBecomeActive()

  /// События которые отправляем из `текущего координатора` в `другой координатор`
  var output: MainScreenCoordinatorOutput? { get set }
}

typealias MainScreenCoordinatorProtocol = MainScreenCoordinatorInput & Coordinator

final class MainScreenCoordinator: MainScreenCoordinatorProtocol {

  // MARK: - Internal variables

  weak var output: MainScreenCoordinatorOutput?

  // MARK: - Private variables

  private let navigationController: UINavigationController
  private var mainScreenModule: MainScreenModule?
  private var anyCoordinator: Coordinator?
  private let window: UIWindow?

  // MARK: - Initialization

  /// - Parameters:
  ///   - window: Окно просмотра
  ///   - navigationController: UINavigationController
  init(_ window: UIWindow?,
       _ navigationController: UINavigationController) {
    self.window = window
    self.navigationController = navigationController
  }

  // MARK: - Internal func

  func start() {
    let mainScreenModule = MainScreenAssembly().createModule()
    self.mainScreenModule = mainScreenModule
    self.mainScreenModule?.moduleOutput = self

    navigationController.pushViewController(mainScreenModule, animated: true)

  }

  func sceneDidBecomeActive() {

  }
}

// MARK: - MainScreenModuleOutput

extension MainScreenCoordinator: MainScreenModuleOutput {

  func mainScreenModuleWillAppear() {}

  func mainScreenModuleDidAppear() {}
}

// MARK: - UIApplication

private extension UIApplication {
  var foregroundActiveScene: UIWindowScene? {
    connectedScenes
      .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
  }
}

// MARK: - Appearance

private extension MainScreenCoordinator {
  struct Appearance { }
}
