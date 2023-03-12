//
//  ViewController.swift
//  SparrowTableView
//
//  Created by Никита Курюмов on 12.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView: UITableView = UITableView()
  
    enum Sections: Hashable {
        case first
    }
   
    var numbers: [Int] = Array(1...30)
    var checkedCells: [Int: Bool] = [:]
    
    var dataSource: UITableViewDiffableDataSource<Sections, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.frame = view.bounds
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(item)"
            
            if let isChecked = self.checkedCells[item], isChecked {
                            cell.accessoryType = .checkmark
                        } else  {
                            cell.accessoryType = .none
                        }
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Int>()
        snapshot.appendSections([.first])
        snapshot.appendItems(numbers)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        title = "Task 4"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "shuffle", style: .done, target: self, action: #selector(shuffle))
        
        
    }
    
    private func reload() {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Int>()
        snapshot.appendSections([.first])
        snapshot.appendItems(numbers, toSection: .first)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc func shuffle() {
        numbers.shuffle()
        reload()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNumber = numbers[indexPath.row]
        numbers.remove(at: indexPath.row)
        numbers.insert(selectedNumber, at: 0)
        checkedCells[selectedNumber] = true
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([selectedNumber])
        snapshot.insertItems([selectedNumber], beforeItem: numbers[1])
        dataSource.apply(snapshot, animatingDifferences: true)
        tableView.reloadData()
    }
}


