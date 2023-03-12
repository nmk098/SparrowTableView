//
//  Numbers.swift
//  SparrowTableView
//
//  Created by Никита Курюмов on 12.03.23.
//

import Foundation
import UIKit

class Numbers {
    var numbers: [Int] = Array(1...30)
    var isSelected: Bool = false
    var selectedImage = UIImage()
    
    func selectRow() {
        if isSelected == true {
            selectedImage = UIImage(systemName: "checkmark")!
        } else {
            return
        }
    }
}
