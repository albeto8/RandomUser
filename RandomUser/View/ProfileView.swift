//
//  ProfileView.swift
//  RandomUser
//
//  Created by Mario Alberto Barragán Espinosa on 18/08/21.
//

import UIKit

final class ProfileView: UIView {
  
  let textLabelColor = UIColor(named: "TextLabel", 
                               in: Bundle(for: ProfileView.self), 
                               compatibleWith: nil)!
  
  let mainColor = UIColor(named: "MainColor", 
                          in: Bundle(for: ProfileView.self), 
                          compatibleWith: nil)!
  
  let greenButtonColor = UIColor(named: "GreenButtonColor", 
                          in: Bundle(for: ProfileView.self), 
                          compatibleWith: nil)!
  
  private lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.setDimensions(width: 100, height: 100)
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 50
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.layer.borderWidth = 2
    
    return imageView
  }()
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title1)
    label.textColor = textLabelColor
    label.textAlignment = .center
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var emailLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.textColor = textLabelColor
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var memberSinceLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.textColor = textLabelColor
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var ageTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Age"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .headline)
    label.textColor = textLabelColor
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var ageValueLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.textColor = textLabelColor
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var birthdayTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Birthday"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .headline)
    label.textColor = textLabelColor
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var birthdayValueLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.textColor = textLabelColor
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var genderTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Gender"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .headline)
    label.textColor = textLabelColor
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var genderValueLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .subheadline)
    label.textColor = textLabelColor
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var emergencyContactLabel: UILabel = {
    let label = UILabel()
    label.text = "Emergency Contact"
    label.textAlignment = .center
    label.font = .preferredFont(forTextStyle: .headline)
    label.textColor = textLabelColor
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var phoneButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.label, for: .normal)
    button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = greenButtonColor
    button.clipsToBounds = true
    button.layer.cornerRadius = 5
    
    return button
  }()
  
  private lazy var addressTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Address"
    label.textAlignment = .left
    label.font = .preferredFont(forTextStyle: .headline)
    label.textColor = textLabelColor
    label.numberOfLines = 1
    
    return label
  }()
  
  private lazy var addressValueLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .justified
    label.font = .preferredFont(forTextStyle: .body)
    label.textColor = textLabelColor
    label.numberOfLines = 0
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(viewModel: UserInfoViewModel<UIImage>) {
    nameLabel.text = viewModel.fullname
    emailLabel.text = viewModel.email
    memberSinceLabel.text = viewModel.memberSince
    ageValueLabel.text = viewModel.age
    birthdayValueLabel.text = viewModel.birthday
    genderValueLabel.text = viewModel.gender
    phoneButton.setTitle(viewModel.emergencyPhone, for: .normal)
    addressValueLabel.text = viewModel.address
  }
  
  func configureUserImage(image: UIImage) {
    profileImageView.image = image
  }
  
  private func setUpView() {
    backgroundColor = mainColor
    
    addSubview(profileImageView)
    addSubview(addressTitleLabel)
    addSubview(addressValueLabel)
    
    let userDataStack = makeUserDataStack()
    addSubview(userDataStack)
    
    let attributesStack = makeUserAttributesStack()
    addSubview(attributesStack)
    
    let emergencyContactStack = makeEmergencyContactStack()
    addSubview(emergencyContactStack)
    
    profileImageView.anchor(top: topAnchor, paddingTop: 16)
    profileImageView.centerX(inView: self)
    
    userDataStack.anchor(top: profileImageView.bottomAnchor, 
                         paddingTop: 8, 
                         left: leadingAnchor, 
                         right: trailingAnchor)
    
    attributesStack.anchor(top: userDataStack.bottomAnchor, 
                           paddingTop: 16, 
                           left: leadingAnchor, 
                           right: trailingAnchor)
    
    emergencyContactStack.anchor(top: attributesStack.bottomAnchor, 
                                 paddingTop: 16, 
                                 left: leadingAnchor,
                                 paddingLeft: 50,
                                 right: trailingAnchor,
                                 paddingRight: 50)
    
    addressTitleLabel.anchor(top: emergencyContactStack.bottomAnchor,
                             paddingTop: 20,
                             left: leadingAnchor,
                             paddingLeft: 20,
                             right: trailingAnchor)
    
    addressValueLabel.anchor(top: addressTitleLabel.bottomAnchor,
                             paddingTop: 8,
                             left: leadingAnchor,
                             paddingLeft: 20,
                             right: trailingAnchor,
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
    phoneButton.anchor(height: 60)
    
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
