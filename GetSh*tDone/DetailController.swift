//
//  DetailController.swift
//  GetSh*tDone
//
//  Created by Jaksa Tomovic on 05/04/2018.
//  Copyright © 2018 Jakša Tomović. All rights reserved.
//

import UIKit
import SwipeTransition


class DetailController: UIViewController {

    var _title: String = ""
    
    var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 16))
        return label
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        label.text = "FUCKING fairy won't come and do it!"
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 16))
        return label
    }()
    
    var doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("DONE", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        return button
    }()
    
    
    let transition = ExpandingCellTransition()
    
    var navigationBarSnapshot: UIView!
    var navigationBarHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeToDismiss = SwipeToDismissController(viewController: self)
        view.addSubview(headerView)
        view.addSubview(messageLabel)
        view.addSubview(doneButton)
        headerView.addSubview(titleLabel)
 
        
        headerView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 25, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 60)
        titleLabel.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        messageLabel.anchor(headerView.bottomAnchor, left: view.leftAnchor, bottom: doneButton.topAnchor, right: view.rightAnchor, topConstant: 30, leftConstant: 16, bottomConstant: 16, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        
        doneButton.anchor(nil, left: view.centerXAnchor, bottom: view.centerYAnchor, right: nil, topConstant: 0, leftConstant: -40, bottomConstant: -80, rightConstant: 0, widthConstant: 80, heightConstant: 80)
        
        titleLabel.text = _title
        
        self.transitioningDelegate = transition
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if navigationBarSnapshot != nil {
            navigationBarSnapshot.frame.origin.y = -navigationBarHeight
            view.addSubview(navigationBarSnapshot)

        }
    }
    
    @objc func handleCloseButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: ExpandingTransitionPresentedViewController
extension DetailController: ExpandingTransitionPresentedViewController {
    
    func expandingTransition(_ transition: ExpandingCellTransition, navigationBarSnapshot: UIView) {
        self.navigationBarSnapshot = navigationBarSnapshot
        self.navigationBarHeight = navigationBarSnapshot.frame.height
    }
}



