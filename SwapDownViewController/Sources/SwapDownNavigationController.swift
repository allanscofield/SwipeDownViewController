//
//  SwapDownNavigationController.swift
//  allan
//
//  Created by Allan on 30/11/18.
//  Copyright © 2018 Allan. All rights reserved.
//

import UIKit

open class SwapDownNavigationController: UINavigationController {

    public var interactor: Interactor? = nil
    
    public convenience init(rootViewController: UIViewController, interactor: Interactor, delegate: UINavigationControllerDelegate, transitioningDelegate: UIViewControllerTransitioningDelegate) {
        self.init(rootViewController: rootViewController)
        self.interactor = interactor
        self.delegate = delegate
        self.transitioningDelegate = transitioningDelegate
    }
}
