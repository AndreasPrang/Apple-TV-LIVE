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
    let overlayView = UIView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
    var urlString = ""
	
    func setURLString(_ string: String) {
        self.urlString = string
    }
	
	func handleGesture(_ gestureRecognizer: UIGestureRecognizer) { }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        overlayView.addSubview(UIImageView(image: UIImage(named: "tv-watermark")))
        contentOverlayView?.addSubview(overlayView)
        
        player = AVPlayer(url: URL(string: urlString)!)
        player?.play()
    }
}
