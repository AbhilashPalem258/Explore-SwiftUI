//
//  MergeSort.swift
//  Explore-SwiftUI
//
//  Created by Abhilash Palem on 26/11/22.
//

struct MergeSort<T: Comparable> {
        
    func mergeSort(_ elements: [T]) -> [T] {
        guard elements.count > 1 else {
            return elements
        }
        
        let midIndex = elements.count/2
        
        let leftPile = mergeSort(Array(elements[0..<midIndex]))
        let rightPile = mergeSort(Array(elements[midIndex..<elements.count]))
        
        return mergePile(left: leftPile, right: rightPile)
    }
    
    private func mergePile(left: [T], right: [T]) -> [T] {
        
        var leftIndex: Int = 0, rightIndex: Int = 0
        var result = [T]()
        
        while leftIndex < left.count, rightIndex < right.count {
            let leftItem = left[leftIndex]
            let rightItem = right[rightIndex]
            
            if leftItem < rightItem {
                result.append(leftItem)
                leftIndex += 1
            } else if rightItem < leftItem {
                result.append(rightItem)
                rightIndex += 1
            } else {
                result.append(leftItem)
                leftIndex += 1
                result.append(rightItem)
                rightIndex += 1
            }
        }
        
        while leftIndex < left.count {
            result.append(left[leftIndex])
            leftIndex += 1
        }
        
        while rightIndex < right.count {
            result.append(right[rightIndex])
            rightIndex += 1
        }
        
        return result
    }
}
