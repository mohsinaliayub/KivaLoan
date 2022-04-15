//
//  KivaLoanTableViewController.swift
//  KivaLoan
//
//  Created by Mohsin Ali Ayub on 15.04.22.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit

enum Section {
    case all
}

class KivaLoanTableViewController: UITableViewController {

    private let kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
    private var loans = [Loan]()
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = dataSource
        
        getLatestLoans()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Data Source
    
    private func configureDataSource() -> UITableViewDiffableDataSource<Section, Loan> {
        
        let cellIdentifier = "Cell"
        
        let dataSource = UITableViewDiffableDataSource<Section, Loan>(tableView: tableView) { tableView, indexPath, loan in

            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! KivaLoanTableViewCell
            
            cell.configureCell(with: loan)
            
            return cell
        }
        
        return dataSource
    }
    
    private func updateSnapshot(animatingChange: Bool = false) {
        // create a snapshot and update the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Loan>()
        snapshot.appendSections([.all])
        snapshot.appendItems(loans, toSection: .all)
        
        dataSource.apply(snapshot)
    }

    // MARK: Download Loan Information
    
    private func getLatestLoans() {
        guard let loanUrl = URL(string: kivaLoanURL) else { return }
        
        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                return
            }

            self.loans = self.parseJsonData(data: data)
            
            // Update table view's data
            OperationQueue.main.addOperation {
                self.updateSnapshot()
            }
        }
        task.resume()
    }
    
    private func parseJsonData(data: Data) -> [Loan] {
        var loans = [Loan]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            
            // parse JSON data
            let jsonLoans = jsonResult?["loans"] as! [AnyObject]
            for jsonLoan in jsonLoans {
                let name = jsonLoan["name"] as! String
                let amount = jsonLoan["loan_amount"] as! Int
                let use = jsonLoan["use"] as! String
                let location = jsonLoan["location"] as! [String: AnyObject]
                let country = location["country"] as! String
                
                let loan = Loan(name: name, country: country, use: use, amount: amount)
                loans.append(loan)
            }
        } catch {
            print(error)
        }
        
        return loans
    }

}
