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
  var userInfoViewModel: UserInfoViewModel<UIImage>?
  
  init(profileViewModel: ProfileViewModel) {
    self.profileViewModel = profileViewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    profileViewModel.fetch()
  }
  
  override func loadView() {
    view = currentView
  }
  
  public func display(_ userInfoViewModel: UserInfoViewModel<UIImage>) {
    currentView.configure(viewModel: userInfoViewModel)
    self.userInfoViewModel = userInfoViewModel
    userInfoViewModel.loadImageData()
  }
  
  func display(userImage: UIImage) {
    currentView.configureUserImage(image: userImage)
  }
}

