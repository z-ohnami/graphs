//
//  BarView.swift
//  Graph
//
//  Created by Makoto Ohnami on 2019/11/01.
//  Copyright © 2019 Makoto Ohnami. All rights reserved.
//

import UIKit

class BarView: UIView {
    let fillColor = UIColor.blue
    let lineColor = UIColor.red
    let lineWidth:CGFloat = 2.0
    // このグラフシードはクラスで注入できるようにする
    let colorNames = ["EA8940", "62B214", "40ADEA", "4E67D2", "5B265B"]
//    let barLengthRates = [30.0, 0.0, 30.0, 20.0, 20.0]

    var barLengthRates:[GraphBarSeed] = []
    
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

    func drawGraph() -> Void {
        barLengthRates = RandomDivider().call().enumerated().map { GraphBarSeed(rate: $0.element, colorHex: colorNames[$0.offset]) }
        for i in 0..<barLengths().count {
            let block = BlockView()
            block.frame = CGRect(x: 1.0 + takeOffset(i), y: 1.0, width: barLengths()[i], height: 38.0)
            block.fillColor = UIColor(hex: barLengthRates[i].colorHex)
            block.addLabel(rate: barLengthRates[i].rate)
            addSubview(block)
        }
    }

    private func barLengths() -> [CGFloat] {
        // TODO: キャッシュ使うなりなんなり
        let totalLength = frame.width - 2.0
        return barLengthRates.filter { $0.rate > 0.0 }.map { totalLength * CGFloat($0.rate / 100.0) }
    }
    
    private func takeOffset(_ currentIndex:Int) -> CGFloat {
        return barLengths().enumerated().filter { $0.offset < currentIndex }.reduce(0, { sum, len in sum + len.element }) as CGFloat
    }
}
