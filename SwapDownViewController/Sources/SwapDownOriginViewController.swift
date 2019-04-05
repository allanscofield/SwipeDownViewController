//
//  SwapDownOriginViewController.swift
//  SwapDownToCloseExample
//
//  Created by Allan on 05/04/19.
//  Copyright © 2019 Allan. All rights reserved.
//

import UIKit

open class SwapDownOriginViewController: UIViewController, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    public let interactor: Interactor = Interactor()
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ((dismissed is SwapDownNavigationController) || (dismissed is SwapDownViewController)) ? DismissModalAnimator() : nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
}
