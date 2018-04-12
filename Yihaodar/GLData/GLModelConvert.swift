//
//  GLModelConvert.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/4/12.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import HandyJSON
import SwiftyJSON

class GLModelConvert: NSObject {
    static func basicData(model: GLGPSTaskDetailBigModel) -> [GLSectionModel] {
        var dataArray = [GLSectionModel]()
        
        // 订单信息
        if model.dataAuth.jbxx_ddxx == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "订单信息"
            if model.dataAuth.ddxx_ssmd == true {
                let item = GLItemModel(title: "所属门店", subTitle: model.loanApply.l_store)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.ddxx_khjl == true {
                let item = GLItemModel(title: "客户经理", subTitle: model.loanApply.boss_party_id)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.ddxx_tdzg == true {
                let item = GLItemModel(title: "团队主管", subTitle: model.loanApply.executive_party_id)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.ddxx_ywzj == true {
                let item = GLItemModel(title: "业务总监", subTitle: model.loanApply.director_party_id)
                sectionModel.items.append(item)
            }
            
            dataArray.append(sectionModel)
        }
        
        // 车辆信息
        if model.dataAuth.jbxx_clxx == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "车辆信息"
            
            if model.dataAuth.clxx_czxm == true {
                let item = GLItemModel(title: "车主姓名", subTitle: model.carInfo.ower)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_clhp == true {
                let item = GLItemModel(title: "车辆号牌", subTitle: model.carInfo.goodsCode)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_clpp == true {
                let item = GLItemModel(title: "车辆品牌", subTitle: model.carInfo.brandName)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_clxl == true {
                let item = GLItemModel(title: "车辆系列", subTitle: model.carInfo.goodsSeries)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_clxh == true {
                let item = GLItemModel(title: "车辆型号", subTitle: model.carInfo.goodsStyle)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_clys == true {
                let item = GLItemModel(title: "车辆颜色", subTitle: model.carInfo.carColor)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_ccrq == true {
                let item = GLItemModel(title: "出厂日期", subTitle: model.carInfo.productionDate)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_djrq == true {
                let item = GLItemModel(title: "登记日期", subTitle: model.carInfo.registerDate)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_xslc == true {
                let item = GLItemModel(title: "行驶里程", subTitle: model.carInfo.runNumber)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_pql == true {
                let item = GLItemModel(title: "排气量", subTitle: model.carInfo.displacement)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_dqwzs == true {
                var peccancyStr = "无"
                if model.carInfo.peccancy == "1" {
                    peccancyStr = "罚分:\(model.carInfo.peccancyFraction)分 罚钱:\(model.carInfo.peccancyMoney)元"
                }
                let item = GLItemModel(title: "当前违章", subTitle: peccancyStr)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_fdjhm == true {
                let item = GLItemModel(title: "发动机型号", subTitle: model.carInfo.engineCode)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_cjh == true {
                let item = GLItemModel(title: "车架号", subTitle: model.carInfo.frameCode)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_kpjg == true {
                let item = GLItemModel(title: "开票价格", subTitle: model.carInfo.invoice)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_ghcs == true {
                let item = GLItemModel(title: "过户次数", subTitle: model.carInfo.transferNumber)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_njdqr == true {
                let item = GLItemModel(title: "年检到期日", subTitle: model.carInfo.yearCheck)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_jqx == true {
                let item = GLItemModel(title: "交强险", subTitle: model.carInfo.jqInsurance)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.clxx_syx == true {
                let item = GLItemModel(title: "商业险", subTitle: model.carInfo.syInsurance)
                sectionModel.items.append(item)
            }
            
            dataArray.append(sectionModel)
        }
        
        // 借款申请信息
        if model.dataAuth.jbxx_jksqxx == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "借款申请信息"
            
            if model.dataAuth.jksqxx_jksqje == true {
                let item = GLItemModel(title: "借款申请金额", subTitle: model.loanApply.l_amount + "元")
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.jksqxx_jksqqx == true {
                let item = GLItemModel(title: "借款申请期限", subTitle: model.loanApply.l_term + "月")
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.jksqxx_jksqlx == true {
                let item = GLItemModel(title: "借款申请类型", subTitle: model.loanApply.l_type)
                sectionModel.items.append(item)
            }
            
            if model.dataAuth.jksqxx_jksqdyl == true {
                let item = GLItemModel(title: "借款申请抵押率", subTitle: model.loanApply.l_mortgage_rate)
                sectionModel.items.append(item)
            }
            
            
            dataArray.append(sectionModel)
        }
        
        // 借款人/共借人 信息
        if model.dataAuth.jbxx_jkrxx == true {
            
            for jkrModel in model.loanApply.ltcSet {
                if jkrModel.is_together == "0" { // 借款人信息
                    
                    // 借款人
                    var sectionModel = GLSectionModel()
                    sectionModel.title = "借款人信息"
                    
                    if model.dataAuth.jkrxx_jkrxm == true {
                        let item = GLItemModel(title: "借款人姓名", subTitle: jkrModel.lc.c_name)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_sfzhm == true {
                        let item = GLItemModel(title: "身份证号码", subTitle: jkrModel.lc.c_idcard)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_xb == true {
                        let item = GLItemModel(title: "性别", subTitle: jkrModel.lc.c_sex)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_nl == true {
                        let item = GLItemModel(title: "年龄", subTitle: jkrModel.lc.c_age)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_sjh1 == true {
                        let item = GLItemModel(title: "手机号1", subTitle: jkrModel.lc.c_phone1)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_sjh2 == true {
                        let item = GLItemModel(title: "手机号2", subTitle: jkrModel.lc.c_phone2)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_hj == true {
                        let item = GLItemModel(title: "户籍", subTitle: jkrModel.lc.c_home)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_sfcqjzbj == true {
                        let item = GLItemModel(title: "是否长期居住北京", subTitle: jkrModel.lc.c_isczbj)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_bjjznx == true {
                        let item = GLItemModel(title: "北京居住年限", subTitle: jkrModel.lc.c_bjyear)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_jycd == true {
                        let item = GLItemModel(title: "教育程度", subTitle: jkrModel.lc.c_educational_level_str)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_byyx == true {
                        let item = GLItemModel(title: "毕业院校", subTitle: jkrModel.lc.c_over_school)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_hyzk == true {
                        let item = GLItemModel(title: "婚姻状况", subTitle: jkrModel.lc.c_marital_status_str)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_znzk == true {
                        let item = GLItemModel(title: "子女状况", subTitle: jkrModel.lc.c_children)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_gzxz == true {
                        let item = GLItemModel(title: "工作性质", subTitle: jkrModel.lc.c_nature_of_work_str)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_cshy == true {
                        let item = GLItemModel(title: "从属行业", subTitle: jkrModel.lc.c_industry)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_gzdw == true {
                        let item = GLItemModel(title: "工作单位", subTitle: jkrModel.lc.c_work_company)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_gzdz == true {
                        let item = GLItemModel(title: "工作地址", subTitle: jkrModel.lc.c_work_address)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_zwmc == true {
                        let item = GLItemModel(title: "职位名称", subTitle: jkrModel.lc.c_work_name)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_xjzdz == true {
                        let item = GLItemModel(title: "现居住地址", subTitle: jkrModel.lc.c_address)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_fwly == true {
                        let item = GLItemModel(title: "房屋来源", subTitle: jkrModel.lc.c_house_source)
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_jbysr == true {
                        let item = GLItemModel(title: "基本月收入", subTitle: jkrModel.lc.c_month_income.decimalString() + "元")
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_zhnsr == true {
                        let item = GLItemModel(title: "综合年收入", subTitle: jkrModel.lc.c_year_income.decimalString() + "元")
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_xykzed == true {
                        let item = GLItemModel(title: "信用卡总额度", subTitle: jkrModel.lc.c_credit_card_sum.decimalString() + "万元")
                        sectionModel.items.append(item)
                    }
                    
                    if model.dataAuth.jkrxx_fz == true {
                        let item = GLItemModel(title: "负债", subTitle: jkrModel.lc.c_liabilities.decimalString() + "元")
                        sectionModel.items.append(item)
                    }
                    
                    dataArray.append(sectionModel)
                    
                    
                    // 借款人银行卡信息
                    if model.dataAuth.jbxx_jkryhkxx == true {
                        var sectionModel = GLSectionModel()
                        sectionModel.title = "银行卡信息"
                        
                        if model.dataAuth.jkryhkxx_hm == true {
                            let item = GLItemModel(title: "户名", subTitle: jkrModel.lc.c_card_name)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.jkryhkxx_yhkxx == true {
                            let item = GLItemModel(title: "银行卡信息", subTitle: jkrModel.lc.c_card_code)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.jkryhkxx_khh == true {
                            let item = GLItemModel(title: "开户行", subTitle: jkrModel.lc.c_card_bank)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.jkryhkxx_zhxx == true {
                            let item = GLItemModel(title: "支行信息", subTitle: jkrModel.lc.c_bank_branch)
                            sectionModel.items.append(item)
                        }
                        
                        dataArray.append(sectionModel)
                    }
                    
                    // 借款人紧急联系人信息（多个）
                    if model.dataAuth.jbxx_jkrjjlxrxx == true {
                        
                        for value in jkrModel.lc.lccSet {
                            var sectionModel = GLSectionModel()
                            sectionModel.title = "紧急联系人信息"
                            
                            sectionModel.items.append(GLItemModel(title: "姓名", subTitle: value.con_name))
                            sectionModel.items.append(GLItemModel(title: "联系电话", subTitle: value.con_phone))
                            sectionModel.items.append(GLItemModel(title: "与共借人关系", subTitle: value.con_nexus_str))
                            sectionModel.items.append(GLItemModel(title: "工作单位", subTitle: value.con_work_company))
                            sectionModel.items.append(GLItemModel(title: "联系地址", subTitle: value.con_address))
                            
                            dataArray.append(sectionModel)
                        }
                    }
                    
                } else {
                    // （共借人信息 -> 银行卡信息 -> 紧急联系人信息（多个））（多个）
                    
                    //--------------
                    
                    // 共借人
                    if model.dataAuth.jbxx_gjrxx == true {
                        var sectionModel = GLSectionModel()
                        sectionModel.title = "共借人信息"
                        
                        if model.dataAuth.gjrxx_jkrxm == true {
                            let item = GLItemModel(title: "借款人姓名", subTitle: jkrModel.lc.c_name)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_sfzhm == true {
                            let item = GLItemModel(title: "身份证号码", subTitle: jkrModel.lc.c_idcard)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_xb == true {
                            let item = GLItemModel(title: "性别", subTitle: jkrModel.lc.c_sex)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_nl == true {
                            let item = GLItemModel(title: "年龄", subTitle: jkrModel.lc.c_age)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_sjh1 == true {
                            let item = GLItemModel(title: "手机号1", subTitle: jkrModel.lc.c_phone1)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_sjh2 == true {
                            let item = GLItemModel(title: "手机号2", subTitle: jkrModel.lc.c_phone2)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_hj == true {
                            let item = GLItemModel(title: "户籍", subTitle: jkrModel.lc.c_home)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_sfcqjzbj == true {
                            let item = GLItemModel(title: "是否长期居住北京", subTitle: jkrModel.lc.c_isczbj)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_bjjznx == true {
                            let item = GLItemModel(title: "北京居住年限", subTitle: jkrModel.lc.c_bjyear)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_jycd == true {
                            let item = GLItemModel(title: "教育程度", subTitle: jkrModel.lc.c_educational_level_str)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_byyx == true {
                            let item = GLItemModel(title: "毕业院校", subTitle: jkrModel.lc.c_over_school)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_hyzk == true {
                            let item = GLItemModel(title: "婚姻状况", subTitle: jkrModel.lc.c_marital_status_str)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_znzk == true {
                            let item = GLItemModel(title: "子女状况", subTitle: jkrModel.lc.c_children)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_gzxz == true {
                            let item = GLItemModel(title: "工作性质", subTitle: jkrModel.lc.c_nature_of_work_str)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_cshy == true {
                            let item = GLItemModel(title: "从属行业", subTitle: jkrModel.lc.c_industry)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_gzdw == true {
                            let item = GLItemModel(title: "工作单位", subTitle: jkrModel.lc.c_work_company)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_gzdz == true {
                            let item = GLItemModel(title: "工作地址", subTitle: jkrModel.lc.c_work_address)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_zwmc == true {
                            let item = GLItemModel(title: "职位名称", subTitle: jkrModel.lc.c_work_name)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_xjzdz == true {
                            let item = GLItemModel(title: "现居住地址", subTitle: jkrModel.lc.c_address)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_fwly == true {
                            let item = GLItemModel(title: "房屋来源", subTitle: jkrModel.lc.c_house_source)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_jbysr == true {
                            let item = GLItemModel(title: "基本月收入", subTitle: jkrModel.lc.c_month_income.decimalString() + "元")
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_zhnsr == true {
                            let item = GLItemModel(title: "综合年收入", subTitle: jkrModel.lc.c_year_income.decimalString() + "元")
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_xykzed == true {
                            let item = GLItemModel(title: "信用卡总额度", subTitle: jkrModel.lc.c_credit_card_sum.decimalString() + "万元")
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.gjrxx_fz == true {
                            let item = GLItemModel(title: "负债", subTitle: jkrModel.lc.c_liabilities.decimalString() + "元")
                            sectionModel.items.append(item)
                        }
                        
                        dataArray.append(sectionModel)
                    }
                    
                    // 共借人银行卡信息
                    if model.dataAuth.jbxx_jkryhkxxgjr == true {
                        var sectionModel = GLSectionModel()
                        sectionModel.title = "银行卡信息"
                        
                        if model.dataAuth.jkryhkxxgjr_hm == true {
                            let item = GLItemModel(title: "户名", subTitle: jkrModel.lc.c_card_name)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.jkryhkxxgjr_yhkxx == true {
                            let item = GLItemModel(title: "银行卡信息", subTitle: jkrModel.lc.c_card_code)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.jkryhkxxgjr_khh == true {
                            let item = GLItemModel(title: "开户行", subTitle: jkrModel.lc.c_card_bank)
                            sectionModel.items.append(item)
                        }
                        
                        if model.dataAuth.jkryhkxxgjr_zhxx == true {
                            let item = GLItemModel(title: "支行信息", subTitle: jkrModel.lc.c_bank_branch)
                            sectionModel.items.append(item)
                        }
                        
                        dataArray.append(sectionModel)
                    }
                    
                    // 借款人紧急联系人信息（多个）
                    if model.dataAuth.jbxx_jkrjjlxrxxgjr == true {
                        
                        for value in jkrModel.lc.lccSet {
                            var sectionModel = GLSectionModel()
                            sectionModel.title = "紧急联系人信息"
                            
                            sectionModel.items.append(GLItemModel(title: "姓名", subTitle: value.con_name))
                            sectionModel.items.append(GLItemModel(title: "联系电话", subTitle: value.con_phone))
                            sectionModel.items.append(GLItemModel(title: "与共借人关系", subTitle: value.con_nexus_str))
                            sectionModel.items.append(GLItemModel(title: "工作单位", subTitle: value.con_work_company))
                            sectionModel.items.append(GLItemModel(title: "联系地址", subTitle: value.con_address))
                            
                            dataArray.append(sectionModel)
                        }
                    }
                    
                    
                    
                    
                    //--------------
                }
            }
            
        }
        
        
        
        
        return dataArray
    }
    
}
