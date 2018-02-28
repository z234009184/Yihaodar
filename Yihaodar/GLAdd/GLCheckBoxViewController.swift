//
//  GLCheckBoxViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/2/26.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring



class GLCheckBoxCell: UITableViewCell {
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    var model: GLRadioModel?{
        didSet{
            titleLabel.text = model?.title
            
            if model?.inputPlaceHolder != nil {
                textFieldHeight.constant = 21
                textField.isHidden = false
            } else {
                textField.isHidden = true
                textFieldHeight.constant = 0
            }
            
            if model?.isSelected == true {
                selectBtn.isSelected = true
                titleLabel.textColor = UIColor(hex: "19A4FF")
            } else {
                selectBtn.isSelected = false
                titleLabel.textColor = UIColor(hex: "99a0aa")
            }
        }
    }
    
}



class GLCheckBoxViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataArray = [GLRadioModel]() {
        didSet {
            
        }
    }
    var selectArray = [GLRadioModel]()
    var closeClosure: ((_ selecArr: [GLRadioModel])->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: .done, target: self, action: #selector(GLCheckBoxViewController.sureBtnAction))
    }
    
    @objc func sureBtnAction() {
        //延时执行
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            guard let closure = self?.closeClosure else { return }
            self?.selectArray.removeAll()
            self?.dataArray.enumerated().forEach { (index, obj) in
                if obj.isSelected == true {
                    self?.selectArray.append(obj)
                }
            }
            closure((self?.selectArray)!)
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}
extension GLCheckBoxViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GLCheckBoxCell") as? GLCheckBoxCell else {
            return UITableViewCell()
        }
        cell.model = dataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model = dataArray[indexPath.row]
        model.isSelected = !model.isSelected
        dataArray.replaceSubrange(Range(indexPath.row...indexPath.row), with: [model])
        tableView.reloadData()
    }
    
}
