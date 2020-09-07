//
//  ShortestKnightAlgorithm.swift
//  PDFSearch_POC
//
//  Created by pvharsha on 5/7/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class ShortestKnightAlgorithm: NSObject {
    
    // MARK: - steps calculators
    private func getSquarePath(side:Int64) -> Int64 {
        return Int64((ceil((Double(side))/3))*2)
    }
    
    private func getClimbingPath(height:Int64) -> Int64 {
        let quotient = height/4
        let remainder = height % 4
        return quotient*2 + remainder
    }
    
    func getShortestPath_minimumSteps(x:Int64, y:Int64) -> Int64 {
        var xCordinate = x
        var yCordinate = y
        if xCordinate > yCordinate {
            swap(&xCordinate, &yCordinate)
        }
        if (yCordinate < 2*xCordinate) {
            if (xCordinate == 1 && yCordinate == 1) ||
                (xCordinate == 2 && yCordinate == 2) {
                return 4
            }
            let knight_Ideal_Steps = yCordinate - xCordinate
            return self.getSquarePath(side: (xCordinate - knight_Ideal_Steps)) + knight_Ideal_Steps
        }
        else {
            if (xCordinate == 0 && yCordinate == 1) {
                return 3
            }
            let knight_Ideal_Steps = xCordinate
            return getClimbingPath(height: (yCordinate - 2*xCordinate)) + knight_Ideal_Steps
        }
    }
    
    // MARK: - path calculators
    func swapCGPoint(points:[(Int64, Int64)]) -> [(Int64, Int64)] {
        var swappedPoints:[(Int64, Int64)] = []
        for (x, y) in points {
            swappedPoints.append((y, x))
        }
        return swappedPoints
    }
    
    func getSquareTraverse(from initialPoint:(x:Int64, y:Int64), for side:Int64) -> [(Int64, Int64)] {
        var perfectTraversal_index = side / 3
        
        if side % 3 == 2 {
            perfectTraversal_index -= 1
        }
        
        var destinationPoints:[(Int64, Int64)] = []
        var currentIndex:(x:Int64, y:Int64) = initialPoint
        for _ in 0 ... perfectTraversal_index-1 {
            destinationPoints.append(((currentIndex.x + 1),(currentIndex.y + 2)))
            destinationPoints.append(((currentIndex.x + 3),(currentIndex.y + 3)))
            currentIndex = ((currentIndex.x + 3),(currentIndex.y + 3))
        }
        
        if side % 3 == 1 {
            destinationPoints.append(((currentIndex.x - 1),(currentIndex.y + 2)))
            destinationPoints.append(((currentIndex.x + 1),(currentIndex.y + 1)))
        } else if side % 3 == 2 {
            destinationPoints.append(((currentIndex.x + 1),(currentIndex.y + 2)))
            destinationPoints.append(((currentIndex.x + 2),(currentIndex.y + 4)))
            destinationPoints.append(((currentIndex.x + 4),(currentIndex.y + 3)))
            destinationPoints.append(((currentIndex.x + 5),(currentIndex.y + 5)))
        }

        return destinationPoints
    }
    
    func getClimbingTraverse(from initialPoint:(x:Int64, y:Int64), for height:Int64) -> [(Int64, Int64)] {
        var perfectTraversal_index = height / 4
        
        if height % 4  == 1 {
            perfectTraversal_index -= 1
        }
        
        var destinationPoints:[(Int64, Int64)] = []
        var currentIndex:(x:Int64, y:Int64) = initialPoint
        for _ in 0 ... perfectTraversal_index-1 {
            destinationPoints.append(((currentIndex.x + 1),(currentIndex.y + 2)))
            destinationPoints.append(((currentIndex.x),(currentIndex.y + 4)))
            currentIndex = ((currentIndex.x),(currentIndex.y + 4))
        }
        
        if height % 4 == 1 {
            destinationPoints.append(((currentIndex.x + 1),(currentIndex.y + 2)))
            destinationPoints.append(((currentIndex.x - 1),(currentIndex.y + 3)))
            destinationPoints.append(((currentIndex.x),(currentIndex.y + 5)))
        } else if height % 4 == 2 {
            destinationPoints.append(((currentIndex.x + 2),(currentIndex.y + 1)))
            destinationPoints.append(((currentIndex.x),(currentIndex.y + 2)))
        } else if height % 4 == 3 {
            destinationPoints.append(((currentIndex.x + 1),(currentIndex.y + 2)))
            destinationPoints.append(((currentIndex.x - 1),(currentIndex.y + 1)))
            destinationPoints.append(((currentIndex.x),(currentIndex.y + 3)))
        }
        
        return destinationPoints
    }
    
    func getIdealTraverse(from initialPoint:(x:Int64, y:Int64), for count:Int64) -> [(Int64, Int64)] {
        var destinationPoints:[(Int64, Int64)] = []
        var currentIndex:(x:Int64, y:Int64) = initialPoint
        for _ in 0 ... count-1 {
            destinationPoints.append(((currentIndex.x + 1),(currentIndex.y + 2)))
            currentIndex = ((currentIndex.x + 1),(currentIndex.y + 2))
        }

        return destinationPoints
    }
    
    func getKnightTraversal(destinationPoint:(x:Int64, y:Int64)) -> [(Int64, Int64)] {
        var isCoordinatesSwapped = false
        var xCordinate:Int64 = destinationPoint.x
        var yCordinate:Int64 = destinationPoint.y
        if xCordinate > yCordinate {
            swap(&xCordinate, &yCordinate)
            isCoordinatesSwapped = true
        }
        if (yCordinate < 2*xCordinate) {
            if (xCordinate == 1 && yCordinate == 1) {
                let points:[(Int64, Int64)] = [(1, 2),(3, 1),(2,3),(1,1)]
                if isCoordinatesSwapped {
                    return self.swapCGPoint(points: points)
                } else {
                    return points
                }
            } else if (xCordinate == 2 && yCordinate == 2) {
                let points:[(Int64, Int64)] =  [(1, 2),(3, 1),(1,0),(2,2)]
                if isCoordinatesSwapped {
                    return self.swapCGPoint(points: points)
                } else {
                    return points
                }
            }
            
            let ideal_steps = yCordinate - xCordinate
            let idealTraverseArray:[(Int64, Int64)] = self.getIdealTraverse(from: (0, 0), for: ideal_steps)
            let totalTraverseArray =  idealTraverseArray + self.getSquareTraverse(from: idealTraverseArray.last ?? (0,0), for: (xCordinate - ideal_steps))
            if isCoordinatesSwapped {
                return self.swapCGPoint(points: totalTraverseArray)
            } else {
                return totalTraverseArray
            }
        } else {
            if (xCordinate == 0 && yCordinate == 1) {
                let points:[(Int64, Int64)] =  [(2, 1),(1, 3),(0,1)]
                if isCoordinatesSwapped {
                    return self.swapCGPoint(points: points)
                } else {
                    return points
                }
            }
            let ideal_steps = xCordinate
            let idealTraverseArray:[(Int64, Int64)] = self.getIdealTraverse(from: (0, 0), for: ideal_steps)
            let totalTraverseArray =  idealTraverseArray + self.getClimbingTraverse(from: idealTraverseArray.last ?? (0,0), for: (yCordinate - 2*xCordinate))
            if isCoordinatesSwapped {
                return self.swapCGPoint(points: totalTraverseArray)
            } else {
                return totalTraverseArray
            }
        }
    }
}
