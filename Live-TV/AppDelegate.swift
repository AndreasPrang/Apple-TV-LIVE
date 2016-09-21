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

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		//		let activityIndicator = UIActivityIndicatorView(frame: window!.frame)
		//		self.window?.rootViewController?.view.addSubview(activityIndicator)
		//		activityIndicator.activityIndicatorViewStyle = .WhiteLarge
		//		activityIndicator.startAnimating()
		
		var stationsDictionary : NSDictionary?// = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("tvStations2", ofType: "plist")!)!
		
		if let oldStationsDictionary = UserDefaults.standard.dictionary(forKey: "TVStations") {
			stationsDictionary = oldStationsDictionary as NSDictionary?
		} else {
			do {
				let jsonData = try? Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "tvStations", ofType: "json")!))
				let JSON = try JSONSerialization.jsonObject(with: jsonData!, options:JSONSerialization.ReadingOptions(rawValue: 0))
				
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
		
		let jsonData = try? Data(contentsOf: URL(string: "https://raw.githubusercontent.com/AndreasPrang/Apple-TV-LIVE/master/Live-TV/tvStations.json")!)
		
		do {
			let JSON = try JSONSerialization.jsonObject(with: jsonData!, options:JSONSerialization.ReadingOptions(rawValue: 0))
			
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

		UserDefaults.standard.set(stationsDictionary, forKey: "TVStations")
		UserDefaults.standard.synchronize()
		
		return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
	
	}

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

