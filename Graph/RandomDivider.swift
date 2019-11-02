//
//  RandomDivider.swift
//  Graph
//
//  Created by Makoto Ohnami on 2019/11/02.
//  Copyright © 2019 Makoto Ohnami. All rights reserved.
//

import UIKit

class RandomDivider {
    let total:CGFloat = 100.0

    func call() -> [CGFloat] {
        var numbers:[CGFloat] = [0.0, 0.0, 0.0, 0.0, 0.0]
        for _ in 0..<100 {
            let index = Int.random(in: 0..<5)
            numbers[index] = numbers[index] + 1.0
        }
        return numbers
    }
}
