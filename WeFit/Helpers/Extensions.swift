//
//  Extensions.swift
//  AppStoreJSONApis
//
//  Created by Brian Voong on 2/14/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

import UIKit

extension Float {
    func data() -> Data? {
        return String(self).data(using: .utf8)
    }
}

extension Int {
    func data() -> Data? {
        return String(self).data(using: .utf8)
    }
}

extension String {
    func data() -> Data? {
        return self.data(using: .utf8)
    }
}

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

extension UIFont {
    var bold: UIFont {
        return with(.traitBold)
    }

    var italic: UIFont {
        return with(.traitItalic)
    }

    var boldItalic: UIFont {
        return with([.traitBold, .traitItalic])
    }



    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits)) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func without(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(self.fontDescriptor.symbolicTraits.subtracting(UIFontDescriptor.SymbolicTraits(traits))) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}



extension UIColor {
    
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        assert(a >= 0.0 && a <= 1.0, "Invalid alpha component")
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    convenience init(_ rgb: Int, a: CGFloat = 1.0) {

        self.init(
            CGFloat((rgb >> 16) & 0xFF),
            CGFloat((rgb >> 8) & 0xFF),
            CGFloat(rgb & 0xFF),
            a
        )
    }

    // MARK: - Initialization

    convenience init?(hex: String) {
        var hexNormalized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexNormalized = hexNormalized.replacingOccurrences(of: "#", with: "")

        // Helpers
        var rgb: UInt32 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        let length = hexNormalized.count

        // Create Scanner
        Scanner(string: hexNormalized).scanHexInt32(&rgb)

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }

    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format: "#%06x", rgb)
    }
}

extension UIView {
    func addShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: 5, height: 5)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 5
        self.layer.shadowPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func addShadow(x dx: Int, y dy: Int, r: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: dx, height: dy)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = r
        self.layer.shadowPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }


    func addShadow(x dx: Int, y dy: Int) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.init(width: dx, height: dy)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3
        self.layer.shadowPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}

extension UIViewController {
    func presentViewControllerAsRootVC(with vc:UIViewController) {
        DispatchQueue.main.async {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.window?.switchRootViewControllerWith(vc)
            }
        }
    }
    
    func toast(_ txt:String, sec:Double = 1) {
        let alert = UIAlertController(title: nil, message: txt, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        present(alert,animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + sec) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

extension UIWindow {
    func switchRootViewControllerWith(storyboard id:String = "Main", viewController vcid:String) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: id, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: vcid)
            self.switchRootViewController(vc)
        }
    }
    
    func switchRootViewControllerWith(_ vc: UIViewController) {
        DispatchQueue.main.async {
            self.switchRootViewController(vc)
        }
    }
    
    func switchRootViewController(_ viewController: UIViewController,  animated: Bool = true, duration: TimeInterval = 0.5, options: UIView.AnimationOptions = .transitionCrossDissolve, completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}
