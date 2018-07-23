//
//  ViewController.swift
//  GalleryWithAnimations
//
//  Created by Swapnil Sankla on 20/07/18.
//  Copyright © 2018 Swapnil Sankla. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                      UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate,
                      UICollectionViewDataSource,
                      UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentSelection: UIImageView!
    @IBOutlet weak var currentSelectionWidth: NSLayoutConstraint!

    var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }


    @IBAction func browseButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            images.append(image)
            dismiss(animated: true, completion: nil)
            collectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)
        if let cell = cell as? CollectionViewCell {
            cell.configure(image: images[indexPath.row])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        self.currentSelectionWidth.constant = 10
                        self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.currentSelection.isHidden = false
                            self.currentSelection.image = self.images[indexPath.row]
                            self.currentSelectionWidth.constant = self.collectionView.frame.width
                            self.view.bringSubview(toFront: self.currentSelection)
                            self.currentSelection.transform = CGAffineTransform(rotationAngle: .pi)
                            self.view.layoutIfNeeded()
            })

            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.currentSelection.transform = CGAffineTransform(rotationAngle: 2 * .pi)
                            self.view.layoutIfNeeded()
            })
        })
    }
}

