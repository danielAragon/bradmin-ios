//
//  UImageViewExtension.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/7/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import Foundation
import UIKit
import os

extension UIImageView {
    func setImage(fromNamedAsset name: String){
        self.image = UIImage(named: name)
    }
    
    func setImage(fromUrlString urlString: String,
                  withDefaultNamed defaultName: String?,
                  withErrornamed errorname: String?){
        //setImage: fromUrlString: withDefaultNamed: withErrorNamed
        guard let url = URL(string: urlString) else {
            let message = "Incorrect Url String"
            os_log("%@", message)
            if let name = defaultName {
                DispatchQueue.main.async {
                    self.setImage(fromNamedAsset: name)
                }
            }
            return
        }
        
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard
                let urlResponse = response as? HTTPURLResponse,
                urlResponse.statusCode == 200,
                let mineType = response?.mimeType,
                mineType.hasPrefix("image"),
                let data = data,
                error == nil,
                let image = UIImage(data: data) else {
                    let message = "Error while downloading Image"
                    os_log("%@", message)
                    if let name = errorname {
                        DispatchQueue.main.async {
                            self.setImage(fromNamedAsset: name)
                        }
                    }
                    return
            }
            DispatchQueue.main.async {
                self.image = image
            }
            }.resume()
    }
    
}
