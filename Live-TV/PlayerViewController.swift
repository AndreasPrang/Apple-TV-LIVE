//
//  PlayerViewController.swift
//  Öffentlich Rechtliche LIVE
//
//  Created by Prang, Andreas on 18.10.15.
//  Copyright © 2015 iSolute-Berlin. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {
    let overlayView = UIView(frame: CGRectMake(50, 50, 200, 200))
    var urlString = ""
	
    func setURLString(string: String) {
        self.urlString = string
    }
	
	func handleGesture(gestureRecognizer: UIGestureRecognizer) { }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        
        overlayView.addSubview(UIImageView(image: UIImage(named: "tv-watermark")))
        contentOverlayView?.addSubview(overlayView)
        
        player = AVPlayer(URL: NSURL(string: urlString)!)
        player?.play()
    }
}