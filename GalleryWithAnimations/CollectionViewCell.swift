//
//  CollectionViewCell.swift
//  GalleryWithAnimations
//
//  Created by Swapnil Sankla on 20/07/18.
//  Copyright © 2018 Swapnil Sankla. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    func configure(image: UIImage) {
        imageView.image = image
    }
}
