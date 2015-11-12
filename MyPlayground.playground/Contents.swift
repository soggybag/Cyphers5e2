//: Playground - noun: a place where people can play

import UIKit
import GameplayKit


var randomNumbers = [Int]()

for _ in 1...10 {
    randomNumbers.append(GKRandomSource.sharedRandom().nextIntWithUpperBound(10))
}




var array = [[Int]]()


extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

if let item = array[safe: 0] {
    print(item)
} else {
    print("??")
}



for i in randomNumbers {
    if (array[safe: i] != nil) {
        array[i].append(randomNumbers[i])
    } else {
        array.append([randomNumbers[i]])
    }
}

array
