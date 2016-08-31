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

	private let reuseIdentifier = "SenderCollectionViewCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
	
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
	
	override func viewDidAppear(animated: Bool)
	{
		self.collectionView?.backgroundColor = UIColor.clearColor()
	}
	
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
	{
		self.collectionView?.delegate = self
		
		return 1;
	}
	
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
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
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SenderCollectionViewCell
		let tvStationsControllerInstance = tvStationsController()
		
		if let _ = tvStationsControllerInstance
		{
			let imageURLString = tvStationsControllerInstance!.imageURLOfTVStationInRegion(region, station: indexPath.row)
			let imageURL = NSURL(string: imageURLString)
			
			let tmpDir = NSTemporaryDirectory()
			let imageURLmd5Value = md5(string: imageURLString)
			let tmpFileURL = tmpDir + imageURLmd5Value
			
			if let imageData = NSData(contentsOfFile: tmpFileURL)
			{
				cell.imageView.image = UIImage(data: imageData)
			}
			else
			{
				let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
				dispatch_async(dispatch_get_global_queue(priority, 0))
					{
					let imageData = NSData(contentsOfURL: imageURL!)
					dispatch_async(dispatch_get_main_queue())
						{
						if (imageData != nil)
						{
							imageData?.writeToFile(tmpFileURL, atomically: true)
							cell.imageView.image = UIImage(data: imageData!)
						}
					}
				}
			}
			cell.titleLabel.text = tvStationsControllerInstance!.nameOfTVStationInRegion(region, station: indexPath.row)
			cell.backgroundColor = UIColor.clearColor()
		}

		return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
	{
        
        let playerViewController = PlayerViewController()
		playerViewController.urlString = tvStationsController()!.hlsURLOfTVStationInRegion(region, station: indexPath.row)
		
        self.tabBarController?.presentViewController(playerViewController, animated: true, completion: { () -> Void in
			
		})
    }

	override func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {

		if let previouslyFocusedIndexPath = context.previouslyFocusedIndexPath {
			let nextCell = self.collectionView?.cellForItemAtIndexPath(previouslyFocusedIndexPath) as! SenderCollectionViewCell
			UIView.animateWithDuration(0.6, animations: { () -> Void in
				nextCell.backgroundColor = UIColor.clearColor()
			})
			
		}
		
		if let nextFocusedIndexPath = context.nextFocusedIndexPath {
			let oldCell = self.collectionView?.cellForItemAtIndexPath(nextFocusedIndexPath) as? SenderCollectionViewCell
			UIView.animateWithDuration(0.6, animations: { () -> Void in
				oldCell?.backgroundColor = UIColor.lightGrayColor()
			})
			
		}
	}
	
	override func collectionView(collectionView: UICollectionView, shouldUpdateFocusInContext context: UICollectionViewFocusUpdateContext) -> Bool {
		
		return true
	}
	
	override func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
//		collectionView.backgroundColor = UIColor.lightGrayColor()
	}
	

	override func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
		
	}
	
	//MARK: helper
	func md5(string string: String) -> String {
		var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
		if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
			CC_MD5(data.bytes, CC_LONG(data.length), &digest)
		}
		
		var digestHex = ""
		for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
			digestHex += String(format: "%02x", digest[index])
		}
		
		return digestHex
	}
}