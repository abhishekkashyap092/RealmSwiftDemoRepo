//
//  Specimen.swift
//  RealmSwiftDemoRepo
//
//  Created by Abhishek Kashyap on 13/04/20.
//  Copyright © 2020 Abhishek Kashyap. All rights reserved.
//

import Foundation
import RealmSwift

class Specimen: Object {
  @objc dynamic var name = ""
  @objc dynamic var specimenDescription = ""
  @objc dynamic var latitude = 0.0
  @objc dynamic var longitude = 0.0
  @objc dynamic var created = Date()
  
  @objc dynamic var category: Category!
}
