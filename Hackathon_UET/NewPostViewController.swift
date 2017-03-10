//
//  NewPostViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/6/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import NohanaImagePicker
import Photos

class NewPostViewController: UIViewController {
    var listImage = [UIImage]()
    var listPHAsset = [PHAsset]()
    @IBOutlet weak var heightNaviConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView : UICollectionView!
    let imagePicker = NohanaImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(NewPostViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewPostViewController.keyboardWillHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification : Notification){
        
    }
    
    func keyboardWillHidden(notification : Notification){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
    }
}
extension NewPostViewController : UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        let keyboard = Bundle.main.loadNibNamed("CustomeKeyboard", owner: self, options: nil)?[0] as! CustomeKeyboard
        keyboard.delegate = self
        keyboard.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        view.backgroundColor = UIColor.blue
        textView.inputAccessoryView = keyboard
        return true
    }
}
extension NewPostViewController : customeDelegate {
    func chooseImage() {
        self.imagePicker.delegate = self
        for item in self.listPHAsset {
        self.imagePicker.pickAsset(item as! Asset)
        }
        self.present(self.imagePicker, animated: true, completion: nil)
    }
}
extension NewPostViewController : NohanaImagePickerControllerDelegate {
    func nohanaImagePicker(_ picker: NohanaImagePickerController, didFinishPickingPhotoKitAssets pickedAssts: [PHAsset]) {
        listImage.removeAll()
        self.listPHAsset.removeAll()
        for item in pickedAssts {
            let img = getAssetThumbnail(asset: item)
            listImage.append(img)
            self.listPHAsset.append(item)
        }
        self.collectionView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }

    func nohanaImagePickerDidCancel(_ picker: NohanaImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension NewPostViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listImage.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imgview.image = self.listImage[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        return CGSize(width: 100, height: 100)
    }
}
