//
//  HomePage.swift
//  SmartRun
//
//  Created by Ahmed Jamal Yusuf on 15/02/2019.
//  Copyright © 2019 Ahmed Jamal Yusuf. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomePage: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 3000
    
    private var movement = false
    private var altitude : CLLocationDistance!
    private var gainaltitude : CLLocationDistance = 0
    private var distance = 0.0
    private var firstdistance = 0.0
    private var sumdif = 0.0
    private var speed: Double!
    private var avgspeed: Double = 0.0
    private let distancefilter = 5.0
    private var counter = 0
    private var startLocation: CLLocation?
    private var lastLocation:CLLocation?
    private var time: Int = 0
    private var timer: Timer!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var clock: UILabel!
    @IBOutlet weak var velocity: UILabel!
    @IBOutlet weak var distanceKM: UILabel!
    @IBOutlet weak var averageSpeed: UILabel!
    @IBOutlet weak var altitudeM: UILabel!
    
    @IBOutlet weak var PlayStop: UIButton!
    
    @IBAction func play(_ sender: Any) {
        if movement == false{
            movement = true
            //startTime = Date().timeIntervalSince1970
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTime)), userInfo: nil, repeats: true)
            (sender as AnyObject).setImage(UIImage(named: "stopButton"), for: .normal)
        } else if movement == true{
            (sender as AnyObject).setImage(UIImage(named: "GoButton"), for: .normal)
            timer.invalidate()
            startLocation = nil
            velocity.text? = String(format: "%.1f", 0) + " km/h"
            movement = false
        }
    }
    func updateDisplay(){
        self.updateTime()
        distanceKM.text? = String(format: "%.1f", distance) + " km"
       
        velocity.text? = String(format: "%.1f", speed*3.6) + " km/h"
    }
    
    @IBAction func reset(_ sender: UIButton) {
        if movement == true{
            self.play(PlayStop)
        }
        speed = 0
        firstdistance = 0
        distance = 0
        gainaltitude = 0
        avgspeed = 0
        time = -1
        startLocation = nil
        movement = false
        updateDisplay()
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        self.HideKeyboard()
      
       
    }
    
    
    
    
    func setupLocationManager() {
       // locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    @objc func updateTime(){
        time += 1
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        clock.text? = String(hours) + ":" + String(format: "%02d" ,minutes) + ":" + String(format: "%02d" ,seconds)
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }

    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if movement == true {
            
            speed = manager.location!.speed
            if speed < 0 {
                speed = 0
            }
            velocity.text? = String(format: "%.1f", speed*3.6) + " km/h"
            
            if startLocation == nil {
                startLocation = locations.last
            }else if let lastLocation = locations.last{
                distance += lastLocation.distance(from: startLocation!)/1000
                distanceKM.text? = String(format: "%.1f", distance) + " km"
                startLocation = lastLocation
            }
            
            if counter == 10 && (distance - firstdistance) != 0{
                
                
                firstdistance = distance
            }
            
            
            if time>0 {avgspeed = distance * 3600 / Double(time)}
            averageSpeed.text? = String(format: "%.1f", avgspeed)
        }
        
        if Double((locations.last?.verticalAccuracy)!) > 0.0 {
            if altitude == nil{
                altitude = locations.last?.altitude
            }
            let difal = (locations.last?.altitude)! - altitude
            if counter < 10 {
                counter += 1
                sumdif += difal
            }
            else{
                if sumdif > 0 && movement == true {
                    gainaltitude += sumdif
                    
                }
                counter = 0
                sumdif = 0
            }
            
            altitude = locations.last?.altitude
            altitudeM.text? = String(format: "%.0f", altitude) + " m"
        }
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
