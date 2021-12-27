//
//  File.swift
//  
//
//  Created by Batuhan Baran on 24.12.2021.
//

import UIKit
import Kingfisher

open class ImageCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
    }
    
    open override class func awakeFromNib() {
        
    }
    
    private func addSubviews() {
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
    func configure(with imageUrl: String, contentMode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: imageUrl) else { return }
        self.imageView.kf.setImage(with: url)
        imageView.contentMode = contentMode
    }
}
