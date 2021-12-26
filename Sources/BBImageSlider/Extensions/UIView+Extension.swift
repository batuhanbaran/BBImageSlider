//
//  UIView+Extension.swift
//  
//
//  Created by Batuhan Baran on 24.12.2021.
//

import UIKit

extension UIView {
  
    func loadFromNib(nibName: String) -> UIView? {
        let bundle = Bundle.module
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
