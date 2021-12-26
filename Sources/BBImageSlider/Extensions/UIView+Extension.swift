//
//  UIView+Extension.swift
//  
//
//  Created by Batuhan Baran on 24.12.2021.
//

import UIKit

extension UIView {
  
    public class func fromNib<T: UIView>() -> T {
        let name = String(describing: Self.self);
        guard let nib = Bundle(for: Self.self).loadNibNamed(
                name, owner: nil, options: nil)
        else {
            fatalError("Missing nib-file named: \(name)")
        }
        return nib.first as! T
    }
//    func loadFromNib(nibName: String) -> UIView? {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        return nib.instantiate(withOwner: self, options: nil).first as? UIView
//    }
}
