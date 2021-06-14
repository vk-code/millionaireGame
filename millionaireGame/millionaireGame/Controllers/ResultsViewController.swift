//
//  ResultsViewController.swift
//  millionaireGame
//
//  Created by Vasiliy Kapyshkov on 13.06.2021.
//

import UIKit

class ResultsViewController: UITableViewController {

    private var data: [GameResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GameResultTableViewCell", bundle: nil), forCellReuseIdentifier: "resultRow")
        
        let resultCaretaker = ResultsCaretaker()
        data = resultCaretaker.load()?.reversed() ?? []
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resultRow", for: indexPath) as? GameResultTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: data[indexPath.row])
        
        return cell
    }
}
