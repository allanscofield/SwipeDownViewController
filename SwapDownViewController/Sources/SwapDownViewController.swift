//    MIT License
//
//    Copyright (c) 2019 Allan Scofield
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

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
