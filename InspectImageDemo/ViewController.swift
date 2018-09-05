//
//  ViewController.swift
//  InspectImageDemo
//
//  Created by Arnold Lee on 9/5/18.
//  Copyright © 2018 Arnold Lee. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(inspect(_:)))
        myImageView.isUserInteractionEnabled = true
        myImageView.addGestureRecognizer(recognizer)
    }

    let newScrollView = UIScrollView()
    let newImageView = UIImageView()
    let blackBackgroundView = UIView()
    @objc func inspect(_ sender: UITapGestureRecognizer){
        blackBackgroundView.frame = view.frame
        blackBackgroundView.backgroundColor = .black
        blackBackgroundView.alpha = 0
        newScrollView.frame = view.frame
        newScrollView.delegate = self
        newScrollView.minimumZoomScale = 1.0
        newScrollView.maximumZoomScale = 6.0
        newImageView.image = myImageView.image
        newImageView.frame = view.frame
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.alpha = 0
        let newImageViewRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissNewImageView))
        newImageView.isUserInteractionEnabled = true
        newImageView.addGestureRecognizer(newImageViewRecognizer)
        newScrollView.addSubview(newImageView)
        blackBackgroundView.addSubview(newScrollView)
        view.addSubview(blackBackgroundView)
        UIView.animate(withDuration: 0.2, animations: {
            self.blackBackgroundView.alpha = 1
        }) { (success) in
            UIView.animate(withDuration: 0.2, animations: {
                self.newImageView.alpha = 1
            })
        }
    }
    
    @objc func dismissNewImageView(){
        blackBackgroundView.removeFromSuperview()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return newImageView
    }
}

