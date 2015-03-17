//
//  ViewController.swift
//  WakerCentral
//
//  Created by Leonardo Edelman Wajnsztok on 12/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit
import CoreLocation


class MainMenuVController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        locationManager.delegate=self;
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    @IBAction func KeepMeAwakeButton(sender: UIButton)
    {
        var feedBackDic: NSMutableDictionary = NSMutableDictionary()
        feedBackDic.setValue("1", forKey: "tap")
        feedBackDic.setValue("0", forKey: "slide")
        feedBackDic.setValue("0", forKey: "wink")
        feedBackDic.setValue("0", forKey: "smile")
        
        let kmavc = KeepMeAwakeVController(nibName: "KeepMeAwakeVController", bundle: nil)
        kmavc.setToVibrate()
        kmavc.setFeedBackTypesAndTimeInterval(feedBackDic, timeInterval: 6)
        self.presentViewController(kmavc, animated: false, completion: nil)
        
    }
    @IBAction func ByThisTimeButton(sender: UIButton)
    {
        let vc = SetModeVController(nibName: "SetModeVController", bundle: nil)
       
        self.presentViewController(vc, animated: false, completion: nil)
        
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if  status == .AuthorizedWhenInUse || status == .AuthorizedAlways{
            manager.startUpdatingLocation()
            // ...
        }
        
        
        println("changed")
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        println("updated")
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            
            
            if (error != nil) {
                
                
                
                println("Error:" + error.localizedDescription)
                
                return
                
                
                
            }
            
            
            
            if placemarks.count > 0 {
                
                
                
                let pm = placemarks[0] as CLPlacemark
                
                self.displayLocationInfo(pm)
                
                
                
            }else {
                
                println("Error with data")
                
            }
            
            
            
        })
        
        
    }
    func displayLocationInfo(placemark: CLPlacemark)
    {
        self.locationManager.stopUpdatingLocation()
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
    }
    
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    //        if segue.identifier == "ToByThisTimeSegue"{
    //            let vc = segue.destinationViewController as ByThisTimeController
    //            vc.waitTime=2;
    //        }
    //    }
    
    
}

