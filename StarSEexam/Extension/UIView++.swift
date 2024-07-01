//
//  UIView++.swift
//  StarSEexam
//
//  Created by Toe Wai Aung on 01/07/2024.
//

import UIKit

extension UIView {
    
    func _init() {
        let nibName = String(describing: type(of: self))
        let nib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        let view = nib?.first as! UIView
        view.frame = bounds
        addSubview(view)
    }
    
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func reloadFrame() {
        let height = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = self.frame
        frame.size.height = height
        self.frame = frame
    }
    
    static func reloadViewFrame<T: UIView>(view: T) -> T {
        let height = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = view.frame
        //Comparison necessary to avoid infinite loop
        if height != frame.size.height {
            frame.size.height = height
            view.frame = frame
        }
        return view
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

extension UIView {
    
    func roundCorners(tLeft: CGFloat,tRight: CGFloat,bLeft: CGFloat,bRight: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, topLeftRadius: tLeft, topRightRadius: tRight, bottomLeftRadius: bLeft, bottomRightRadius: bRight)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func shake(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
            (degrees: Double) -> Double in
            let radians: Double = (Double.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
    
    func screenshot(_ w: CGFloat,_ h: CGFloat) -> UIImage {
        
        if(self is UIScrollView) {
            let scrollView = self as! UIScrollView
            
            let savedContentOffset = scrollView.contentOffset
            let savedFrame = scrollView.frame
            
            scrollView.contentOffset = .zero
            self.frame = CGRect(x: 0, y: 0, width: w, height: h)
            let rect: CGRect = self.frame
            UIGraphicsBeginImageContext(rect.size)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            
            scrollView.contentOffset = savedContentOffset
            scrollView.frame = savedFrame
            
            return image!
        }
        
        UIGraphicsBeginImageContext(self.bounds.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }
}

extension UIBezierPath {
    public convenience init(roundedRect rect: CGRect, topLeftRadius: CGFloat?, topRightRadius: CGFloat?, bottomLeftRadius: CGFloat?, bottomRightRadius: CGFloat?) {
        self.init()

        assert(((bottomLeftRadius ?? 0) + (bottomRightRadius ?? 0)) <= rect.size.width)
        assert(((topLeftRadius ?? 0) + (topRightRadius ?? 0)) <= rect.size.width)
        assert(((topLeftRadius ?? 0) + (bottomLeftRadius ?? 0)) <= rect.size.height)
        assert(((topRightRadius ?? 0) + (bottomRightRadius ?? 0)) <= rect.size.height)

        // corner centers
        let tl = CGPoint(x: rect.minX + (topLeftRadius ?? 0), y: rect.minY + (topLeftRadius ?? 0))
        let tr = CGPoint(x: rect.maxX - (topRightRadius ?? 0), y: rect.minY + (topRightRadius ?? 0))
        let bl = CGPoint(x: rect.minX + (bottomLeftRadius ?? 0), y: rect.maxY - (bottomLeftRadius ?? 0))
        let br = CGPoint(x: rect.maxX - (bottomRightRadius ?? 0), y: rect.maxY - (bottomRightRadius ?? 0))

        //let topMidpoint = CGPoint(rect.midX, rect.minY)
        let topMidpoint = CGPoint(x: rect.midX, y: rect.minY)

        makeClockwiseShape: do {
            self.move(to: topMidpoint)

            if let topRightRadius = topRightRadius {
                self.addLine(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
                self.addArc(withCenter: tr, radius: topRightRadius, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
            }
            else {
                self.addLine(to: tr)
            }

            if let bottomRightRadius = bottomRightRadius {
                self.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
                self.addArc(withCenter: br, radius: bottomRightRadius, startAngle: 0, endAngle: CGFloat.pi/2, clockwise: true)
            }
            else {
                self.addLine(to: br)
            }

            if let bottomLeftRadius = bottomLeftRadius {
                self.addLine(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
                self.addArc(withCenter: bl, radius: bottomLeftRadius, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)
            }
            else {
                self.addLine(to: bl)
            }

            if let topLeftRadius = topLeftRadius {
                self.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
                self.addArc(withCenter: tl, radius: topLeftRadius, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)
            }
            else {
                self.addLine(to: tl)
            }

            self.close()
        }
    }
}

public extension Collection {
    func json() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {
//                Log.i("Can't create string with data.")
                return "{}"
            }
            return jsonString
        } catch let parseError {
            print("json serialization error: \(parseError)")
            return "{}"
        }
    }
}
