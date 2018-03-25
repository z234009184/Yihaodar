//
//  GLTaskDetailGPSViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/3/25.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import XLPagerTabStrip

class GLTaskDetailItemCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
}




class GL基本信息TableViewController: UITableViewController {
    
    fileprivate let GLTaskDetailItemCellId = "GLTaskDetailItemCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GLTaskDetailItemCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: GLTaskDetailItemCellId)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GLTaskDetailItemCellId) else {
            return Bundle.main.loadNibNamed("GLTaskDetailItemCell", owner: nil, options: nil)?.first as! GLTaskDetailItemCell
        }
        
        
        
        return cell
    }
    
}







class GLTaskDetailGPSViewController: GLButtonBarPagerTabStripViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var typeButton: UIButton!
    
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var submitBtn: DesignableButton!
    
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
    /// 列表cell模型
    var model: GLWorkTableModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "任务详情"
        
    }
    
    
    @IBAction func submitBtnClick(_ sender: DesignableButton) {
        
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        return [basicVc, basicVc2]
    }
    
    lazy var basicVc = { () -> GL基本信息TableViewController in
       let basicVc = UIStoryboard(name: "GLTaskDetailGPS", bundle: Bundle.main).instantiateViewController(withIdentifier: "GL基本信息ViewController") as! GL基本信息TableViewController
        return basicVc
    }()
    
    lazy var basicVc2 = { () -> GL基本信息TableViewController in
        let basicVc = UIStoryboard(name: "GLTaskDetailGPS", bundle: Bundle.main).instantiateViewController(withIdentifier: "GL基本信息ViewController") as! GL基本信息TableViewController
        return basicVc
    }()
    
}
