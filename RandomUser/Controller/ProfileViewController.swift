//
//  ProfileViewController.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import UIKit

final class ProfileViewController: UIViewController {
  private let currentView = ProfileView()
  private let profileViewModel: ProfileViewModel
  
  init(profileViewModel: ProfileViewModel) {
    self.profileViewModel = profileViewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func loadView() {
    view = currentView
  }
  
  public func display(_ userInfoViewModel: UserInfoViewModel) {
    currentView.configure(viewModel: userInfoViewModel)
  }
}

