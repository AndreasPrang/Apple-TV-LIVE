//
//  AppDelegate.swift
//  Öffentlich Rechtliche LIVE
//
//  Created by Prang, Andreas on 18.10.15.
//  Copyright © 2015 iSolute-Berlin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		//		let activityIndicator = UIActivityIndicatorView(frame: window!.frame)
		//		self.window?.rootViewController?.view.addSubview(activityIndicator)
		//		activityIndicator.activityIndicatorViewStyle = .WhiteLarge
		//		activityIndicator.startAnimating()
		
		var stationsDictionary : NSDictionary?// = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("tvStations2", ofType: "plist")!)!
		
		if let oldStationsDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey("TVStations") {
			stationsDictionary = oldStationsDictionary
		} else {
			do {
				let jsonData = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("tvStations", ofType: "json")!)
				let JSON = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:NSJSONReadingOptions(rawValue: 0))
				
				if let JSONDictionary :NSDictionary = JSON as? NSDictionary {
					stationsDictionary = JSONDictionary
				}
				else {
					print("Not a Dictionary")
				}
			}
			catch let JSONError as NSError {
				print("\(JSONError)")
			}
		}
		
		let jsonData = NSData(contentsOfURL: NSURL(string: "http://www.andreasprang.de/AppleTV/tvStations.json")!)
		
		do {
			let JSON = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:NSJSONReadingOptions(rawValue: 0))
			
			if let jsonDictionary :NSDictionary = JSON as? NSDictionary {
				stationsDictionary = jsonDictionary
			}
			else {
				print("Not a Dictionary")
			}
		}
		catch let JSONError as NSError {
			print("\(JSONError)")
		}

		NSUserDefaults.standardUserDefaults().setObject(stationsDictionary, forKey: "TVStations")
		NSUserDefaults.standardUserDefaults().synchronize()

//		UIView.animateWithDuration(1, animations: { () -> Void in
//			activityIndicator.alpha = 0
//			}) { (Bool) -> Void in
//				activityIndicator.removeFromSuperview()
//		}
//		
		
		
		return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
	
	}

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

