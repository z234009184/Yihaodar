//
//  GLRadioViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/17.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring


class GLRadioCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitlelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
}


class GLRadioViewController: UIViewController {
    
    var dataArray: [Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "选择所属门店"
        
    }
}







extension GLRadioViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GLRadioCell") as? GLRadioCell else { return UITableViewCell() }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
