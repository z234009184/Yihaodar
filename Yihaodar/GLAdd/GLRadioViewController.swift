//
//  GLRadioViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/17.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import HandyJSON

struct GLRadioModel: HandyJSON {
    var id: Int = 0
    var title: String?
    var subTitle: String?
    var isSelected: Bool = false
}


class GLRadioCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitlelabel: UILabel!
    
    var model: GLRadioModel?{
        didSet{
            titleLabel.text = model?.title
            subTitlelabel.text = model?.subTitle
            if model?.isSelected == true {
                titleLabel.textColor = UIColor(hex: "19A4FF")
                subTitlelabel.textColor = UIColor(hex: "19A4FF")
            } else {
                titleLabel.textColor = UIColor(hex: "767E87")
                subTitlelabel.textColor = UIColor(hex: "CBD3DD")
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}





///------------------------------------------------------------------





class GLRadioViewController: UIViewController {
    
    @IBOutlet weak var textField: DesignableTextField!
    @IBOutlet weak var tableView: UITableView!
    var dataArray: [GLRadioModel] = [GLRadioModel]()
    lazy var dataArrayCopy = [GLRadioModel]()
    var closeClosure: ((_ model: GLRadioModel)->())?
    var searchArr = [GLRadioModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArrayCopy = dataArray
        textField.addTarget(self, action: #selector(GLRadioViewController.textFieldDidChange(_:)), for: .editingChanged)
    }
}

extension GLRadioViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        dataArray = dataArrayCopy
        if textField.text?.isEmpty == true {
            tableView.reloadData()
            return true
        }
        
        searchArr.removeAll()
        for value in dataArray {
            if value.title?.contains(textField.text!) == true {
                searchArr.append(value)
            }
        }
        dataArray = searchArr
        tableView.reloadData()
        
        return true
    }
}



extension GLRadioViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GLRadioCell") as? GLRadioCell else { return UITableViewCell() }
        cell.model = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let d = dataArray
        for (index,var value) in d.enumerated() {
            if value.isSelected == true {
                value.isSelected = false
                dataArray.replaceSubrange(Range(index...index), with: [value])
            }
        }
        
        var model = dataArray[indexPath.row]
        model.isSelected = true
        dataArray.replaceSubrange(Range(indexPath.row...indexPath.row), with: [model])
        tableView.reloadData()
        //延时执行
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            guard let closure = self?.closeClosure else { return }
            closure(model)
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
