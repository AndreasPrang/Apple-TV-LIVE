//
//  SenderController.swift
//  Öffentlich Rechtliche LIVE
//
//  Created by Prang, Andreas on 18.10.15.
//  Copyright © 2015 iSolute-Berlin. All rights reserved.
//

import Foundation

private let _sharedInstance = TVStationsController()

class TVStationsController {
	
	private var stationsNSDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey("TVStations")
	private var stationsDictionary : Dictionary<String, Array<AnyObject>>? = Dictionary<String, Array<AnyObject>>()
	
	class var sharedInstance: TVStationsController {
		return _sharedInstance
	}

	private init()
	{
		stationsDictionary = stationsNSDictionary as? Dictionary<String, Array<AnyObject>>
	}
	
	// MARK: public
	func regions() -> Array<String>
	{
		return Array(stationsDictionary!.keys)
	}
	
	func numberOfTVStationsInRegion(region: String) -> Int
	{
		if let _ = stationsDictionary
		{
			let stations = stationsDictionary![region]
			return (stations!.count)
		}
		else
		{
			return 0
		}
	}
	
	func nameOfTVStationInRegion(region: String, station: Int) -> String
	{
		let stationDictionary = stationsDictionary![region]![station] as! Dictionary<String, String>
		return stationDictionary["name"]!
	}

	func hlsURLOfTVStationInRegion(region: String, station: Int) -> String
	{
		let stationDictionary = stationsDictionary![region]![station] as! Dictionary<String, String>
		return stationDictionary["hlsURL"]!
	}

	func imageURLOfTVStationInRegion(region: String, station: Int) -> String
	{
		let stationDictionary = stationsDictionary![region]![station] as! Dictionary<String, String>
		return stationDictionary["imageURL"]!
	}
}
