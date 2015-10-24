//
//  SenderController.swift
//  Öffentlich Rechtliche LIVE
//
//  Created by Prang, Andreas on 18.10.15.
//  Copyright © 2015 iSolute-Berlin. All rights reserved.
//

import Foundation

class TVStationsController {
//	var stations : NSArray! = NSArray.init(contentsOfFile: NSBundle.mainBundle().pathForResource("tvStations", ofType: "plist")!)
	
	var stationsDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey("TVStations") as! NSDictionary
	
//	var stationsDictionary : NSDictionary = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("tvStations2", ofType: "plist")!)!
	var stationsForSection : NSArray  = []
	
    init() {
//         let newStations = NSArray.init(contentsOfURL: NSURL(string: "http://www.andreasprang.de/AppleTV/tvStations2.plist")!)
    }

	func initWithSection(region: String) -> TVStationsController? {

//		let newStationsDictionary = NSDictionary(contentsOfURL: NSURL(string: "http://www.andreasprang.de/AppleTV/tvStations2.plist")!)
//		
//		if (newStationsDictionary?.allKeys.count > 0) {
//			stationsDictionary = newStationsDictionary!
//		}

		// TODO: Kann schief gehen...
		stationsForSection = stationsDictionary.objectForKey(region) as! NSArray
		
		return self
	}
	
	// MARK: public
	func numberOfTVStations() -> Int {
		return stationsForSection.count
	}
	
	func nameOfTVStation(station: Int) -> String {
		let stationDictionary = stationsForSection[station] as! Dictionary<String, String>
		return stationDictionary["name"]!
	}

	func hlsURLOfTVStation(station: Int) -> String {
		let stationDictionary = stationsForSection[station] as! Dictionary<String, String>
		return stationDictionary["hlsURL"]!
	}

	func imageURLOfTVStation(station: Int) -> String {
		let stationDictionary = stationsForSection[station] as! Dictionary<String, String>
		return stationDictionary["imageURL"]!
	}
}
