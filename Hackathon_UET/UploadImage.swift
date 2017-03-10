//
//  UploadImage.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/11/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UploadImage: NSObject  {
    static func upload(image : UIImage , complete:@escaping(Error?,JSON?) -> ()) {
        let param : [String : String] = [:]
        let headers: HTTPHeaders = [
            "Authorization": "Client-ID 31190ca270a70c7",
        ]
        if let data = UIImagePNGRepresentation(image) {
            let filename = getDocumentsDirectory().appendingPathComponent("copy.png")
            try? data.write(to: filename)
            Alamofire.upload(multipartFormData:{ multipartFormData in
                multipartFormData.append(filename, withName: "image")},
                             to:"https://api.imgur.com/3/upload",
                             method:.post,
                             headers:["Authorization": "Client-ID 31190ca270a70c7"],
                             encodingCompletion: { encodingResult in
                                switch encodingResult {
                                case .success(let upload, _, _):
                                    upload.responseJSON { response in
                                        let json = JSON.init(data: response.data!)
                                        complete(nil,json)
                                    }
                                case .failure(let encodingError):
                                    complete(encodingError,nil)
                                }
            })
        }
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
