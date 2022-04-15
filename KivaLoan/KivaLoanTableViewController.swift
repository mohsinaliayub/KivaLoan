//
//  KivaLoanTableViewController.swift
//  KivaLoan
//
//  Created by Mohsin Ali Ayub on 15.04.22.
//  Copyright © 2022 AppCoda. All rights reserved.
//

import UIKit

class KivaLoanTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 92.0
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
