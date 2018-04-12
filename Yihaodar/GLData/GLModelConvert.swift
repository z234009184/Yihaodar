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
                
                for gpsMxModel in model.gpsInfo.gpsSet {
                    var formModel = GLFormModel()
                    
                    for key in gpsMxModel {
                        
                    }
                    
                    
                    dataArray.append(formModel)
                }
                
            }
            
            
            dataArray.append(sectionModel)
        }
        
        
        
        return dataArray
        
    }
}
