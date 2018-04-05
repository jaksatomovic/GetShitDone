//
//  ViewController.swift
//  GetSh*tDone
//
//  Created by Jaksa Tomovic on 04/04/2018.
//  Copyright © 2018 Jakša Tomović. All rights reserved.
//

import UIKit
import UICountingLabel

class MainController: UIViewController {
    
     var tasks = ["PAY RENT","CALL INSURANCE","DENTIST APP @ 11:45","BOOK FLIGHT","RETURN CLOTHE","BUY MILK", "CALL UNCLE", "ASK BOSS FOR RAISE","PAY RENT","CALL INSURANCE","DENTIST APP @ 11:45","BOOK FLIGHT","RETURN CLOTHE","BUY MILK", "CALL UNCLE", "ASK BOSS FOR RAISE"]
    
    var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.allowsSelection = true
        tv.separatorStyle = .none
        tv.backgroundColor = .black
        tv.estimatedRowHeight = 60
        tv.separatorStyle = .none
        tv.rowHeight = UITableViewAutomaticDimension
        return tv
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "add").withRenderingMode(.alwaysOriginal), for: .normal)
//        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var countingLabel: UICountingLabel = {
        let label = UICountingLabel()
        label.textColor = .red
        label.textAlignment = .center
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 3
        label.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight(rawValue: 16))
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .left
        label.numberOfLines = 1
        label.sizeToFit()
        label.text = "SHITS TO DO"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight(rawValue: 16))
        return label
    }()

    let cellId = "cellId"
    
    var selectedIndexPath: IndexPath?

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(headerView)
        headerView.addSubview(countingLabel)
        headerView.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        headerView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: tableView.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 60)
        countingLabel.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right: nil, topConstant: 7, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 45)
        titleLabel.anchor(countingLabel.topAnchor, left: countingLabel.rightAnchor, bottom: titleLabel.bottomAnchor, right: headerView.rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        tableView.anchor(headerView.bottomAnchor, left: view.leftAnchor, bottom: addButton.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        addButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 24, rightConstant: 0, widthConstant: 45, heightConstant: 45)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        countingLabel.animationDuration = 2
        countingLabel.format = "%d%%";
        countingLabel.text = "\(tasks.count)"
        
    }
}

// MARK: UITableViewDelegate

extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let clearView = UIView()
        clearView.backgroundColor = UIColor.clear
        cell.backgroundColor = .black
        cell.selectedBackgroundView = clearView
        cell.textLabel?.text = tasks[indexPath.row]
        cell.textLabel?.textColor = UIColor(white: 1, alpha: 1)
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight(rawValue: 16))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        print("selected cell at: \(selectedIndexPath as Any)")
        let vc = DetailController()
        vc._title = tasks[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("OK, marked as Closed")
            success(true)
        })
        closeAction.backgroundColor = .purple
        
        return UISwipeActionsConfiguration(actions: [closeAction])
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let modifyAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            success(true)
        })
        modifyAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
        
    }
}

// MARK: ExpandingTransitionPresentingViewController
extension MainController: ExpandingTransitionPresentingViewController
{
    func expandingTransitionTargetViewForTransition(_ transition: ExpandingCellTransition) -> UIView! {
        if let indexPath = selectedIndexPath {
            return tableView.cellForRow(at: indexPath)
        } else {
            return nil
        }
    }
}

