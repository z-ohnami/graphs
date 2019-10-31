//
//  ViewController.swift
//  Graph
//
//  Created by Makoto Ohnami on 2019/10/20.
//  Copyright © 2019 Makoto Ohnami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var graphView: GraphView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // 普通の折れ線グラフ
//        graphView.drawLineGraph()

        // 積み上げグラフ
        graphView.drawStackbarGraph()
    }
}
