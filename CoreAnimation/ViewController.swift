//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Renato Mateus on 30/05/21.
//

import UIKit

class ViewController: UIViewController {
  //MARK: Properties
  private let logoSize = CGSize(width: 250, height: 40)
  private var logoImageView: UIImageView!
  
  private let loginButtonSize = CGSize(width: 60, height: 60)
  var loginButton: UIButton!
  
  private let carSize = CGSize(width: 50, height: 45)
  private var carImageView: UIImageView!
  
  private var carAnimator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut, animations: nil)
  
  //MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTabBar()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    configureView()
    
    self.animateCarRight()
    self.animateLogo {
      UIView.animate(withDuration: 0.5) {
        self.animateLoginButton()
      }
    }
  }
  
  //MARK: Helpers
  func configureTabBar(){
    navigationController?.navigationBar.isHidden = true
           navigationController?.navigationBar.barStyle = .black
  }
  
  func configureView(){
    view.backgroundColor = .white
    
    logoImageView = UIImageView(
      frame: CGRect(x: view.frame.width/2 - logoSize.width / 2, y: view.frame.height / 2 - logoSize.height / 2, width: logoSize.width, height: logoSize.height)
    )
    logoImageView.contentMode = .scaleToFill
    logoImageView.image = UIImage(named: "logo_icon")
    view.addSubview(logoImageView)
    logoImageView.isUserInteractionEnabled = true
    logoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shakeLogo)))
    
    loginButton = UIButton(type: .custom)
    loginButton.frame = CGRect(x: view.frame.width/2 - loginButtonSize.width / 2, y: view.frame.height / 2 - loginButtonSize.height / 2, width: loginButtonSize.width, height: loginButtonSize.height)
    loginButton.center = view.center
    loginButton.layer.borderColor = UIColor.brown.cgColor
    loginButton.layer.borderWidth = 1
    loginButton.layer.cornerRadius = loginButtonSize.width / 2
    loginButton.setTitle("Open", for: .normal)
    loginButton.setTitleColor(.brown, for: .normal)
    loginButton.setTitleColor(UIColor.brown.withAlphaComponent(0.5), for: .highlighted)
    loginButton.alpha = 0
    
    view.addSubview(loginButton)
    
    carImageView = UIImageView(frame: CGRect(x: 0, y: view.frame.height - 100, width: carSize.width, height: carSize.height))
    carImageView.contentMode = .scaleToFill
    carImageView.image = UIImage(named: "car_icon")
    view.addSubview(carImageView)
    carImageView.isUserInteractionEnabled = true
    carImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userTapOnCar)))
  }
  
  func animateLogo(completion: @escaping ()->()){
    UIView.animate(withDuration: 1.0, animations: {
      self.logoImageView.frame = self.logoImageView.frame.offsetBy(dx: 0, dy: -250)
    }) { _ in
      completion()
    }
  }
  
  func animateLoginButton(){
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x: 0, y: view.center.y))
    path.addLine(to: CGPoint(x: loginButton.center.x - loginButtonSize.width - 10, y: view.center.y))
    
    path.addArc(withCenter: loginButton.center, radius: loginButtonSize.height / 2 + 10, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi / 2), clockwise: false)
    path.addArc(withCenter: loginButton.center, radius: loginButtonSize.height / 2 + 10, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(0), clockwise: false)
    
    path.addLine(to: CGPoint(x: view.frame.width, y: view.center.y))
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = UIColor.brown.cgColor
    shapeLayer.lineWidth = 1
    shapeLayer.lineCap = CAShapeLayerLineCap.round
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.strokeEnd = 0
    view.layer.addSublayer(shapeLayer)
    
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.toValue = 1
    animation.duration = 2.0
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    animation.fillMode = CAMediaTimingFillMode.both
    animation.isRemovedOnCompletion = false
    
    CATransaction.begin()
    CATransaction.setCompletionBlock {
      UIView.animate(withDuration: 0.5) {
        self.loginButton.alpha = 1.0
      }
    }
    shapeLayer.add(animation, forKey: animation.keyPath)
    CATransaction.commit()
  }
  
  private func animateCarRight(){
    carAnimator.stopAnimation(true)
    carAnimator.addAnimations {
      self.carImageView.frame = CGRect(origin: CGPoint(x: self.view.frame.width - self.carSize.width, y: self.view.frame.height - 100), size: self.carSize)
    }
    
    carAnimator.addCompletion { _ in
      UIView.animate(withDuration: 0.5) {
        self.carImageView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
      } completion: { _ in
        self.animateCarLeft()
      }

    }
    carAnimator.startAnimation()
  }
  
  private func animateCarLeft(){
    carAnimator.stopAnimation(true)
    carAnimator.addAnimations {
      self.carImageView.frame = CGRect(origin: CGPoint(x: 0, y: self.view.frame.height - 100), size: self.carSize)
    }
    carAnimator.addCompletion { _ in
      UIView.animate(withDuration: 0.5) {
        self.carImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      } completion: { _ in
        self.animateCarRight()
      }
    }
    carAnimator.startAnimation()
  }
  
  
  //MARK: Selectors

  @objc private func shakeLogo(){
    let animation: CABasicAnimation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.07
    animation.repeatCount = 4
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: logoImageView.center.x - 10, y: logoImageView.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: logoImageView.center.x + 10, y: logoImageView.center.y))
    logoImageView.layer.add(animation, forKey: "position")
  }
  
  @objc private func userTapOnCar(){
    if carImageView.frame.origin.x > view.frame.width / 2 {
      self.animateCarLeft()
    }
    else {
      self.animateCarRight()
    }
  }

}

