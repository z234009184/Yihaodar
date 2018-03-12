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
    
    var changeModelClosure: ((GLRadioModel)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func textFieldDidEditing(_ sender: UITextField) {
        model?.input = textField.text
        guard let changeBlock = changeModelClosure else { return }
        guard let m = model else { return }
        changeBlock(m)
    }
    
    var model: GLRadioModel?{
        didSet{
            titleLabel.text = model?.title
            
            
            if model?.isSelected == true {
                selectBtn.isSelected = true
                titleLabel.textColor = UIColor(hex: "19A4FF")
                if model?.isTextFied == true {
                    textFieldHeight.constant = 21
                    textField.isHidden = false
                    textField.text = model?.input
                    textField.placeholder = model?.inputPlaceHolder
                } else {
                    textField.isHidden = true
                    textFieldHeight.constant = 0
                }
            } else {
                selectBtn.isSelected = false
                titleLabel.textColor = UIColor(hex: "99a0aa")
                textField.isHidden = true
                textFieldHeight.constant = 0
            }
            
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
        }
    }
    
}



class GLCheckBoxViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataArray = NSMutableArray()
    var selectArray = [GLRadioModel]()
    var closeClosure: ((_ selecArr: [GLRadioModel])->())?
    private lazy var tableViewHeaderView: UIView = { () -> UIView in
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44))
        view.backgroundColor = .white
        let imageView = UIImageView(image: #imageLiteral(resourceName: "worktable_cell_icon"))
        imageView.center.y = view.center.y
        imageView.frame.origin.x = 0
        view.addSubview(imageView)
        
        let textLabel = UILabel()
        textLabel.text = "以下选项是多选"
        textLabel.textColor = YiUnselectedTitleColor
        textLabel.font = UIFont.systemFont(ofSize: 15)
        textLabel.center.y = imageView.center.y
        textLabel.frame.origin.x = imageView.frame.maxX + 10
        textLabel.sizeToFit()
        view.addSubview(textLabel)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: .done, target: self, action: #selector(GLCheckBoxViewController.sureBtnAction))
    }
    
    @objc func sureBtnAction() {
        
        guard let closure = closeClosure else { return }
        selectArray = (dataArray as! [GLRadioModel]).flatMap({ (radioModel) -> GLRadioModel? in
            if radioModel.isSelected == true {
                return radioModel
            } else {
                return nil
            }
        })
        
        if selectArray.count == 0 {
            view.makeToast("请至少选择一项")
            return
        }
        
        var requireInput = false
        selectArray.forEach { (radioModel) in
            if radioModel.isTextFied && radioModel.input?.isEmpty == true {
                view.makeToast("请输入\(radioModel.title ?? "")")
                requireInput = true
            }
        }
        if requireInput == true { return }
        
        closure(selectArray)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    /// 跳转多选控制器
    public static func jumpMultiVc(title: String?, dataArray: [GLRadioModel], navigationVc: UINavigationController?) -> GLCheckBoxViewController {
        
        let multiVc = UIStoryboard(name: "GLCheckBox", bundle: Bundle.main).instantiateInitialViewController() as! GLCheckBoxViewController
        multiVc.navigationItem.title = title
        multiVc.dataArray = (dataArray as NSArray).mutableCopy() as! NSMutableArray
        navigationVc?.pushViewController(multiVc, animated: true)
        return multiVc
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
        cell.model = dataArray[indexPath.row] as? GLRadioModel
        
        cell.changeModelClosure = { [weak self] (model) in
            self?.dataArray.replaceObject(at: indexPath.row, with: model)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var model = dataArray[indexPath.row] as! GLRadioModel
        model.isSelected = !model.isSelected
        dataArray.replaceObject(at: indexPath.row, with: model)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}
