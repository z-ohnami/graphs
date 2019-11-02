//
//  GraphFieldView.swift
//  Graph
//
//  Created by Makoto Ohnami on 2019/11/01.
//  Copyright © 2019 Makoto Ohnami. All rights reserved.
//

import UIKit

class GraphFieldView: UIView {
    let fillColor = UIColor.lightGray
    let lineColor = UIColor.gray
    let lineWidth:CGFloat = 2.0

    override func didAddSubview(_ subview: UIView) {
//        let bar1 = BarView()
//        bar1.frame = CGRect(x: 10.0, y: 10.0, width: frame.width - 20.0, height: 40.0)
//        addSubview(bar1)
    }
    
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
