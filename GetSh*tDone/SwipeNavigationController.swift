//
//  SwipeNavigationController.swift
//  GetSh*tDone
//
//  Created by Jaksa Tomovic on 04/04/2018.
//  Copyright © 2018 Jakša Tomović. All rights reserved.
//

import UIKit
import SwipeTransition

class SwipeNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeBack = SwipeBackController(navigationController: self)
    }
}
