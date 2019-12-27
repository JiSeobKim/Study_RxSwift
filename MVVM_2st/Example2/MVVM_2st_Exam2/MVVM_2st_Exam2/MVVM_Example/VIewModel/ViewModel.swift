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

//var messierViewModel: [MessierDataModel] = [Messier]


class MessierrViewModel {
    private let messierDataMode: MessierDataModel
    private var imageURL: URL
    private var updatedDate: Date?
    
    init(messierDataModel: MessierDataModel) {
        self.messierDataMode = messierDataModel
        self.imageURL = URL(string: messierDataModel.imageLink)!
    }
    
    var formalName: String{
        return "Formal name: " + messierDataMode.formalName
    }
    
    var commonName: String {
        return "Common name: " + messierDataMode.commonName
    }
    
    public var dateUpdate: String {
        let dateString = messierDataMode.dateString
        
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
        
        let markedUpDescription = NSAttributedString(string: messierDataMode.description, attributes: fontAttirubtes)
        
        return markedUpDescription
    }
    
    var thumbnail: String {
        return messierDataMode.thumbnail
    }
    
    func download(completionHandler: @escaping ImageDownloadCompletionClosure) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url: imageURL)
        
        let task = session.downloadTask(with: <#T##URL#>)
    }
    
}
