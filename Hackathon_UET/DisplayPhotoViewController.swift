//
//  DisplayPhotoViewController.swift
//  KiddyStory
//
//  Created by Anh Tuan on 3/2/17.
//  Copyright © 2017 QTS M002. All rights reserved.
//

import UIKit
import Alamofire

class DisplayPhotoViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    var imgObj : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.img.sd_setImage(with: URL.init(string: imgObj!), placeholderImage: kImagePlaceHoler)
//        Alamofire.request(imgObj!).responseData { (response) in
//            let data = response.data!
//            self.img.image = UIImage(data: data)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}
