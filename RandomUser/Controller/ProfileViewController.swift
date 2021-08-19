//
//  ProfileViewController.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import UIKit

final class ProfileViewController: UIViewController {
  
  private let currentView = ProfileView()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(named: "MainColor")
  }
  
  override func loadView() {
    view = currentView
  }
  
  public func display(_ userInfoViewModel: UserInfoViewModel) {
    currentView.configure(viewModel: userInfoViewModel)
  }
}

