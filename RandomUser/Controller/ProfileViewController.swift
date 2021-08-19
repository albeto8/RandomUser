//
//  ProfileViewController.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import UIKit

final class ProfileViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(named: "MainColor")
  }
  
  override func loadView() {
    view = ProfileView()
  }
}

