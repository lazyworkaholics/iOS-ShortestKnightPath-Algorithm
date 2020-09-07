//
//  ShortestKnightPatchTraversalVC.swift
//  Algorithms
//
//  Created by pvharsha on 7/7/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class ShortestKnightPathVC: UITableViewController {
    var destinationPoint:(Int64, Int64)?
    private var pathTraversalArray:[(Int64, Int64)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pathTraversalArray = ShortestKnightAlgorithm().getKnightTraversal(destinationPoint: destinationPoint ?? (0,0))
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pathTraversalArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShortestKnightPathVC_defaultCell", for: indexPath)
        let destinationPoint:(x:Int64, y:Int64) = self.pathTraversalArray[indexPath.row]
        cell.textLabel?.text = String.init(format: "%d , %d", destinationPoint.x, destinationPoint.y)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
