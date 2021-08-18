//
//  ProfileViewController.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 17/08/21.
//

import UIKit

final class ProfileViewController: UIViewController {
  
  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "randomUser1")
    imageView.image = image
    imageView.setDimensions(width: 100, height: 100)
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 50
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.layer.borderWidth = 2
    
    return imageView
  }()
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Mr. Sam Anderson"
    label.font = .preferredFont(forTextStyle: .title1)
    label.textAlignment = .center
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var emailLabel: UILabel = {
    let label = UILabel()
    label.text = "maxime.anderson@example.com"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var memberSinceLabel: UILabel = {
    let label = UILabel()
    label.text = "Member since 2012"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var ageTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Age"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .headline)
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var ageValueLabel: UILabel = {
    let label = UILabel()
    label.text = "29 Years"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var birthdayTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Birthday"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .headline)
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var birthdayValueLabel: UILabel = {
    let label = UILabel()
    label.text = "12/30"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var genderTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Gender"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .headline)
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var genderValueLabel: UILabel = {
    let label = UILabel()
    label.text = "Female"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var emergencyContactLabel: UILabel = {
    let label = UILabel()
    label.text = "Emergency Contact"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .headline)
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var phoneButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.label, for: .normal)
    button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = UIColor(named: "GreenButtonColor")
    button.setTitle("829-826-3101", for: .normal)
    button.clipsToBounds = true
    button.layer.cornerRadius = 5
    button.setDimensions(width: 100, height: 60)

    return button
  }()
  
  private lazy var addressTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Address"
    label.textAlignment = .left
    label.font = .preferredFont(forTextStyle: .headline)
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var addressValueLabel: UILabel = {
    let label = UILabel()
    label.text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor"
    label.textAlignment = .justified
    label.font = .preferredFont(forTextStyle: .body)
    label.numberOfLines = 0
    
    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    view.backgroundColor = UIColor(named: "MainColor")
  }
  
  private func setUpView() {
    view.addSubview(profileImageView)
    view.addSubview(addressTitleLabel)
    view.addSubview(addressValueLabel)
    
    let userDataStack = makeUserDataStack()
    view.addSubview(userDataStack)
    
    let attributesStack = makeUserAttributesStack()
    view.addSubview(attributesStack)
    
    let emergencyContactStack = makeEmergencyContactStack()
    view.addSubview(emergencyContactStack)
    
    profileImageView.anchor(top: view.topAnchor, paddingTop: 16)
    profileImageView.centerX(inView: view)
    
    userDataStack.anchor(top: profileImageView.bottomAnchor, 
                         paddingTop: 8, 
                         left: view.leadingAnchor, 
                         right: view.trailingAnchor)
    
    attributesStack.anchor(top: userDataStack.bottomAnchor, 
                           paddingTop: 16, 
                           left: view.leadingAnchor, 
                           right: view.trailingAnchor)
    
    emergencyContactStack.anchor(top: attributesStack.bottomAnchor, 
                           paddingTop: 16, 
                           left: view.leadingAnchor,
                           paddingLeft: 50,
                           right: view.trailingAnchor,
                           paddingRight: 50)
    
    addressTitleLabel.anchor(top: emergencyContactStack.bottomAnchor,
                             paddingTop: 20,
                             left: view.leadingAnchor,
                             paddingLeft: 20,
                             right: view.trailingAnchor)
    
    addressValueLabel.anchor(top: addressTitleLabel.bottomAnchor,
                             paddingTop: 8,
                             left: view.leadingAnchor,
                             paddingLeft: 20,
                             right: view.trailingAnchor,
                             paddingRight: 20)
  }
  
  private func makeUserDataStack() -> UIStackView {
    let userDataStack = makeVerticalStack(subviews: [nameLabel,
                                                     emailLabel,
                                                     memberSinceLabel])
    return userDataStack
  }
  
  private func makeUserAttributesStack() -> UIStackView {
    let ageStack = makeVerticalStack(subviews: [ageTitleLabel, 
                                                ageValueLabel])
    
    let birthdayStack = makeVerticalStack(subviews: [birthdayTitleLabel,
                                                   birthdayValueLabel])
    
    let genderStack = makeVerticalStack(subviews: [genderTitleLabel, genderValueLabel])
    let attributesStack = UIStackView(arrangedSubviews: [ageStack,
                                                         birthdayStack,
                                                         genderStack])
    
    attributesStack.axis = .horizontal
    attributesStack.distribution = .fillEqually
    
    return attributesStack
  }
  
  private func makeEmergencyContactStack() -> UIStackView {
    let stackView = makeVerticalStack(subviews: [emergencyContactLabel, 
                                                phoneButton])
    
    
    return stackView
  }
  
  private func makeVerticalStack(subviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: subviews)
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 8
    
    return stackView
  }
}

