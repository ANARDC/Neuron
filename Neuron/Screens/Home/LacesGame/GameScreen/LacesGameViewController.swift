//
//  LacesGameViewController.swift
//  Neuron
//
//  Created by Anar on 04.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit
import SwiftGraph

// MARK: - protocol
protocol LacesGameViewControllerDelegate {
  
}

// MARK: - class
final class LacesGameViewController: UIViewController, LacesGameViewControllerDelegate {
  var configurator : LacesGameConfigurator!
  var presenter    : LacesGamePresenterDelegate!
  
  
  @IBOutlet weak var timerLabel            : UILabel!
  @IBOutlet weak var restartButton         : UIBarButtonItem!
  @IBOutlet weak var eyeletsCollectionView : UICollectionView!
  @IBOutlet var stars                      : [UIImageView]!
  
  var levelNumber: Int!
}

// MARK: - Life Cycle

extension LacesGameViewController {
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = LacesGameConfiguratorImplementation(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
    
    self.graph()
  }
  
  func graph() {
    var lacesGraph = UnweightedGraph<LaceCoordinates>(vertices: [LaceCoordinates(row: 0, column: 0), LaceCoordinates(row: 0, column: 1), LaceCoordinates(row: 0, column: 2),
                                                                 LaceCoordinates(row: 1, column: 0), LaceCoordinates(row: 1, column: 1), LaceCoordinates(row: 1, column: 2),
                                                                 LaceCoordinates(row: 2, column: 0), LaceCoordinates(row: 2, column: 1), LaceCoordinates(row: 2, column: 2)])
    let rowsCount = 3
    let colsCount = 3
    
    for row in 0..<rowsCount {
      for col in 0..<colsCount-1 {
        lacesGraph.addEdge(from: LaceCoordinates(row: row, column: col),
                           to: LaceCoordinates(row: row, column: col+1),
                           directed: false)
      }
    }

    for col in 0..<colsCount {
      for row in 0..<rowsCount-1 {
        lacesGraph.addEdge(from: LaceCoordinates(row: row, column: col),
                           to: LaceCoordinates(row: row+1, column: col),
                           directed: false)
      }
    }
    
    for edge in lacesGraph.edges {
      print(edge)
    }
    
    lacesGraph.removeEdge(UnweightedEdge(u: 0, v: 1, directed: false))
    print("direction: ", lacesGraph.bfs(from: LaceCoordinates(row: 0, column: 0),
                                        to: LaceCoordinates(row: 1, column: 1)))
    
//    let currentLace = LaceCoordinates(row: 1, column: 1)
//
//    print("findAllBfs: ", lacesGraph.findAllBfs(from: currentLace, goalTest: { (laceCoordinate) -> Bool in
//      let maxPath = max(lacesGraph.bfs(from: currentLace, to: laceCoordinate).count,
//                        lacesGraph.dfs(from: currentLace, to: laceCoordinate).count)
//      print(maxPath,
//            lacesGraph.bfs(from: currentLace, to: laceCoordinate).count,
//            lacesGraph.dfs(from: currentLace, to: laceCoordinate).count)
//      return maxPath <= 3
//    }))
//    print("findAllDfs: ", lacesGraph.findAllDfs(from: currentLace, goalTest: { (laceCoordinate) -> Bool in
//      let maxPath = max(lacesGraph.bfs(from: currentLace, to: laceCoordinate).count,
//                        lacesGraph.dfs(from: currentLace, to: laceCoordinate).count)
//      print(maxPath,
//            lacesGraph.bfs(from: currentLace, to: laceCoordinate).count,
//            lacesGraph.dfs(from: currentLace, to: laceCoordinate).count)
//      return maxPath <= 3
//    }))
//
//    print(lacesGraph.detectCycles(upToLength: 3))
  }
}

struct LaceCoordinates: Codable, Equatable {
  let row    : Int
  let column : Int
}
