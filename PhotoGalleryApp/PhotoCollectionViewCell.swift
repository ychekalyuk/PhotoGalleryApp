//
//  PhotoCollectionViewCell.swift
//  PhotoGalleryApp
//
//  Created by Юрий Альт on 01.03.2023.
//

import UIKit
import Photos

//MARK: - PhotosCollectionViewCell
class PhotosCollectionViewCell: UICollectionViewCell {
    //MARK: - Identifier
    static let identifier = "PhotosCollectionViewCell"
    
    //MARK: - Views
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Lifecycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(mainImageView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    func configure(asset: PHAsset) {
        PHImageManager.default().requestImage(
            for: asset,
            targetSize: mainImageView.frame.size,
            contentMode: .aspectFit,
            options: nil) { [weak self] image, _ in
                self?.mainImageView.image = image
            }
    }
}

//MARK: - Layout
private extension PhotosCollectionViewCell {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
