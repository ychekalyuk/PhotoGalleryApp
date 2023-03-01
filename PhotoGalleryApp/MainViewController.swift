//
//  MainViewController.swift
//  PhotoGalleryApp
//
//  Created by Юрий Альт on 01.03.2023.
//

import UIKit
import Photos

class MainViewController: UIViewController {
    //MARK: - Private Properties
    private var assets: PHFetchResult<PHAsset>? = nil
    
    //MARK: - Views
    private lazy var photoGalleryCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let sideSize = (UIScreen.main.bounds.width - 12) / 4
        layout.itemSize = CGSize(width: sideSize, height: sideSize)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 2
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(photoGalleryCollectionView)
        setupConstraints()
        fetchAssets()
    }
    
    //MARK: - Private Methods
    private func fetchAssets() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        assets = PHAsset.fetchAssets(with: options)
    }
}

//MARK: - Layout
private extension MainViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoGalleryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoGalleryCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            photoGalleryCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            photoGalleryCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        assets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.identifier,
            for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        if let asset = assets?[indexPath.row] {
            cell.configure(asset: asset)
        }
        return cell
    }
}

