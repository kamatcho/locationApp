//
//  ViewController.swift
//  Location Aware
//
//  Created by MOHAMED on 1/14/17.
//  Copyright © 2017 MOHAMED. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var LatitudeLabel: UILabel!
    @IBOutlet weak var LongitudeLabe: UILabel!
    @IBOutlet weak var SpeedLabel: UILabel!
    @IBOutlet weak var CourseLabel: UILabel!
    @IBOutlet weak var AtitudeLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    var manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        LatitudeLabel.text = String(location.coordinate.latitude)
        LongitudeLabe.text = String(location.coordinate.longitude)
        SpeedLabel.text = String(location.speed)
        CourseLabel.text = String(location.course)
        AtitudeLabel.text = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print(error!)
            }else{
                
                if let placemark = placemarks?[0]{
                    var thoroughfare = ""
                    if placemark.thoroughfare != nil {
                        thoroughfare = (placemark.thoroughfare)!
                    }
                    var  subthoroughfare  = ""
                    if placemark.subThoroughfare != nil {
                        subthoroughfare = (placemark.subThoroughfare)!
                    }
                    var sublocality = ""
                    if placemark.subLocality != nil {
                        sublocality = placemark.subLocality!
                    }
                    var subAdministrativeArea = ""
                    
                    if  placemark.subAdministrativeArea != nil {
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                    var postalCode = ""
                    if placemark.postalCode != nil {
                        postalCode = placemark.postalCode!
                    }
                    var country = ""
                    if placemark.country != nil {
                        country = placemark.country!
                    }
                    
                    self.AddressLabel.text = ("\(thoroughfare) \n \(subthoroughfare) \n \(sublocality)\n \(subAdministrativeArea)\n\(postalCode) \n\(country)")
                }

            }

        }
        
        
        
        
    }


}

