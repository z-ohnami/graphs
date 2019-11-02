//
//  BarView.swift
//  Graph
//
//  Created by Makoto Ohnami on 2019/11/01.
//  Copyright © 2019 Makoto Ohnami. All rights reserved.
//

import UIKit

class BlockView: UIView {
    var fillColor = UIColor.lightGray
//    let lineColor = UIColor.gray
//    let lineWidth:CGFloat = 2.0
    
    override func draw(_ rect: CGRect) {
        let boxRect = bounds
//        boxRect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        
        let drawPath = UIBezierPath(rect: boxRect)
        
        fillColor.setFill()
        drawPath.fill()
        
//        lineColor.setStroke()
//        drawPath.lineWidth = lineWidth
//        drawPath.stroke()
        drawPath.close()
    }

    func addLabel(rate: CGFloat) -> Void {
        let label = UILabel()
        label.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textAlignment = .center
        label.text = "\(rate)%"
        label.textColor = UIColor.white
        addSubview(label)
    }
}
