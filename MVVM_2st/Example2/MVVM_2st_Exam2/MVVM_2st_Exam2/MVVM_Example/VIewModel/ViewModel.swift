//
//  ViewModel.swift
//  MVVM_2st_Exam2
//
//  Created by kimjiseob on 2019/12/27.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import UIKit

public typealias ImageDownloadCompletionClosure = (_ imageData: NSData) -> Void

var messierViewModel: [MessierViewModel] =
[MessierViewModel(messierDataModel: Messier1),
 MessierViewModel(messierDataModel: Messier8),
 MessierViewModel(messierDataModel: Messier57)]


class MessierViewModel {
    private let messierDataModel: MessierDataModel
    private var imageURL: URL
    private var updatedDate: Date?
    
    init(messierDataModel: MessierDataModel) {
        self.messierDataModel = messierDataModel
        self.imageURL = URL(string: messierDataModel.imageLink)!
    }
    
    var formalName: String{
        return "Formal name: " + messierDataModel.formalName
    }
    
    var commonName: String {
        return "Common name: " + messierDataModel.commonName
    }
    
    public var dateUpdate: String {

        let dateString = String(messierDataModel.updateDate.year) + "-" + String(messierDataModel.updateDate.month) + "-" + String(messierDataModel.updateDate.day)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy"
        
        if let date = dateFormatterGet.date(from: dateString) {
            updatedDate = date
            return "Updated: " + dateFormatterPrint.string(from: date)
        } else {
            return "There was an error decoding the string"
        }
    }
    
    var textDescription: NSAttributedString {
        let fontAttirubtes = [
            NSAttributedString.Key.font : UIFont(name: "Georgia", size: 14.0)!,
            NSAttributedString.Key.foregroundColor : UIColor.blue
        ]
        
        let markedUpDescription = NSAttributedString(string: messierDataModel.description, attributes: fontAttirubtes)
        
        return markedUpDescription
    }
    
    var thumbnail: String {
        return messierDataModel.thumbnail
    }
    
    func download(completionHandler: @escaping ImageDownloadCompletionClosure) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url: imageURL)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let url = tempLocalUrl {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    let rawImageData = NSData(contentsOf: url)
                    completionHandler(rawImageData!)
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
            } else {
                print("Error took place while downloading a file. Error description \(error?.localizedDescription ?? "")")
            }
        }
        
        task.resume()
    }
    
}
