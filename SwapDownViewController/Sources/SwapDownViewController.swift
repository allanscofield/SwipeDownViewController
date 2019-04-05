//
//  SwapDownViewController.swift
//  allan
//
//  Created by Allan on 30/11/18.
//  Copyright © 2018 Allan. All rights reserved.
//

import UIKit

open class SwapDownViewController: UIViewController {
    
    public var interactor: Interactor? = nil
    public var panGesture: UIPanGestureRecognizer!

    open override func viewDidLoad() {
        super.viewDidLoad()

        //Swap to close
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(swapToClose(_:)))
        panGesture.delegate = self
        self.view.addGestureRecognizer(panGesture)
    }
    
    public func addSwapDownToClose(to tableView: UITableView) {
        tableView.addGestureRecognizer(panGesture)
    }
    
    @objc public func swapToClose(_ sender: UIPanGestureRecognizer){
        let percentThreshold:CGFloat = 0.3
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        var currentInteractor: Interactor!
        if let nav = self.navigationController as? SwapDownNavigationController, let interactorNav = nav.interactor {
            currentInteractor = interactorNav
        }
        else if let localInteractor = self.interactor {
            currentInteractor = localInteractor
        }
        else {
            return
        }
        
        switch sender.state {
        case .began:
            currentInteractor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            currentInteractor.shouldFinish = progress > percentThreshold
            currentInteractor.update(progress)
        case .cancelled:
            currentInteractor.hasStarted = false
            currentInteractor.cancel()
        case .ended:
            currentInteractor.hasStarted = false
            currentInteractor.shouldFinish
                ? currentInteractor.finish()
                : currentInteractor.cancel()
        default:
            break
        }
    }
    
    @objc public func close(){
        self.dismiss(animated: true, completion: nil)
    }

}

//MARK: - Gestures
extension SwapDownViewController: UIGestureRecognizerDelegate{
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGesture{
            if let direction = panGesture.direction {
                return direction.isVertical && direction == .down
            }
        }
        return false
    }
}
