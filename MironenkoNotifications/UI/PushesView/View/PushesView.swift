//
//  PushesView.swift
//  MironenkoNotifications
//
//  Created by Mironenko Evgeniy on 6/3/20.
//  Copyright © 2020 Mironenko Evgeniy. All rights reserved.
//

import UIKit

class PushesView: UITableViewController, PushesViewProtocol {
        
    var presenter: PushesPresenter?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = self.presenter?.getItemsCount() {
            return count;
        } else {
            return 0;
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = self.presenter?.getPushTitleForIndex(indexPath.row);
        cell?.detailTextLabel?.numberOfLines = 2;
        cell?.detailTextLabel?.text = self.presenter?.getPushBodyValuesForIndex(indexPath.row);

        return cell!
    }
    
    // MARK: - Table view data delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    // MARK: PushesViewProtocol Implementation
    
    func willUpdateData() {
        
    }
    
    func didUpdateData() {
        self.tableView.reloadData();
    }
    
}
