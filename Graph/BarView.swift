//
//  BarView.swift
//  Graph
//
//  Created by Makoto Ohnami on 2019/11/01.
//  Copyright © 2019 Makoto Ohnami. All rights reserved.
//

import UIKit

class BarView: UIView {
    let fillColor = UIColor.yellow
    let lineColor = UIColor.red
    let lineWidth:CGFloat = 2.0

    override func draw(_ rect: CGRect) {
        let boxRect = bounds
        boxRect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        
        let drawPath = UIBezierPath(rect: boxRect)
        
        fillColor.setFill()
        drawPath.fill()
        
        lineColor.setStroke()
        drawPath.lineWidth = lineWidth
        drawPath.stroke()
        drawPath.close()
    }
}
