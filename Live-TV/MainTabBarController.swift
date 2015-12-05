//
//  MainTabBarController.swift
//  LIVE-TV
//
//  Created by Prang, Andreas on 23.10.15.
//  Copyright © 2015 iSolute-Berlin. All rights reserved.
//

import UIKit
import AVKit

class MainTabBarController : UITabBarController {

	//MARK: Vars
	let selectedTabKey = "selectedTabKey"
	
	//MARK: Private
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
		var newViewControllers = [UIViewController]()
		var i = 0
		
		for region in TVStationsController.sharedInstance.regions()
		{
			let vc = mainStoryBoard.instantiateViewControllerWithIdentifier("CollectionView") as! ViewController
			
			vc.tabBarItem = UITabBarItem(title: region, image: nil, tag: i)
			vc.region = region
			newViewControllers.append(vc)
			i++
		}
		
		self.viewControllers = newViewControllers
	}
	
	
	override func viewDidAppear(animated: Bool)
	{
		let selectedTab = NSUserDefaults.standardUserDefaults().integerForKey(selectedTabKey)

		self.selectedIndex = selectedTab
	}
	
	override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem)
	{
		let selectedTab = tabBar.items?.indexOf(item)
		NSUserDefaults.standardUserDefaults().setInteger(selectedTab!, forKey: "selectedTabKey")
		NSUserDefaults.standardUserDefaults().synchronize()
	}

}

