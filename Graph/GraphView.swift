//
//  GraphView.swift
//  Graph
//
//  Created by Makoto Ohnami on 2019/10/20.
//  Copyright © 2019 Makoto Ohnami. All rights reserved.
//

import UIKit

class GraphView: UIView {
    let lineWidth:CGFloat = 2.0
    let fillColor = UIColor.yellow
    let lineColor = UIColor.red

    func drawLineGraph() {
        let stroke1 = LineStroke(graphPoints: [1, 3, 1, 4, 9, 12, 4])
        
        let stroke2 = LineStroke(graphPoints: [3, nil, 6, 4, 4])
        
        stroke1.color = UIColor.cyan
        stroke2.color = UIColor.magenta
        
        let graphFrame = LineStrokeGraphFrame(strokes: [stroke1, stroke2])
        
        let lineGraphView = UIView(frame: CGRect(x: 0, y: 20, width: frame.width, height: 200))
        lineGraphView.backgroundColor = UIColor.gray
        lineGraphView.addSubview(graphFrame)
        
        addSubview(lineGraphView)
    }

    func drawStackbarGraph() {
        let bar1 = BarView()
        bar1.frame = CGRect(x: 10.0, y: 10.0, width: frame.width - 20.0, height: 200.0)
        addSubview(bar1)
    }
}

protocol GraphObject {
    var view: UIView { get }
}

extension GraphObject {
    var view: UIView {
        return self as! UIView
    }
    
    func drawLine(from: CGPoint, to: CGPoint) {
        let linePath = UIBezierPath()
        
        linePath.move(to: from)
        linePath.addLine(to: to)
        
        linePath.lineWidth = 0.5
        
        let color = UIColor.white
        color.setStroke()
        linePath.stroke()
        linePath.close()
    }
}

protocol GraphFrame: GraphObject {
    var strokes: [GraphStroke] { get }
}

extension GraphFrame {
    // 保持しているstrokesの中で最大値
    var yAxisMax: CGFloat {
        return strokes.map{ $0.graphPoints }.flatMap{ $0 }.compactMap{ $0 }.max()!
    }
    
    // 保持しているstrokesの中でいちばん長い配列の長さ
    var xAxisPointsCount: Int {
        return strokes.map{ $0.graphPoints.count }.max()!
    }
    
    // X軸の点と点の幅
    var xAxisMargin: CGFloat {
        return view.frame.width/CGFloat(xAxisPointsCount)
    }
}

class LineStrokeGraphFrame: UIView, GraphFrame {
    var strokes = [GraphStroke]()
    
    convenience init(strokes: [GraphStroke]) {
        self.init()
        self.strokes = strokes
    }
    
    override func didMoveToSuperview() {
        if self.superview == nil { return }
        self.frame.size = self.superview!.frame.size
        self.view.backgroundColor = UIColor.clear
        
        strokeLines()
    }
    
    func strokeLines() {
        for stroke in strokes {
            self.addSubview(stroke as! UIView)
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawTopLine()
        drawBottomLine()
        drawVerticalLines()
    }
    
    func drawTopLine() {
        self.drawLine(
            from: CGPoint(x: 0, y: frame.height),
            to: CGPoint(x: frame.width, y: frame.height)
        )
    }
    
    func drawBottomLine() {
        self.drawLine(
            from: CGPoint(x: 0, y: 0),
            to: CGPoint(x: frame.width, y: 0)
        )
    }
    
    func drawVerticalLines() {
        for i in 1..<xAxisPointsCount {
            let x = xAxisMargin*CGFloat(i)
            self.drawLine(
                from: CGPoint(x: x, y: 0),
                to: CGPoint(x: x, y: frame.height)
            )
        }
    }
}


protocol GraphStroke: GraphObject {
    var graphPoints: [CGFloat?] { get }
}

extension GraphStroke {
    var graphFrame: GraphFrame? {
        return ((self as! UIView).superview as? GraphFrame)
    }
    
    var graphHeight: CGFloat {
        return view.frame.height
    }
    
    var xAxisMargin: CGFloat {
        return graphFrame!.xAxisMargin
    }
    
    var yAxisMax: CGFloat {
        return graphFrame!.yAxisMax
    }
    
    // indexからX座標を取る
    func getXPoint(index: Int) -> CGFloat {
        return CGFloat(index) * xAxisMargin
    }
    
    // 値からY座標を取る
    func getYPoint(yOrigin: CGFloat) -> CGFloat {
        let y: CGFloat = yOrigin/yAxisMax * graphHeight
        return graphHeight - y
    }
}


class LineStroke: UIView, GraphStroke {
    var graphPoints = [CGFloat?]()
    var color = UIColor.white
    
    convenience init(graphPoints: [CGFloat?]) {
        self.init()
        self.graphPoints = graphPoints
    }
    
    override func didMoveToSuperview() {
        if self.graphFrame == nil { return }
        self.frame.size = self.graphFrame!.view.frame.size
        self.view.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        let graphPath = UIBezierPath()
        
        graphPath.move(
            to: CGPoint(x: getXPoint(index: 0), y: getYPoint(yOrigin: graphPoints[0] ?? 0))
        )
        
        for (index, graphPoint) in graphPoints.enumerated() {
            if graphPoint == nil { continue }
            let nextPoint = CGPoint(x: getXPoint(index: index),
                                    y: getYPoint(yOrigin: graphPoint!))
            graphPath.addLine(to: nextPoint)
        }
        
        graphPath.lineWidth = 5.0
        color.setStroke()
        graphPath.stroke()
        graphPath.close()
    }
}
