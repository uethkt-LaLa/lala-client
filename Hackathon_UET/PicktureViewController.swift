//
//  PicktureViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/10/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import NohanaImagePicker
import Photos

class PicktureViewController: UIViewController {
    @IBOutlet weak var viewImage : UIView!
    var listImage = [UIImage]()
    var listPHAsset = [PHAsset]()
    let imagePicker = NohanaImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.navigationController?.isNavigationBarHidden = true
        self.imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewImage.addSubview(self.imagePicker.view)
        self.imagePicker.view.frame = CGRect(x: 0, y: 0, width: self.viewImage.frame.width, height: self.viewImage.frame.height)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension PicktureViewController : NohanaImagePickerControllerDelegate {
    func nohanaImagePicker(_ picker: NohanaImagePickerController, didFinishPickingPhotoKitAssets pickedAssts: [PHAsset]) {
        for item in pickedAssts {
            let img = getAssetThumbnail(asset: item)
            listImage.append(img)
            self.listPHAsset.append(item)
        }
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
