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
    
    
    /// 转换基本信息数据
    ///
    /// - Parameter model: 总详情信息
    /// - Returns: 基本信息数据数组
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
                let item = GLItemModel(title: "借款申请金额", subTitle: model.loanApply.l_amount.decimalString() + "元")
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
                        var bjyear = jkrModel.lc.c_bjyear
                        if bjyear.isEmpty == false {
                            bjyear = bjyear + "年"
                        }
                        let item = GLItemModel(title: "北京居住年限", subTitle: bjyear)
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
    
    
    /// 转换评估信息数据
    ///
    /// - Parameter model: 总详情信息
    /// - Returns: 评估数据数组
    static func estimateData(model: GLGPSTaskDetailBigModel) -> [GLSectionModel] {
        var dataArray = [GLSectionModel]()
        
        // 车辆配置
        if model.dataAuth.pgxx_clpz == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "车辆配置"
            
            let carInfo = model.carInfo
            sectionModel.items.append(GLItemModel(title: "变速器", subTitle: carInfo.gearbox))
            sectionModel.items.append(GLItemModel(title: "驱动方式", subTitle: carInfo.drivingType))
            sectionModel.items.append(GLItemModel(title: "有无钥匙启动", subTitle: carInfo.keylessStartup))
            sectionModel.items.append(GLItemModel(title: "定速巡航", subTitle: carInfo.cruiseControl))
            sectionModel.items.append(GLItemModel(title: "导航", subTitle: carInfo.navigation))
            sectionModel.items.append(GLItemModel(title: "后排娱乐", subTitle: carInfo.hpyl))
            sectionModel.items.append(GLItemModel(title: "座椅形式", subTitle: carInfo.chairType))
            sectionModel.items.append(GLItemModel(title: "燃油方式", subTitle: carInfo.fuelType))
            sectionModel.items.append(GLItemModel(title: "天窗", subTitle: carInfo.skylight))
            sectionModel.items.append(GLItemModel(title: "空调配置", subTitle: carInfo.airConditioner))
            sectionModel.items.append(GLItemModel(title: "其他", subTitle: carInfo.Other))
            sectionModel.items.append(GLItemModel(title: "事故", subTitle: carInfo.accident))
            
            dataArray.append(sectionModel)
        }
        
        
        // 车况描述
        if model.dataAuth.pgxx_ckms == true {
            
            for carConfigModel in model.carinfodata {
                var sectionModel = GLSectionModel()
                sectionModel.title = "车况描述"
                
                sectionModel.items.append(GLItemModel(title: "车构件", subTitle: carConfigModel.partsOneId))
                sectionModel.items.append(GLItemModel(title: "部件", subTitle: carConfigModel.partsTwoId))
                sectionModel.items.append(GLItemModel(title: "描述", subTitle: carConfigModel.accidentType))
                sectionModel.items.append(GLItemModel(title: "备注", subTitle: carConfigModel.remarks))
                
                dataArray.append(sectionModel)
            }
        }
        
        
        // 评估师
        if model.dataAuth.pgxx_pgjg == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "评估结果"
            
            let carInfo = model.carInfo
            sectionModel.items.append(GLItemModel(title: "评估师", subTitle: carInfo.assessmentName))
            sectionModel.items.append(GLItemModel(title: "评估价格", subTitle: carInfo.confirmedMoney.decimalString() + "万元"))
            sectionModel.items.append(GLItemModel(title: "备注", subTitle: carInfo.remarks))
            
            dataArray.append(sectionModel)
        }
        
        // 定价师
        if model.dataAuth.pgxx_djjg == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "定价结果"
            
            let carInfo = model.carInfo
            sectionModel.items.append(GLItemModel(title: "定价师", subTitle: carInfo.fixPriceName))
            sectionModel.items.append(GLItemModel(title: "定价价格", subTitle: carInfo.fixPriceMoney.decimalString() + "万元"))
            sectionModel.items.append(GLItemModel(title: "备注", subTitle: carInfo.fixPriceRemark))
            
            dataArray.append(sectionModel)
        }
        
        return dataArray
    }
    
    
    /// 转换风险控制信息数据
    ///
    /// - Parameter model: 总详情信息
    /// - Returns: 风险控制数据数组
    static func riskControlData(model: GLGPSTaskDetailBigModel) -> [GLSectionModel] {
        var dataArray = [GLSectionModel]()
        
        if model.dataAuth.fxkz_fxkz == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "风险控制"
            
            if model.dataAuth.fxkz_jkyt == true {
                sectionModel.items.append(GLItemModel(title: "借款用途", subTitle: model.loanRisker.lrPurpose))
            }
            
            if model.dataAuth.fxkz_mqyj == true {
                sectionModel.items.append(GLItemModel(title: "面签意见", subTitle: model.loanRisker.lrSuggestion))
            }
            
            if model.dataAuth.fxkz_pdje == true {
                sectionModel.items.append(GLItemModel(title: "批贷金额", subTitle: model.loanRisker.lrAmount.decimalString() + "万元"))
            }
            
            if model.dataAuth.fxkz_pdqx == true {
                sectionModel.items.append(GLItemModel(title: "批贷期限", subTitle: model.loanRisker.lrTerm + "月"))
            }
            
            if model.dataAuth.fxkz_hkfs == true {
                sectionModel.items.append(GLItemModel(title: "还款方式", subTitle: model.loanRisker.lrRepaytypeStr))
            }
            
            if model.dataAuth.fxkz_jkdyl == true {
                sectionModel.items.append(GLItemModel(title: "借款抵押率", subTitle: model.loanRisker.lrLoanmortgageRate.percentString()))
            }
            
            if model.dataAuth.fxkz_jklx == true {
                sectionModel.items.append(GLItemModel(title: "借款类型", subTitle: model.loanRisker.lrMortagetypeStr))
            }
            
            if model.dataAuth.fxkz_cjr == true {
                sectionModel.items.append(GLItemModel(title: "出借人", subTitle: model.loanRisker.lrLenderName))
            }
            
            dataArray.append(sectionModel)
        }
        
        if model.dataAuth.fxkz_jkll == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "借款利率"
            
            if model.dataAuth.jkll_gsyx == true {
                sectionModel.items.append(GLItemModel(title: "公司月息", subTitle: model.loanRisker.lrRateGsmonthrate))
            }
            
            if model.dataAuth.jkll_gsfwf == true {
                var lrRateGsservicefee = model.loanRisker.lrRateGsservicefee
                if lrRateGsservicefee.isEmpty == false {
                    lrRateGsservicefee = lrRateGsservicefee + "元"
                }
                sectionModel.items.append(GLItemModel(title: "公司服务费", subTitle: lrRateGsservicefee))
            }
            
            if model.dataAuth.jkll_khyx == true {
                sectionModel.items.append(GLItemModel(title: "客户月息", subTitle: model.loanRisker.lrRateKhmonthrate))
            }
            
            if model.dataAuth.jkll_khfwf == true {
                var lrRateKhservicefee = model.loanRisker.lrRateKhservicefee
                if lrRateKhservicefee.isEmpty == false {
                    lrRateKhservicefee = lrRateKhservicefee + "元"
                }
                sectionModel.items.append(GLItemModel(title: "客户服务费", subTitle: lrRateKhservicefee))
            }
            
            dataArray.append(sectionModel)
        }
        
        
        
        return dataArray
    }
    
    
    
    /// 转换尽职调查信息数据
    ///
    /// - Parameter model: 总详情信息
    /// - Returns: 尽职调查数据数组
    static func investigateData(model: GLGPSTaskDetailBigModel) -> [GLSectionModel] {
        var dataArray = [GLSectionModel]()
        
        
        // GPS 安装明细
        if model.dataAuth.jzdc_gpsazmx == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "GPS安装明细"
            
            if model.dataAuth.gpsazmx_azry == true {
                sectionModel.items.append(GLItemModel(title: "安装人员", subTitle: model.gpsInfo.g_personnel))
            }
            
            if model.dataAuth.gpsazmx_azrq == true {
                sectionModel.items.append(GLItemModel(title: "安装日期", subTitle: model.gpsInfo.install_Date))
            }
            
            if model.dataAuth.gpsazmx_azms == true {
                if model.gpsInfo.gpsSet.count > 0 {
                    var formModel = GLFormModel()
                    formModel.titles = ["设备类型", "设备型号", "设备编号", "设备SIM卡号", "安装位置", "备注"]
                    for gpsMxModel in model.gpsInfo.gpsSet {
                        let formArray = [gpsMxModel.gps_type, gpsMxModel.gps_version, gpsMxModel.gps_number, gpsMxModel.gps_sim_card, gpsMxModel.gps_position, gpsMxModel.gps_remark]
                        
                        formModel.dataArray.append(formArray)
                    }
                    sectionModel.items.append(formModel)
                }
            }
            dataArray.append(sectionModel)
        }
        
        
        // 下户尽调
        if model.dataAuth.jzdc_xhjd == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "下户尽调"
            
            if model.dataAuth.xhjd_xhrq == true {
                sectionModel.items.append(GLItemModel(title: "下户日期", subTitle: model.pauperInfo.crea_date))
            }
            
            if model.dataAuth.xhjd_xhrq == true {
                sectionModel.items.append(GLItemModel(title: "下户与申请地址是否一致", subTitle: model.pauperInfo.pauper_agreement))
            }
            
            if model.dataAuth.xhjd_xhrq == true {
                sectionModel.items.append(GLItemModel(title: "房屋居住来源", subTitle: model.pauperInfo.pauper_source))
            }
            
            if model.dataAuth.xhjd_xhrq == true {
                sectionModel.items.append(GLItemModel(title: "房屋用途", subTitle: model.pauperInfo.pauper_purpose))
            }
            
            if model.dataAuth.xhjd_xhrq == true {
                sectionModel.items.append(GLItemModel(title: "房屋周围环境", subTitle: model.pauperInfo.pauper_environment))
            }
            
            if model.dataAuth.xhjd_fwnywwjp == true {
                sectionModel.items.append(GLItemModel(title: "房屋内有无违禁品", subTitle: model.pauperInfo.pauper_contraband))
            }
            
            if model.dataAuth.xhjd_xhyj == true {
                sectionModel.items.append(GLItemModel(title: "下户意见", subTitle: model.pauperInfo.pauper_opinion))
            }
            
            dataArray.append(sectionModel)
        }
        
        // 下户尽调
        if model.dataAuth.jzdc_dzydj == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "抵质押登记"
            
            if model.dataAuth.dzydj_dzydjrq == true {
                sectionModel.items.append(GLItemModel(title: "抵质押登记日期", subTitle: model.pledgeTime))
            }
            
            dataArray.append(sectionModel)
        }
        
        
        return dataArray
        
    }
    
    /// 转换合同信息数据
    ///
    /// - Parameter model: 总详情信息
    /// - Returns: 合同数据数组
    static func pactData(model: GLGPSTaskDetailBigModel) -> [GLSectionModel] {
        var dataArray = [GLSectionModel]()
        if model.dataAuth.htqy_htjf == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "合同交付"
            sectionModel.items.append(GLItemModel(title: "合同编号", subTitle: model.loanApply.contract_number))
            
            if model.signatureList.count > 0{
                var formModel = GLFormModel()
                formModel.titles = ["合同名称", "是否交付", "数量(份)"]
                formModel.titleColWidth = 120
                for htModel in model.signatureList {
                    let formArray = [htModel.dname, htModel.isGive, htModel.contract_count]
                    
                    formModel.dataArray.append(formArray)
                }
                sectionModel.items.append(formModel)
            }
            
            dataArray.append(sectionModel)
        }
        return dataArray
    }
    
    
    /// 转换资料附件信息数据
    ///
    /// - Parameter model: 总详情信息
    /// - Returns: 资料附件数据数组
    static func accessoryData(model: GLGPSTaskDetailBigModel) -> [GLSectionModel] {
        var dataArray = [GLSectionModel]()
        
        if model.dataAuth.zlfj_clwg == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "车辆外观"
            
            let acceaaroyFileUrls = model.carAttWg.flatMap { (accessoryModel) -> String? in
                return accessoryModel.file_url
            }
            sectionModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
            dataArray.append(sectionModel)
        }
        
        if model.dataAuth.zlfj_clns == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "车辆内饰"
            
            let acceaaroyFileUrls = model.carAttNs.flatMap { (accessoryModel) -> String? in
                return accessoryModel.file_url
            }
            sectionModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
            dataArray.append(sectionModel)
        }
        
        if model.dataAuth.zlfj_clxx == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "车辆信息"
            
            let acceaaroyFileUrls = model.carAttXx.flatMap { (accessoryModel) -> String? in
                return accessoryModel.file_url
            }
            sectionModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
            dataArray.append(sectionModel)
        }
        
        
        if model.dataAuth.zlfj_cjcx == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "车价查询"
            
            let acceaaroyFileUrls = model.carAttCj.flatMap { (accessoryModel) -> String? in
                return accessoryModel.file_url
            }
            sectionModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
            dataArray.append(sectionModel)
        }
        
        if model.dataAuth.zlfj_wzcx == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "违章查询"
            
            let acceaaroyFileUrls = model.carAttWz.flatMap { (accessoryModel) -> String? in
                return accessoryModel.file_url
            }
            sectionModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
            dataArray.append(sectionModel)
        }
        
        if model.dataAuth.zlfj_fxkz == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "风险控制"
            
            let acceaaroyFileUrls = model.loanAttFxkz.flatMap { (accessoryModel) -> String? in
                return accessoryModel.file_url
            }
            sectionModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
            dataArray.append(sectionModel)
        }
        
        
        if model.dataAuth.zlfj_sycl == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "收押材料"
            
            let acceaaroyFileUrls = model.loanAttSycl.flatMap { (accessoryModel) -> String? in
                return accessoryModel.file_url
            }
            sectionModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
            dataArray.append(sectionModel)
        }
        
        if model.dataAuth.zlfj_xhzp == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "下户照片"
            
            let acceaaroyFileUrls = model.loanAttXh.flatMap { (accessoryModel) -> String? in
                return accessoryModel.file_url
            }
            sectionModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
            dataArray.append(sectionModel)
        }
        
        if model.dataAuth.zlfj_dzydjyblpz == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "抵质押登记已办理凭证"
            
            let acceaaroyFileUrls = model.loanAttDzy.flatMap { (accessoryModel) -> String? in
                return accessoryModel.file_url
            }
            sectionModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
            dataArray.append(sectionModel)
        }
        
        
        return dataArray
    }
    
    /// 转换费用信息数据
    ///
    /// - Parameter model: 总详情信息
    /// - Returns: 费用数据数组
    static func costData(model: GLGPSTaskDetailBigModel) -> [GLSectionModel] {
        var dataArray = [GLSectionModel]()
        
        if model.dataAuth.fyjfk_dqfy == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "贷前费用"
            
            var lrPreIszhuangdan = ""
            if model.loanRisker.lrPreIszhuandan == "1" {
                lrPreIszhuangdan = "是"
            }
            
            if model.loanRisker.lrPreIszhuandan == "0" {
                lrPreIszhuangdan = "否"
            }
            
            sectionModel.items.append(GLItemModel(title: "是否转单", subTitle:  lrPreIszhuangdan))
            
//            sectionModel.items.append(GLItemModel(title: "垫资费", subTitle: model.loanRisker.lrPreAdvance.decimalString().isEmpty ? "" : model.loanRisker.lrPreAdvance.decimalString() + "元"))
            
            var lrPreIsgps = model.loanRisker.lrPreIsgps
            if lrPreIsgps == "1" {
                lrPreIsgps = "需要"
            }
            if lrPreIsgps == "0" {
                lrPreIsgps = "不需要"
            }
            
            sectionModel.items.append(GLItemModel(title: "GPS安装", subTitle: lrPreIsgps))
            
//            sectionModel.items.append(GLItemModel(title: "GPS安装费", subTitle: model.loanRisker.lrPreGpsfee.decimalString().isEmpty ? "" : model.loanRisker.lrPreGpsfee.decimalString() + "元"))
            
            var lrPreIspauper = model.loanRisker.lrPreIspauper
            if lrPreIspauper == "1" {
                lrPreIspauper = "需要"
            }
            if lrPreIspauper == "0" {
                lrPreIspauper = "不需要"
            }
            sectionModel.items.append(GLItemModel(title: "下户", subTitle: lrPreIspauper))
            
//            sectionModel.items.append(GLItemModel(title: "下户费", subTitle: model.loanRisker.lrPrePauperfee.decimalString().isEmpty ? "" : model.loanRisker.lrPrePauperfee.decimalString() + "元"))
            
            
            var lrPreIsriskMargin = model.loanRisker.lrPreIsriskMargin
            if lrPreIsriskMargin == "1" {
                lrPreIsriskMargin = "有"
            }
            if lrPreIsriskMargin == "0" {
                lrPreIsriskMargin = "无"
            }
            sectionModel.items.append(GLItemModel(title: "风险保证金", subTitle: lrPreIsriskMargin))
            
            
            
            var lrPreIsmortageCertificates = model.loanRisker.lrPreIsmortageCertificates
            if lrPreIsmortageCertificates == "1" {
                lrPreIsmortageCertificates = "有"
            }
            if lrPreIsmortageCertificates == "0" {
                lrPreIsmortageCertificates = "无"
            }
            sectionModel.items.append(GLItemModel(title: "证件不押金", subTitle: lrPreIsmortageCertificates))
            
            dataArray.append(sectionModel)
        }
        
        
        if model.dataAuth.fyjfk_fyjnmx == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "贷前费用"
            
            if model.payList.count > 0 {
                var formModel = GLFormModel()
                formModel.titles = ["缴费科目", "已缴纳金额", "待缴纳金额", "备注"]
                formModel.titleColWidth = 100
                
                for payModel in model.payList {
                    
                    var o = GLOptionsModel()
                    for optionModel in model.options {
                        if payModel.pay_id == optionModel.id {
                            o = optionModel
                            break
                        }
                    }
                    let formArray = [o.dname, payModel.unpaid.decimalString()+"元", payModel.alreadyPaid.decimalString()+"元", payModel.content]
                    
                    formModel.dataArray.append(formArray)
                }
                sectionModel.items.append(formModel)
            }
                
            dataArray.append(sectionModel)
        }
        
        if model.dataAuth.fyjfk_fkjbxx == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "放款基本信息"
            
            
            var start_end_date = model.appInfo.ht_start
            if model.appInfo.ht_end.isEmpty == false {
                if start_end_date.isEmpty == false {
                    start_end_date = start_end_date + "至" + model.appInfo.ht_end
                }
            }
            
            sectionModel.items.append(GLItemModel(title: "合同起止日期", subTitle: start_end_date))
            
            var gdhkr = ""
            if model.appInfo.gdhxr.isEmpty == false {
                gdhkr =  "每月" + (model.appInfo.gdhxr.isEmpty==false ? model.appInfo.gdhxr : "-") + "日"
            }
            sectionModel.items.append(GLItemModel(title: "固定还息日", subTitle: gdhkr))
            
            for jqskModel in model.jqsk_time {
                
                sectionModel.items.append(GLItemModel(title: "申请放款时间", subTitle: jqskModel.fksq_sqfksj))
                sectionModel.items.append(GLItemModel(title: "申请放款金额", subTitle: jqskModel.fksq_sqfke.isEmpty ? "" : jqskModel.fksq_sqfke.decimalString() + "万元" ))
                sectionModel.items.append(GLItemModel(title: "放款时间", subTitle: jqskModel.fk_sjfksj))
                sectionModel.items.append(GLItemModel(title: "实际放款", subTitle: jqskModel.fk_sjfke.isEmpty ? "" : jqskModel.fk_sjfke.decimalString() + "万元" ))
                
            }

            dataArray.append(sectionModel)
        }
        
        if model.dataAuth.fyjfk_jjrxx == true {
            
            var sectionModel = GLSectionModel()
            sectionModel.title = "经纪人信息&返费信息"
            
            sectionModel.items.append(GLItemModel(title: "经纪人姓名", subTitle: model.appInfo.a_name))
            
            sectionModel.items.append(GLItemModel(title: "联系方式", subTitle: model.appInfo.a_contact_way))
            
            
            sectionModel.items.append(GLItemModel(title: "微信号", subTitle: model.appInfo.a_wechat))
            sectionModel.items.append(GLItemModel(title: "户名", subTitle: model.appInfo.a_card_name))
            sectionModel.items.append(GLItemModel(title: "银行卡号", subTitle: model.appInfo.a_card_code))
            sectionModel.items.append(GLItemModel(title: "开户行", subTitle: model.appInfo.a_card_bank))
            sectionModel.items.append(GLItemModel(title: "支行信息", subTitle: model.appInfo.a_bank_branch))
            
            
            if model.agentBack.count > 0 {
                var formM = GLFormModel()
                formM.titles = ["预计返费时间", "返费金额", "备注"]
                formM.titleColWidth = 130
                for agentModel in model.agentBack {
                    let formArray = [agentModel.backtime, agentModel.backamount.decimalString() + "元", agentModel.backremark]
                    
                    formM.dataArray.append(formArray)
                }
                sectionModel.items.append(formM)
            }
            
            dataArray.append(sectionModel)
        }
        
        
        // 审批信息
        if model.dataAuth.fyjfk_spxx == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "审批信息"
            
            for examModel in model.examiner {
                sectionModel.items.append(GLItemModel(title: "审批人姓名", subTitle: examModel.exam_name))
                sectionModel.items.append(GLItemModel(title: "审批意见", subTitle: examModel.exam_status == "1" ? "同意放款" : "拒绝放款"))
                sectionModel.items.append(GLItemModel(title: "备注", subTitle: examModel.exam_remark))
            }
            
            dataArray.append(sectionModel)
        }
        
        
        // 还款计划
        if model.dataAuth.fyjfk_hkjh == true {
            var sectionModel = GLSectionModel()
            sectionModel.title = "还款计划"
            
            if model.repaymentPlan.count > 0 {
                var formModel = GLFormModel()
                formModel.titles = ["期数", "还款日期", "还款本金", "还款利息", "本期还款总额"]
                for planModel in model.repaymentPlan {
                    let formArray = [planModel.overdue_periods, planModel.repayment_date, planModel.repaymentCorpus.decimalString(), planModel.repaymentInterests.decimalString(), planModel.repaymentTotal.decimalString()]
                    
                    formModel.dataArray.append(formArray)
                }
                sectionModel.items.append(formModel)
            }
            
            
            
            dataArray.append(sectionModel)
        }
        
        return dataArray
    }
    
    
    
    /// 转换已获取安装GPS信息数据
    ///
    /// - Parameter model: 数据模型
    /// - Returns: 已安装GPS信息数据
    static func installedGPSInfoData(model: GLGPSInfoModel) -> [GLSectionModel] {
        var dataArray = [GLSectionModel]()
        
        var sectionModel = GLSectionModel()
        sectionModel.title = "GPS安装明细"
        
        sectionModel.items.append(GLItemModel(title: "安装人员", subTitle: model.g_personnel))
        sectionModel.items.append(GLItemModel(title: "安装日期", subTitle: model.install_Date))
        
        dataArray.append(sectionModel)
        
        for gpsSetModel in model.gpsList {
            var sectionModel = GLSectionModel()
            sectionModel.title = "GPS安装描述"
            
            sectionModel.items.append(GLItemModel(title: "设备类型", subTitle: gpsSetModel.gps_type))
            sectionModel.items.append(GLItemModel(title: "设备型号", subTitle: gpsSetModel.gps_version))
            sectionModel.items.append(GLItemModel(title: "设备编号", subTitle: gpsSetModel.gps_number))
            sectionModel.items.append(GLItemModel(title: "设备SIM卡号", subTitle: gpsSetModel.gps_sim_card))
            sectionModel.items.append(GLItemModel(title: "安装位置", subTitle: gpsSetModel.gps_position))
            sectionModel.items.append(GLItemModel(title: "备注", subTitle: gpsSetModel.gps_remark))
            
            dataArray.append(sectionModel)
        }
        
        
        
        return dataArray
    }
    
    /// 转换已下户信息数据
    ///
    /// - Parameter model: 数据模型
    /// - Returns: 已下户信息数据
    static func pauperInfoData(model: GLPauperInfoModel) -> [GLSectionModel] {
        var dataArray = [GLSectionModel]()
        
        var sectionModel = GLSectionModel()
        sectionModel.title = "下户尽调"
        
        sectionModel.items.append(GLItemModel(title: "下户日期", subTitle: model.crea_date))
        sectionModel.items.append(GLItemModel(title: "下户与申请地址是否一致", subTitle: model.pauper_agreement))
        sectionModel.items.append(GLItemModel(title: "房屋居住来源", subTitle: model.pauper_source))
        sectionModel.items.append(GLItemModel(title: "房屋用途", subTitle: model.pauper_purpose))
        sectionModel.items.append(GLItemModel(title: "房屋周围环境", subTitle: model.pauper_environment))
        sectionModel.items.append(GLItemModel(title: "房屋内有无违禁品", subTitle: model.pauper_contraband))
        sectionModel.items.append(GLItemModel(title: "下户意见", subTitle: model.pauper_opinion))
        
        dataArray.append(sectionModel)
        
        
        
        var sectionPicModel = GLSectionModel()
        sectionPicModel.title = "下户照片"
        
        let acceaaroyFileUrls = model.attachmentList.flatMap { (accessoryModel) -> String? in
            return accessoryModel.attachment_href
        }
        sectionPicModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
        
        dataArray.append(sectionPicModel)
        
        
        return dataArray
    }
    
    
    
    /// 转换已抵质押信息数据
    ///
    /// - Parameter model: 数据模型
    /// - Returns: 已抵质押信息数据
    static func pledgeInfoData(model: GLCompleteModel.GLPledgeModel.GLPledgeInfoModel) -> [GLSectionModel] {
        var dataArray = [GLSectionModel]()
        
        var sectionModel = GLSectionModel()
        sectionModel.title = "抵质押登记"
        
        sectionModel.items.append(GLItemModel(title: "抵质押登记日期", subTitle: model.crea_date))
        
        dataArray.append(sectionModel)
        
        
        
        var sectionPicModel = GLSectionModel()
        sectionPicModel.title = "抵质押登记已办理凭证"
        
        let acceaaroyFileUrls = model.attachmentList.flatMap { (accessoryModel) -> String? in
            return accessoryModel.attachment_href
        }
        sectionPicModel.items.append(GLPictureModel(pictures: acceaaroyFileUrls))
        
        dataArray.append(sectionPicModel)
        
        
        return dataArray
    }
    
}
