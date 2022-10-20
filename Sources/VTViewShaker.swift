//
//  VTViewShaker.swift
//  
//
//  Created by Voda Ion on 10/20/22.
//

import UIKit

let kViewShakerDefaultDuration: TimeInterval = 0.5
let kViewShakerAnimationKey = "kVTViewShakerAnimationKey"

public class VTViewShaker: NSObject {
    private let views: [UIView]
    private var completedAnaimations: Int = 0
    private var completion: (() -> Void)?
    
    public convenience init(with view: UIView) {
        self.init(with: [view])
    }
    
    public init(with views: [UIView]) {
        self.views = views
    }
    
    public func shake() {
        self.shake(with: kViewShakerDefaultDuration)
    }
    
    public func shake(with duration: TimeInterval, _ completion: (() -> Void)? = nil) {
        self.completion = completion
        
        views.forEach {
            self.addShakeAnimation(for: $0, with: duration)
        }
    }

    func addShakeAnimation(for view: UIView, with duration: TimeInterval) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        let currentTx: CGFloat = view.transform.tx
        animation.delegate = self
        animation.duration = duration
        animation.values = [
            currentTx,
            currentTx + 10,
            currentTx - 8,
            currentTx + 8,
            currentTx - 5,
            currentTx + 5,
            currentTx
        ]
        animation.keyTimes = [0, 0.255, 0.425, 0.6, 0.75, 0.875, 1]
        animation.timingFunctions = [CAMediaTimingFunction(name: .easeInEaseOut)]
        view.layer.add(animation, forKey: kViewShakerAnimationKey)
    }
}

extension VTViewShaker: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.completedAnaimations += 1
        if completedAnaimations >= self.views.count {
            completedAnaimations = 0
            completion?()
        }
    }
}
