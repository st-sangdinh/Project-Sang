//
//  Loader.swift
//  Sang.Dinh.V3
//
//  Created by Rin Sang on 25/05/2022.
//

import Foundation
import UIKit

open class Loader: UIView {

    private let progressLayer = CAShapeLayer()

    open var lineWidth: CGFloat = 3.0

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.addSublayer(progressLayer)
        backgroundColor = .clear
        updatePath()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.layer.addSublayer(progressLayer)
        backgroundColor = .clear
        updatePath()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        progressLayer.frame = bounds
        updatePath()
    }

    open func startAnimating() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.duration = 4.0
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = 2.0 * .pi
        rotationAnimation.repeatCount = .infinity
        progressLayer.add(rotationAnimation, forKey: "rotationAnimation")

        let headAnimation = CABasicAnimation(keyPath: "strokeStart")
        headAnimation.duration = 1.0
        headAnimation.fromValue = 0.0
        headAnimation.toValue = 0.25
        headAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let tailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        tailAnimation.duration = 1.0
        tailAnimation.fromValue = 0.0
        tailAnimation.toValue = 1.0
        tailAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let endHeadAnimation = CABasicAnimation(keyPath: "strokeStart")
        endHeadAnimation.beginTime = 1.0
        endHeadAnimation.duration = 0.5
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1.0
        endHeadAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let endTailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endTailAnimation.beginTime = 1.0
        endTailAnimation.duration = 0.5
        endTailAnimation.fromValue = 1.0
        endTailAnimation.toValue = 1.0
        endTailAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        let animations = CAAnimationGroup()
        animations.beginTime = CACurrentMediaTime() + 0.25
        animations.duration = 1.5
        animations.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]
        animations.repeatCount = .infinity

        progressLayer.add(animations, forKey: "fillAnimations")
    }

    open func stopAnimating() {
        progressLayer.removeAllAnimations()
    }

    private func updatePath() {
        let startAngle: CGFloat = 0.0
        let endAngle: CGFloat = 2.0 * .pi
        let radius: CGFloat = min(bounds.size.width / 2.0, bounds.size.height / 2.0)
        let path = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: radius - lineWidth / 2.0,
            startAngle: startAngle,
            endAngle: endAngle, clockwise: true)

        progressLayer.contentsScale = UIScreen.main.scale

        progressLayer.path = path.cgPath

        progressLayer.strokeColor = UIColor.green.cgColor
        progressLayer.fillColor = backgroundColor?.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
    }
}
