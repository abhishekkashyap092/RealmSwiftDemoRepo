//
//  SpecimenAnnotation .swift
//  RealmSwiftDemoRepo
//
//  Created by Abhishek Kashyap on 13/04/20.
//  Copyright © 2020 Abhishek Kashyap. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class SpecimenAnnotation: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var specimen: Specimen?
  var subtitle: String?
  var title: String?
  
  init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, specimen: Specimen? = nil) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
    self.specimen = specimen
  }
}
