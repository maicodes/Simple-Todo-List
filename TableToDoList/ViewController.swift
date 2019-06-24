//
//  ViewController.swift
//  TableToDoList
//
//  Created by Mai Le on 6/7/19.
//  Copyright © 2019 mdl160. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var items : Array<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = "To-Do List"
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: "Header")
        
        tableView.sectionHeaderHeight = 60
        
       // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Insert", style: .plain, target: self, action: #selector(insert))
        
        
        // Do any additional setup after loading the view.
    }
    
//    @objc func insert() {
//
//        let row = items.count - 1 < 0 ? 0 : items.count
//        let indexPathForRow = NSIndexPath(row: row, section: 0)
//
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! HeaderCell
//        let newTask = header.insertNewTask()
//        items.append(newTask)
//        tableView.insertRows(at: [indexPathForRow as IndexPath], with: .left)
//
//    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.taskLabel.text = items[indexPath.row]
        
        cell.tableViewController = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! HeaderCell
        header.tableViewController = self
        return header
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func deleteCell (_ cell : UITableViewCell) {
        
        if let deletionIndexPath = tableView.indexPath(for: cell) {
             items.remove(at: deletionIndexPath.row)
             tableView.deleteRows(at: [deletionIndexPath], with: .fade)
        }
        
       
        return
    }
    
    func insertCell (_ newTask : String ) {
        let row = items.count - 1 < 0 ? 0 : items.count
        let indexPathForRow = NSIndexPath(row: row, section: 0)
        
        items.append(newTask)
        
        tableView.insertRows(at: [indexPathForRow as IndexPath], with: .left)
        
    }

    
}


class HeaderCell : UITableViewHeaderFooterView {
    
    var tableViewController : TableViewController?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    var taskTextField : UITextField = {
            var textField = UITextField()
            
            textField.placeholder = "Enter New Task!"
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            textField.borderStyle = .roundedRect
            
            return textField
    
    }()
    
    var insertButton : UIButton = {
        
        var button = UIButton(type: .system)
        
        button.setTitle("Insert", for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    func setupViews() {
        addSubview(taskTextField)
        addSubview(insertButton)
       
        insertButton.addTarget(self, action: #selector(insertNewTask), for: .touchUpInside)
        //                      Vertical Constraints
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: taskTextField)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: insertButton)
        
        //                      Horizontal Constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1]-16-|", views: taskTextField, insertButton)
  
    }
    
    @objc func insertNewTask(){
        
        tableViewController?.insertCell( taskTextField.text ?? "nil")
        
    }

}

class TableViewCell : UITableViewCell {
    
    var tableViewController : TableViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var deleteButton : UIButton = {
        
        var button = UIButton(type: .system)
        
        button.setTitle("Delete", for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    
    var taskLabel : UILabel = {
        
        var label = UILabel()
        
        label.text = "HelloWorld!"
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupView() {
        addSubview(taskLabel)
        
        addSubview(deleteButton)
        
        
        deleteButton.addTarget(self, action: #selector(actionHandler), for: .touchUpInside)
        
        
        //                      Vertical Constraints
        addConstraintsWithFormat(format: "V:|[v0]|", views: taskLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: deleteButton)
        
        
        //                      Horizontal Constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-8-[v1(80)]-16-|", views: taskLabel, deleteButton)
        
//        taskLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
//        taskLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 8.0)
    }
    
    @objc func actionHandler () {
        tableViewController?.deleteCell(self)
    }
}

extension UIColor {
    
    convenience init(_ red : CGFloat, _ green: CGFloat, _ blue: CGFloat ){
        self.init(displayP3Red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format : String, views: UIView...){
        var viewDictionary = [String : UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
        
    }
}
