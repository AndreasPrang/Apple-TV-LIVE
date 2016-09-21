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
	
	fileprivate var stationsNSDictionary = UserDefaults.standard.dictionary(forKey: "TVStations")
	fileprivate var stationsDictionary : Dictionary<String, Array<AnyObject>>? = Dictionary<String, Array<AnyObject>>()
	
	class var sharedInstance: TVStationsController {
		return _sharedInstance
	}

	fileprivate init()
	{
		stationsDictionary = stationsNSDictionary as? Dictionary<String, Array<AnyObject>>
	}
	
	// MARK: public
	func regions() -> Array<String>
	{
		return Array(stationsDictionary!.keys)
	}
	
	func numberOfTVStationsInRegion(_ region: String) -> Int
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
	
	func nameOfTVStationInRegion(_ region: String, station: Int) -> String
	{
		let stationDictionary = stationsDictionary![region]![station] as! Dictionary<String, String>
		return stationDictionary["name"]!
	}

	func hlsURLOfTVStationInRegion(_ region: String, station: Int) -> String
	{
		let stationDictionary = stationsDictionary![region]![station] as! Dictionary<String, String>
		return stationDictionary["hlsURL"]!
	}

	func imageURLOfTVStationInRegion(_ region: String, station: Int) -> String
	{
		let stationDictionary = stationsDictionary![region]![station] as! Dictionary<String, String>
		return stationDictionary["imageURL"]!
	}
}
