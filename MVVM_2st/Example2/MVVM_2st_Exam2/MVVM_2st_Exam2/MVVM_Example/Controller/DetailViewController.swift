//
//  DetailViewController.swift
//  MVVM_2st_Exam2
//
//  Created by kimjiseob on 2019/12/27.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var messierViewModel: MessierViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.alpha = 0
        
        let imageCompletionClosure = { (imageData: NSData) -> Void in
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0) {
                    self.imageView.alpha = 1
                    self.imageView.image = UIImage(data: imageData as Data)
                    self.view.setNeedsDisplay()
                }
                self.activitySpinner.stopAnimating()
            }
        }
        
        self.activitySpinner.startAnimating()
        
        titleLabel.text = messierViewModel?.formalName
        subtitleLabel.text = messierViewModel?.commonName
        updatedLabel.text = messierViewModel?.dateUpdate
        descriptionTextView.attributedText = messierViewModel?.textDescription
        
        messierViewModel?.download(completionHandler: imageCompletionClosure)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.descriptionTextView.setContentOffset(.zero, animated: false)
    }
    
    
    

    

}
