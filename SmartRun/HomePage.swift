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

class HomePage: UIViewController {
    
  /*  private var movement = false
    private var gps = true
    private var altitude : CLLocationDistance!
    private var gainaltitude : CLLocationDistance = 0
    private var distance = 0.0
    private var firstdistance = 0.0
    private var sumdif = 0.0
    private var speed: Double!
    private var avgspeed: Double = 0.0
    private var slope: Double!
    private let distancefilter = 5.0
    private var contador = 0
    private var startLocation: CLLocation?
    private var lastLocation:CLLocation?
    private var time: Int = 0
    private var timer: Timer!
   */
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 3000
  /*
    @IBOutlet weak var tiempo: UILabel!
    
    @IBOutlet weak var velocidad: UILabel!
    
    @IBOutlet weak var distancia: UILabel!
    @IBOutlet weak var pendiente: UILabel!
    @IBOutlet weak var velocidadmedia: UILabel!
    
    @IBOutlet weak var altitudacum: UILabel!
    @IBOutlet weak var altitud: UILabel!
    
    
    @IBOutlet weak var PlayStop: UIButton!
    @IBAction func play(_ sender: UIButton) {
        if movement == false && gps == true{
            movement = true
            //startTime = Date().timeIntervalSince1970
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTime)), userInfo: nil, repeats: true)
            sender.setImage(UIImage(named: "Stop.png"), for: .normal)
        } else if movement == true{
            sender.setImage(UIImage(named: "Play.png"), for: .normal)
            timer.invalidate()
            startLocation = nil
            velocidad.text? = String(format: "%.1f", 0) + " km/h"
            movement = false
        }
    }
    
    func updateDisplay(){
        self.updateTime()
        distancia.text? = String(format: "%.1f", distance) + " km"
        altitudacum.text? = String(format: "%.0f", gainaltitude) + " m"
        velocidadmedia.text? = String(format: "%.1f", avgspeed)
        velocidad.text? = String(format: "%.1f", speed*3.6) + " km/h"
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
        slope = 0
        startLocation = nil
        movement = false
        updateDisplay()
    }
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        configureView()
    }
    
    private func configureView() {
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self as! CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
  /*
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if movement == true{
            
            speed = manager.location!.speed
            if speed < 0 {
                speed = 0
            }
            velocidad.text? = String(format: "%.1f", speed*3.6) + " km/h"
            
            if startLocation == nil {
                startLocation = locations.last
            }else if let lastLocation = locations.last{
                distance += lastLocation.distance(from: startLocation!)/1000
                distancia.text? = String(format: "%.1f", distance) + " km"
                startLocation = lastLocation
            }
            
            if contador == 10 && (distance - firstdistance) != 0{
                slope = sumdif * 0.1 / (distance - firstdistance)
                pendiente.text? = String(format: "%.1f", slope) + "%"
                firstdistance = distance
            }
            
            
            if time>0 {avgspeed = distance * 3600 / Double(time)}
            velocidadmedia.text? = String(format: "%.1f", avgspeed)
        }
        
        if Double((locations.last?.verticalAccuracy)!) > 0.0 {
            if altitude == nil{
                altitude = locations.last?.altitude
            }
            let difal = (locations.last?.altitude)! - altitude
            if contador < 10 {
                contador += 1
                sumdif += difal
            }
            else{
                if sumdif > 0 && movimiento == true {
                    gainaltitude += sumdif
                    altitudacum.text? = String(format: "%.0f", gainaltitude) + " m"
                }
                contador = 0
                sumdif = 0
            }
            
            altitude = locations.last?.altitude
            altitud.text? = String(format: "%.0f", altitude) + " m"
        }
    }
    
    @objc func updateTime(){
        time += 1
        let hours = time / 3600
        let minutes = (time % 3600) / 60
        let seconds = time % 60
        tiempo.text? = String(hours) + ":" + String(format: "%02d" ,minutes) + ":" + String(format: "%02d" ,seconds)
    }
 */
}


extension HomePage: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
