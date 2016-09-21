//
//  ViewController.swift
//  Öffentlich Rechtliche LIVE
//
//  Created by Prang, Andreas on 18.10.15.
//  Copyright © 2015 iSolute-Berlin. All rights reserved.
//

//import Foundation


import UIKit
import AVKit

class ViewController : UICollectionViewController {
 
	internal var region : String = "German"

	fileprivate let reuseIdentifier = "SenderCollectionViewCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
	
	var tvStationsControllerInstance : TVStationsController?
	
	func tvStationsController() -> TVStationsController?
	{
		if let _ = self.tvStationsControllerInstance {

			return self.tvStationsControllerInstance!
		}
		_ = self.title!
		self.tvStationsControllerInstance = TVStationsController.sharedInstance
		
		return self.tvStationsControllerInstance
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		self.collectionView?.backgroundColor = UIColor.clear
	}
	
    override func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		self.collectionView?.delegate = self
		
		return 1;
	}
	
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		let tvStationsControllerInstance = tvStationsController()
		if let _ = tvStationsControllerInstance {
			let numberOfItems = tvStationsControllerInstance!.numberOfTVStationsInRegion(region)
			return numberOfItems
		}
		else
		{
			return 0
		}
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SenderCollectionViewCell
		let tvStationsControllerInstance = tvStationsController()
		
		if let _ = tvStationsControllerInstance
		{
			let imageURLString = tvStationsControllerInstance!.imageURLOfTVStationInRegion(region, station: (indexPath as NSIndexPath).row)
			let imageURL = URL(string: imageURLString)
			
			let tmpDir = NSTemporaryDirectory()
			let imageURLmd5Value = md5(string: imageURLString)
			let tmpFileURL = tmpDir + imageURLmd5Value
			
			if let imageData = try? Data(contentsOf: URL(fileURLWithPath: tmpFileURL))
			{
				cell.imageView.image = UIImage(data: imageData)
			}
			else
			{
				let priority = DispatchQueue.GlobalQueuePriority.default
				DispatchQueue.global(priority: priority).async
					{
					let imageData = try? Data(contentsOf: imageURL!)
					DispatchQueue.main.async
						{
						if (imageData != nil)
						{
							try? imageData?.write(to: URL(fileURLWithPath: tmpFileURL), options: [.atomic])
							cell.imageView.image = UIImage(data: imageData!)
						}
					}
				}
			}
			cell.titleLabel.text = tvStationsControllerInstance!.nameOfTVStationInRegion(region, station: (indexPath as NSIndexPath).row)
			cell.backgroundColor = UIColor.clear
		}

		return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
        
        let playerViewController = PlayerViewController()
		playerViewController.urlString = tvStationsController()!.hlsURLOfTVStationInRegion(region, station: (indexPath as NSIndexPath).row)
		
        self.tabBarController?.present(playerViewController, animated: true, completion: { () -> Void in
			
		})
    }

	override func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {

		if let previouslyFocusedIndexPath = context.previouslyFocusedIndexPath {
			let nextCell = self.collectionView?.cellForItem(at: previouslyFocusedIndexPath) as! SenderCollectionViewCell
			UIView.animate(withDuration: 0.6, animations: { () -> Void in
				nextCell.backgroundColor = UIColor.clear
			})
			
		}
		
		if let nextFocusedIndexPath = context.nextFocusedIndexPath {
			let oldCell = self.collectionView?.cellForItem(at: nextFocusedIndexPath) as? SenderCollectionViewCell
			UIView.animate(withDuration: 0.6, animations: { () -> Void in
				oldCell?.backgroundColor = UIColor.lightGray
			})
			
		}
	}
	
	override func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
		
		return true
	}
	
	override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//		collectionView.backgroundColor = UIColor.lightGrayColor()
	}
	

	override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
		
	}
	
	//MARK: helper
	func md5(string: String) -> String {
		var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
		if let data = string.data(using: String.Encoding.utf8) {
			CC_MD5((data as NSData).bytes, CC_LONG(data.count), &digest)
		}
		
		var digestHex = ""
		for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
			digestHex += String(format: "%02x", digest[index])
		}
		
		return digestHex
	}
}
