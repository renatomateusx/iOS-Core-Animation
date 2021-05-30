//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Renato Mateus on 30/05/21.
//

import UIKit

class ViewController: UIViewController {
  //MARK: Properties
  
  
  //MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTabBar()
    configureView()
  }
  
  //MARK: Helpers
  func configureTabBar(){
    navigationController?.navigationBar.isHidden = true
           navigationController?.navigationBar.barStyle = .black
  }
  
  func configureView(){
    view.backgroundColor = .clear
  }
  
  //MARK: Selectors


}

