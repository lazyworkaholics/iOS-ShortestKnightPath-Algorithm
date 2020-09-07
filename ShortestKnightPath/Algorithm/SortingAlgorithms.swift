//
//  SortingAlgorithms.swift
//  Algorithms
//
//  Created by pvharsha on 8/7/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class SortingAlgorithms: NSObject {
    
    func quickSort(unsortedArray:[Double]) -> [Double] {
        if unsortedArray.count <= 1 {
            return unsortedArray
        }
        if unsortedArray.count == 2 {
            var sortedArray = unsortedArray
            if unsortedArray[0] > unsortedArray[1] {
                sortedArray.swapAt(0, 1)
            }
            return unsortedArray
        }
        let pivot = unsortedArray.last!
        var lowerArray:[Double] = []
        var higherArray:[Double] = []
        
        for currentElement:Double in unsortedArray {
            if currentElement < pivot {
                lowerArray.append(currentElement)
            } else {
                higherArray.append(currentElement)
            }
        }
        return (self.quickSort(unsortedArray: lowerArray) + self.quickSort(unsortedArray: higherArray))
    }

}
