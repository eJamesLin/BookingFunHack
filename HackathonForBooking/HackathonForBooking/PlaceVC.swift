//
//  PlaceVC.swift
//  HackathonForBooking
//
//  Created by Andy Yang on 2017/3/11.
//  Copyright © 2017年 Andy Yang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class PlaceVC: UIViewController {

    let AuthorizationKey = "Basic aGFja2VyMjM0OjhocU5XNkh0ZlU="
    let URLToken = "https://distribution-xml.booking.com/json/bookings.getHotels?city_ids=-3875419,-3875418&languagecode=en"
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    
    
    
    var aryData = Array<Dictionary<String, Any>>()
    
    var placeName: String?
    var address: String?
    var location: Dictionary<String, Any>?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPlaceData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPlaceData() {
        
        let header = ["Authorization": self.AuthorizationKey]

        Alamofire.request(self.URLToken, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON{ [weak self] response in
            if let weakSelf = self {
                if (response.result.isSuccess) {
                    if (response.result.value != nil) {
                        let jsonData = JSON(response.result.value!)
                        if let resData = jsonData.arrayObject {
                            let dicData: Dictionary<String, Any> = resData[0] as! Dictionary
                            if let placeName = dicData["name"] as? String,
                                let address = dicData["address"] as? String,
                                let location = dicData["location"] as? Dictionary<String, Any> {
                                weakSelf.placeName = placeName
                                weakSelf.address = address
                                weakSelf.location = location
                                weakSelf.updateUI()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateUI() {
        self.labelTitle.text = self.placeName
        self.labelAddress.text = self.address
        
        if let lat = self.location?["latitude"] as? String,
            let lon = self.location?["longitude"] as? String {
            self.addAnnotations(title: self.placeName!, lat: Double(lat)!, lon: Double(lon)!)
        }
    }
    
    func addAnnotations(title: String, lat: Double, lon: Double) {
        
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
        
        self.mapView.addAnnotations([annotation])
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
}

