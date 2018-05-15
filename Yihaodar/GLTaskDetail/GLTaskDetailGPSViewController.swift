//
//  GLTaskDetailGPSViewController.swift
//  Yihaodar
//
//  Created by 张国梁 on 2018/3/25.
//  Copyright © 2018年 Yihaodar. All rights reserved.
//

import Spring
import XLPagerTabStrip
import HandyJSON
import SKPhotoBrowser
import HGPlaceholders
import SwiftyJSON



/// 附件模型
struct GLGPSAccessoryModel: HandyJSON {
    var ishadall = ""
    var file_name = ""
    var file_type_name = ""
    var file_url = ""
    var file_size = ""
}


/// 放款时间金额模型
struct GLJqskTimeModel: HandyJSON {
    
    /// 申请放款时间
    var fksq_sqfksj = ""
    /// 申请放款额
    var fksq_sqfke = ""
    /// 实际放款时间
    var fk_sjfksj = ""
    /// 实际放款额
    var fk_sjfke = ""
}

/// 下户尽调
struct GLPauperInfoModel: HandyJSON {
    /// 下户日期
    var crea_date = ""
    /// 下户与申请地址是否一致
    var pauper_agreement = ""
    /// 房屋居住来源
    var pauper_source = ""
    /// 房屋用途
    var pauper_purpose = ""
    /// 周围环境
    var pauper_environment = ""
    /// 有无违禁品
    var pauper_contraband = ""
    /// 下户意见
    var pauper_opinion = ""
    
    var p_id = ""
    var l_id = ""
    var iscache = ""
    var party_id = ""
    /// 附件模型
    var attachmentList = [GLAttachmentModel]()
    var attachmentSet = [GLAttachmentModel]()
    
    struct GLAttachmentModel: HandyJSON {
        var a_id = ""
        var l_id = ""
        var attachment_name = ""
        var attachment_href = ""
        var attachment_size = ""
        var attachment_filename = ""
        var file_type = ""
        
    }
    
}

/// 放款基本信息&经纪人信息
struct GLAppInfoModel: HandyJSON {
    /// 合同开始日期
    var ht_start = ""
    /// 合同结束日期
    var ht_end = ""
    /// 固定还息日
    var gdhxr = ""
    /// 经纪人名称
    var a_name = ""
    /// 联系方式
    var a_contact_way = ""
    /// 微信
    var a_wechat = ""
    /// 户名
    var a_card_name = ""
    /// 银行卡号
    var a_card_code = ""
    /// 开户行
    var a_card_bank = ""
    /// 支行信息
    var a_bank_branch = ""
    
    
    
    var party_name = ""
    var boss_party_id = ""
    var executive_party_id = ""
    var director_party_id = ""
    
    var c_name = ""
    var c_idcard = ""
    var lr_amount = ""
    var lr_term = ""
    var lr_loanmortgage_rate = ""
    var lr_rate_gsmonthrate = ""
    var lr_rate_gsservicefee = ""
    var lr_rate_khmonthrate = ""
    var lr_rate_khservicefee = ""
    var lr_mortagetype = ""
    var lr_repaytype = ""
    var l_amount = ""
    var c_card_name = ""
    var c_card_code = ""
    var c_card_bank = ""
    var c_bank_branch = ""
    var fksq_sqfksj = ""
    var fksq_sqfke = ""
    var fk_sjfksj = ""
    var fk_sjfke = ""
}




/// Gps安装明细
struct GLGPSInfoModel: HandyJSON {
    
    /// 安装人员
    var g_personnel = ""
    /// 安装日期
    var install_Date = ""
    /// 安装明细
    var gpsSet = [GLGPSSetModel]()
    /// GPSid
    var l_id = ""
    /// 是否缓存
    var iscache = ""
    /// 安装列表
    var gpsList = [GLGPSSetModel]()
    
    
    /// 安装明细集合模型
    struct GLGPSSetModel: HandyJSON {
        
        /// 设备类型
        var gps_type = ""
        /// 设备型号
        var gps_version = ""
        /// 设备编号
        var gps_number = ""
        /// 安装位置
        var gps_position = ""
        /// 设备SIM卡号
        var gps_sim_card = ""
        /// 备注
        var gps_remark = ""
        
    }
}




/// 经纪人返费模型
struct GLAgentBackModel: HandyJSON {
    /// 预计返费时间
    var backtime = ""
    /// 返费金额
    var backamount = "0"
    /// 备注
    var backremark = ""
}


/// 车况信息模型
struct GLCarinfodataModel: HandyJSON {
    /// 车构件
    var partsOneId = ""
    /// 部件
    var partsTwoId = ""
    /// 描述
    var accidentType = ""
    /// 补充说明
    var remarks = ""
}

/// 风险控制模型
struct GLLoanRiskerModel: HandyJSON {
    /// 借款用途
    var lrPurpose = ""
    
    /// 面签意见
    var lrSuggestion = ""
    /// 批贷金额
    var lrAmount = ""
    /// 批贷期限
    var lrTerm = ""
    /// 还款方式 0：先息后本 1：等额本息   2：等本等息
    var lrRepaytype = ""
    /// 还款方式Str
    var lrRepaytypeStr: String {
        get {
            switch lrRepaytype {
            case "0":
                return "先息后本"
            case "1":
                return "等额本息"
            case "2":
                return "等本等息"
            default:
                return ""
            }
        }
    }
    /// 借款抵押率（0.02就是2%）
    var lrLoanmortgageRate = ""
    /// 借款类型 1：押手续 2：押车 3：双押
    var lrMortagetype = ""
    /// 借款类型Str
    var lrMortagetypeStr: String {
        get {
            switch lrMortagetype {
            case "1":
                return "押手续"
            case "2":
                return "押车"
            case "3":
                return "双押"
            default:
                return ""
            }
        }
    }
    /// 出借人
    var lrLenderName = ""
    /// 公司月息
    var lrRateGsmonthrate = "0"
    /// 公司服务费
    var lrRateGsservicefee = ""
    /// 客户月息
    var lrRateKhmonthrate = "0"
    /// 客户服务费
    var lrRateKhservicefee = ""
    /// 是否转单 1：是 0：否
    var lrPreIszhuandan = ""
    /// 垫资费
    var lrPreAdvance = ""
    /// 是否需要安装GPS 1：是 0：否
    var lrPreIsgps = ""
    /// GPS安装费
    var lrPreGpsfee = ""
    /// 是否需要下户 1：是 0：否
    var lrPreIspauper = ""
    
    /// 下户费
    var lrPrePauperfee = ""
    /// 有无风险保证金 1：有 0：无
    var lrPreIsriskMargin = ""
    /// 风险保证金（金额）
    var lrPreRiskmargin = ""
    /// 有无证件不押金 1：有 0：无
    var lrPreIsmortageCertificates = ""
    /// 证件不押金（金额）
    var lrPreIsmortageFee = ""
}


struct GLDataAuth: HandyJSON {
    var ddxx_djr: Bool?
    var fyjfk_dqfy: Bool?
    var xhjd_xhrq: Bool?
    var clxx_jqx: Bool?
    var jkrxx_jycd: Bool?
    var gjrxx_bjjznx: Bool?
    var gjrxx_nl: Bool?
    var gjrxx_jbysr: Bool?
    var zqxx_jksqdyl: Bool?
    var null_pgfzr: Bool?
    var gjrxx_zwmc: Bool?
    var clxx_clxl: Bool?
    var zlfj_sycl: Bool?
    var jksqxx_jksqje: Bool?
    var clxx_clxh: Bool?
    var gjrxx_gzxz: Bool?
    var null_ssjg: Bool?
    var ddxx_ssmd: Bool?
    var gjrxx_znzk: Bool?
    var jkryhkxx_yhkxx: Bool?
    var jksqxx_jksqqx: Bool?
    var jkryhkxx_zhxx: Bool?
    var gjrxx_xb: Bool?
    var jbxx_zqxx: Bool?
    var jkrxx_xjzdz: Bool?
    var jkrxx_xykzed: Bool?
    var pgxx_ckms: Bool?
    var jkrxx_sfcqjzbj: Bool?
    var null_pgxx: Bool?
    var jkrxx_fwly: Bool?
    var fyjfk_fyjnmx: Bool?
    var zlfj_clxx: Bool?
    var fxkz_jkyt: Bool?
    var clxx_clpp: Bool?
    var zlfj_wzcx: Bool?
    var fxkz_jkdyl: Bool?
    var jbxx_jksqxx: Bool?
    var gjrxx_sfcqjzbj: Bool?
    var gjrxx_hyzk: Bool?
    var clxx_dqwzs: Bool?
    var jbxx_gjrxx: Bool?
    var gjrxx_gzdw: Bool?
    var pgxx_clpz: Bool?
    var fyjfk_spxx: Bool?
    var clxx_czxm: Bool?
    var zlfj_clwg: Bool?
    var jbxx_jkrjjlxrxxgjr: Bool?
    var jkrxx_znzk: Bool?
    var jkrxx_zwmc: Bool?
    var fyjfk_fkjbxx: Bool?
    var gjrxx_gzdz: Bool?
    var zqxx_zqqx: Bool?
    var ddxx_ywzj: Bool?
    var gjrxx_fwly: Bool?
    var null_bz: Bool?
    var jkrxx_cshy: Bool?
    var fxkz_fxkz: Bool?
    var jbxx_ddxx: Bool?
    var jkrxx_sfzhm: Bool?
    var zqxx_zqje: Bool?
    var gjrxx_zhnsr: Bool?
    var jkryhkxx_hm: Bool?
    var fxkz_cjr: Bool?
    var gjrxx_xjzdz: Bool?
    var jkrxx_gzxz: Bool?
    var jkrxx_jkrxm: Bool?
    var zlfj_clns: Bool?
    var ddxx_ybdjbh: Bool?
    var gjrxx_sfzhm: Bool?
    var jbxx_jkryhkxxgjr: Bool?
    var jzdc_gpsazmx: Bool?
    var jkryhkxxgjr_hm: Bool?
    var null_jbxx: Bool?
    var jksqxx_jksqdyl: Bool?
    var zlfj_fxkz: Bool?
    var jkrxx_gzdz: Bool?
    var jkrxx_gzdw: Bool?
    var jkrxx_bjjznx: Bool?
    var jkrxx_sjh2: Bool?
    var jbxx_jkryhkxx: Bool?
    var jkrxx_sjh1: Bool?
    var jbxx_jkrxx: Bool?
    var fyjfk_zqfy: Bool?
    var clxx_ccrq: Bool?
    var null_cpgjg: Bool?
    var xhjd_fwnywwjp: Bool?
    var zqxx_jksqlx: Bool?
    var gjrxx_jycd: Bool?
    var jkryhkxx_khh: Bool?
    var pgxx_djjg: Bool?
    var jkll_gsyx: Bool?
    var jzdc_dzydj: Bool?
    var jkll_khyx: Bool?
    var ddxx_djsj: Bool?
    var clxx_fdjhm: Bool?
    var zlfj_xhzp: Bool?
    var jkryhkxxgjr_zhxx: Bool?
    var gpsazmx_azms: Bool?
    var jkll_khfwf: Bool?
    var null_htqy: Bool?
    var fyjfk_hkjh: Bool?
    var zlfj_cjcx: Bool?
    var jkrxx_jbysr: Bool?
    var jbxx_clxx: Bool?
    var xhjd_xhysqdzsfyz: Bool?
    var null_zlfj: Bool?
    var jksqxx_jksqlx: Bool?
    var jkryhkxxgjr_yhkxx: Bool?
    var gjrxx_jkrxm: Bool?
    var xhjd_fwyt: Bool?
    var fxkz_pdqx: Bool?
    var fxkz_pdje: Bool?
    var clxx_ghcs: Bool?
    var xhjd_fwjzly: Bool?
    var jzdc_xhjd: Bool?
    var null_fyjfk: Bool?
    var jkrxx_nl: Bool?
    var jkrxx_zhnsr: Bool?
    var fxkz_jklx: Bool?
    var dzydj_dzydjrq: Bool?
    var zlfj_dzydjyblpz: Bool?
    var jbxx_jkrjjlxrxx: Bool?
    var jkll_gsfwf: Bool?
    var clxx_xslc: Bool?
    var ddxx_khjl: Bool?
    var gpsazmx_azry: Bool?
    var fxkz_jkll: Bool?
    var htqy_htjf: Bool?
    var xhjd_fwzwhj: Bool?
    var jkrxx_hj: Bool?
    var gpsazmx_azrq: Bool?
    var clxx_clhp: Bool?
    var clxx_cjh: Bool?
    var clxx_djrq: Bool?
    var gjrxx_byyx: Bool?
    var fxkz_hkfs: Bool?
    var gjrxx_hj: Bool?
    var clxx_syx: Bool?
    var fyjfk_jjrxx: Bool?
    var jkryhkxxgjr_khh: Bool?
    var xhjd_xhyj: Bool?
    var fxkz_mqyj: Bool?
    var jkrxx_xb: Bool?
    var jkrxx_fz: Bool?
    var clxx_njdqr: Bool?
    var pgxx_pgjg: Bool?
    var gjrxx_fz: Bool?
    var gjrxx_cshy: Bool?
    var jkrxx_hyzk: Bool?
    var null_fxkz: Bool?
    var clxx_kpjg: Bool?
    var null_jzdc: Bool?
    var clxx_pql: Bool?
    var ddxx_tdzg: Bool?
    var gjrxx_sjh2: Bool?
    var gjrxx_sjh1: Bool?
    var clxx_clys: Bool?
    var jkrxx_byyx: Bool?
    var gjrxx_xykzed: Bool?
}

struct GLProcessStatusModel: HandyJSON {
    var CARS_ASSESS_TASK = ""
    var LOAN_APPLY_FACE_TASK = ""
    var LOAN_APPLY_GPS_INSTALL = ""
    var LOAN_APPLY_REGISTER_TASK = ""
    var LOAN_APPLY_INTERVIEW = ""
    var LOAN_APPLY_PAYFEE = ""
    var LOAN_APPLY_PAUPER = ""
    var LOAN_APPLY_PLEDGE = ""
}

struct GLSpecialStatusModel: HandyJSON {
    var LOAN_APPLY_TO_EXAMINE = ""
    var LOAN_APPLY_DOAPPLY = ""
    var LOAN_APPLY_FANGKUAN = ""
}


/// 缴费明细列表模型
struct GLPayListModel: HandyJSON {
    
    /// 缴费项目ID
    var pay_id = ""
    /// 应收费用
    var alreadyPaid = "0"
    /// 实收费用
    var unpaid = "0"
    /// 备注
    var content = ""
    
}

/// 缴费选项模型（与明细对应）
struct GLOptionsModel: HandyJSON {
    /// 选项ID（与缴费项目ID对应）
    var id = ""
    /// 选项名称
    var dname = ""
    /// 选项类型 1：费用 2：押金
    var value = ""
}

/// 借款订单信息
struct GLLoanApply: HandyJSON {
    /// 所属门店
    var l_store = ""
    /// 客户经理
    var boss_party_id = ""
    /// 团队主管
    var executive_party_id = ""
    /// 业务总监
    var director_party_id = ""
    /// 借款申请金额
    var l_amount = "0"
    /// 借款期限
    var l_term = ""
    /// 借款类型
    var l_type = ""
    /// 借款申请抵押率（0.01就是1%）
    var l_mortgage_rate = ""
    /// 面签里的合同编号
    var contract_number = ""
    /// 借款人集合
    var ltcSet = [GLLtcSetModel]()
    
    /// 借款人集合Model
    struct GLLtcSetModel: HandyJSON {
        /// 是否为共借人 0：借款人 1：共借人
        var is_together = ""
        
        /// 借款人或者共借人具体字段
        var lc = GLLtcSetlcModel()
        
        /// 借款人或者共借人Model
        struct GLLtcSetlcModel: HandyJSON {
            /// 借款人姓名
            var c_name = ""
            /// 年龄
            var c_age = ""
            /// 性别
            var c_sex = ""
            /// 身份证
            var c_idcard = ""
            /// 手机号1
            var c_phone1 = ""
            /// 手机号2
            var c_phone2 = ""
            /// 户籍
            var c_home = ""
            /// 是否常住北京
            var c_isczbj = ""
            /// 北京居住年限
            var c_bjyear = ""
            /// 教育程度 1：硕士及以上 2：本科 3：专科 4：高中及以下
            var c_educational_level = ""
            /// 教育程度Str
            var c_educational_level_str: String {
                get {
                    switch c_educational_level {
                    case "1":
                        return "硕士及以上"
                    case "2":
                        return "本科"
                    case "3":
                        return "专科"
                    case "4":
                        return "高中及以下"
                    default:
                        return "未知"
                    }
                }
            }
            
            /// 毕业院校
            var c_over_school = ""
            /// 婚姻状况 1：已婚 2：未婚 3：离异 4：再婚
            var c_marital_status = ""
            /// 婚姻状况Str
            var c_marital_status_str: String {
                get {
                    switch c_marital_status {
                    case "1":
                        return "已婚"
                    case "2":
                        return "未婚"
                    case "3":
                        return "离异"
                    case "4":
                        return "再婚"
                    default:
                        return ""
                    }
                }
            }
            /// 子女状况
            var c_children = ""
            /// 工作性质 1：工薪阶层 2：商人 3：农民
            var c_nature_of_work = ""
            var c_nature_of_work_str: String {
                get {
                    switch c_nature_of_work {
                    case "1":
                        return "工薪阶层"
                    case "2":
                        return "商人"
                    case "3":
                        return "农民"
                    default:
                        return ""
                    }
                }
            }
            /// 从属行业
            var c_industry = ""
            /// 工作单位
            var c_work_company = ""
            /// 工作地址
            var c_work_address = ""
            /// 职位名称
            var c_work_name = ""
            /// 现居住地址
            var c_address = ""
            /// 房屋来源
            var c_house_source = ""
            /// 基本月收入
            var c_month_income = ""
            /// 基本年收入
            var c_year_income = ""
            /// 信用卡总额度
            var c_credit_card_sum = ""
            /// 负债
            var c_liabilities = ""
            /// 银行卡户名
            var c_card_name = ""
            /// 银行卡号
            var c_card_code = ""
            /// 开户行
            var c_card_bank = ""
            /// 支行信息
            var c_bank_branch = ""
            /// 紧急联系人集合
            var lccSet = [GLLccSetModel]()
            
            /// 紧急联系人集合Model
            struct GLLccSetModel: HandyJSON {
                /// 姓名
                var con_name = ""
                /// 联系电话
                var con_phone = ""
                /// 与借款人关系 1：配偶 2：亲属 3：朋友
                var con_nexus = ""
                /// 与共接人关系Str
                var con_nexus_str: String {
                    get {
                        switch con_nexus {
                        case "1":
                            return "配偶"
                        case "2":
                            return "亲属"
                        case "3":
                            return "朋友"
                        default:
                            return "未知"
                            
                        }
                    }
                }
                /// 工作单位
                var con_work_company = ""
                /// 联系地址
                var con_address = ""
            }
            
        }
    }
    
}


/// 还款计划集合Model
struct GLRepaymentPlanModel: HandyJSON {
    
    /// 期数
    var overdue_periods = ""
    /// 还款日期
    var repayment_date = ""
    /// 还款本金
    var repaymentCorpus = "0"
    /// 还款利息
    var repaymentInterests = "0"
    /// 本溪还款总额
    var repaymentTotal: String {
        get {
            return String((Double(repaymentCorpus)! + Double(repaymentInterests)!))
        }
    }
    
}

/// 车辆信息Model
struct GLGPSCarInfoModel: HandyJSON {
    /// 车主姓名
    var ower = ""
    /// 车辆号牌
    var goodsCode = ""
    /// 品牌
    var brandName = ""
    /// 系列
    var goodsSeries = ""
    /// 型号
    var goodsStyle = ""
    /// 颜色
    var carColor = ""
    /// 生产日期
    var productionDate = ""
    /// 注册日期
    var registerDate = ""
    /// 行驶里程
    var runNumber = ""
    /// 排气量
    var displacement = ""
    /// 当前违章（0：无；1：有）
    var peccancy = ""
    /// 违章罚分
    var peccancyFraction = "0"
    /// 违章罚钱
    var peccancyMoney = "0"
    /// 发动机号
    var engineCode = ""
    /// 车架号
    var frameCode = ""
    /// 开票价格
    var invoice = ""
    /// 过户次数
    var transferNumber = ""
    /// 年检到期日
    var yearCheck = ""
    /// 交强险
    var jqInsurance = ""
    /// 商业险
    var syInsurance = ""
    /// 评估师
    var assessmentName = ""
    /// 评估价格（万元）
    var confirmedMoney = ""
    /// 评估备注
    var remarks = ""
    /// 定价师
    var fixPriceName = ""
    /// 定价价格（万元）
    var fixPriceMoney = ""
    /// 定价备注
    var fixPriceRemark = ""
    /// 变速器
    var gearbox = ""
    /// 驱动方式
    var drivingType = ""
    /// 无钥匙启动
    var keylessStartup = ""
    /// 定速巡航
    var cruiseControl = ""
    /// 导航
    var navigation = ""
    /// 后排娱乐
    var hpyl = ""
    /// 座椅形式
    var chairType = ""
    /// 燃油方式
    var fuelType = ""
    /// 天窗
    var skylight = ""
    /// 空调配置
    var airConditioner = ""
    /// 其他
    var other = ""
    /// 安全气囊（个）
    var airbag = ""
    /// 事故
    var accident = ""
    /// 事故等级
    var accidentLevel = ""
}


/// 合同Model
struct GLSignatureListModel: HandyJSON {
    /// 合同名称
    var dname = ""
    /// 是否交付
    var isGive = ""
    /// 合同数
    var contract_count = ""
    /// 合同编号
    var contract_number = ""
    
}


/// 详情返回总模型
struct GLGPSTaskDetailBigModel: HandyJSON {
    /// 下户附件
    var loanAttXh: [GLGPSAccessoryModel] = []
    /// 抵质押附件集合
    var loanAttDzy: [GLGPSAccessoryModel] = []
    /// 收押材料附件集合
    var loanAttSycl: [GLGPSAccessoryModel] = []
    /// 风险控制附件集合
    var loanAttFxkz: [GLGPSAccessoryModel] = []
    /// 车辆内饰附件集合
    var carAttNs: [GLGPSAccessoryModel] = []
    /// 违章查询附件集合
    var carAttWz: [GLGPSAccessoryModel] = []
    /// 车架查询附件集合
    var carAttCj: [GLGPSAccessoryModel] = []
    /// 车辆信息附件集合
    var carAttXx: [GLGPSAccessoryModel] = []
    /// 车辆外观附件集合
    var carAttWg: [GLGPSAccessoryModel] = []
    
    /// 放款时间金额
    var jqsk_time: [GLJqskTimeModel] = []
    
    /// 下户尽调
    var pauperInfo = GLPauperInfoModel()
    
    /// 放款基本信息&经纪人信息
    var appInfo = GLAppInfoModel()
    
    /// GSP安装明细
    var gpsInfo = GLGPSInfoModel()
    
    /// 经纪人返费列表
    var agentBack = [GLAgentBackModel]()
    
    /// 车况信息
    var carinfodata = [GLCarinfodataModel]()
    
    /// 面审信息（风险控制）
    var loanRisker = GLLoanRiskerModel()
    
///    当前用户所拥有的字段权限
///    Key：父级_本级（首拼音）
///    Value：true（有权限）false（无权限）
///    比如：所属门店
///    ddxx_ssmd:true  就是有权限
///    当没有父级时，父级用null字符串表示
///    null_jbxx:false 就是‘基本信息’模块不显示
    var dataAuth = GLDataAuth()
    
    var processStatus = GLProcessStatusModel() // 流程状态
    var specialStatus = GLSpecialStatusModel()
    var shenPiStatus = false // 审批流程是否完成
    
    /// 缴费明细列表
    var payList = [GLPayListModel]()
    
    /// 缴费选项（与明细对应）
    var options = [GLOptionsModel]()
    
    /// 借款人订单信息
    var loanApply = GLLoanApply()
    
    /// 还款计划集合
    var repaymentPlan = [GLRepaymentPlanModel]()
    
    /// 车辆信息
    var carInfo = GLGPSCarInfoModel()
    
    /// 合同
    var signatureList = [GLSignatureListModel]()
    
    /// 抵质押登记日期
    var pledgeTime = ""
    
    /// 审批信息
    var examiner = [GLExaminerModel]()
    
    struct GLExaminerModel: HandyJSON {
        /// 审批人姓名
        var exam_name = ""
        /// 审批意见 1 同意 0 拒绝
        var exam_status = ""
        /// 备注
        var exam_remark = ""
    }
}









// MARK : - ------------------------------------


/// 条目展示的模型
struct GLItemModel: HandyJSON {
    var title = ""
    var subTitle = ""
    
}


/// 表格模型
struct GLFormModel: HandyJSON {
    var titles: [String] = []
    var dataArray: [[String]] = []
    var titleColWidth: CGFloat = 80
}


/// 图片模型
struct GLPictureModel: HandyJSON {
    var pictures: [String] = []
}


/// 数据层（组模型）
struct GLSectionModel: HandyJSON {
    var title = ""
    var items: [Any] = []
}



/// 区头部
class GLTaskDetailItemHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var sectionModel: GLSectionModel? {
        didSet{
            titleLabel.text = sectionModel?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}



/// 条目Cell
class GLTaskDetailItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var itemModel: GLItemModel? {
        didSet{
            titleLabel.text = itemModel?.title
            subTitleLabel.text = itemModel?.subTitle
            
            if subTitleLabel.text?.isEmpty == true {
                subTitleLabel.text = "未填写"
                subTitleLabel.textColor = YiUnselectedTitleColor
            } else {
                subTitleLabel.textColor = YiSelectedTitleColor
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}


/// 表格cell
class GLTaskDetailFormCell: UITableViewCell, SheetViewDelegate, SheetViewDataSource {
    static let margin: CGFloat = 3
    static let rowHeight: CGFloat = 40 * UIScreen.main.bounds.size.width / 375.0
    
    lazy var sheetView = { () -> SheetView in
       let sheet = SheetView()
        sheet.dataSource = self
        sheet.delegate = self
        sheet.sheetHead = "sheet"
        sheet.titleRowHeight = GLTaskDetailFormCell.rowHeight
        sheet.backgroundColor = .red
        return sheet
    }()
    
    var topArr: [String] = []
    var contentArr: [[String]] = []
    var leftArr: [String] = []
    
    var formModel: GLFormModel? {
        didSet {
            sheetView.sheetHead = formModel?.titles.first
            sheetView.titleColWidth = (formModel?.titleColWidth)!
            formModel?.titles.removeFirst()
            topArr = (formModel?.titles)!
            leftArr = (formModel?.dataArray)!.flatMap { (formItemModel) -> String? in
                return formItemModel.first
            }
            
            
            contentArr = (formModel?.dataArray)!.flatMap({ (strArr) -> [String]? in
                var strArr = strArr
                strArr.removeFirst()
                return strArr
            })
            
            sheetView.reloadData()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(sheetView)
        sheetView.snp.remakeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self)
            make.top.equalTo(self).offset(3)
        }
        
    }
    
    
    func sheetView(sheetView: SheetView, numberOfRowsInSection section: Int) -> Int {
        return contentArr.count
    }
    
    func sheetView(sheetView: SheetView, numberOfColsInSection section: Int) -> Int {
        return topArr.count
    }
    
    func sheetView(sheetView: SheetView, cellForContentItemAtIndexRow indexRow: NSIndexPath?, indexCol: NSIndexPath?) -> String {
    
        let formArr = contentArr[indexRow!.row]
        
        return formArr[indexCol!.row]
        
    }
    
    func sheetView(sheetView: SheetView, cellForLeftColAtIndexPath indexPath: NSIndexPath?) -> String {
        return leftArr[indexPath!.row]
        
    }
    
    func sheetView(sheetView: SheetView, cellForTopRowAtIndexPath indexPath: NSIndexPath?) -> String {
        return topArr[indexPath!.row]
    }
    
    func sheetView(sheetView: SheetView, cellWithColorAtIndexRow indexRow: NSIndexPath?) -> Bool {
        return ((indexRow?.row)! % 2 == 1) ? true : false
    }
    
    func sheetView(sheetView: SheetView, heightForRowAtIndexPath indexPath: NSIndexPath?) -> CGFloat {
        return sheetView.titleRowHeight
    }
    
    func sheetView(sheetView: SheetView, widthForColAtIndexPath indexPath: NSIndexPath?) -> CGFloat {
        return (sheetView.frame.size.width - sheetView.titleColWidth) / 2
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func sheetView(sheetView: SheetView, cellDidSelectedAtIndexRow indexRow: NSIndexPath?, indexCol: NSIndexPath?) {
        print("点击 row \(String(describing: indexRow!.row)) col \(String(describing: indexCol!.row))")
    }
    
}




/// 图片整体TableViewCell
class GLTaskDetailTableViewPictureCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    fileprivate let identifier = "GLTaskDetailPictureCell"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var pictureArray = [SKPhoto]()
    private var observer: NSObjectProtocol?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        collectionView.register(UINib(nibName: "GLTaskDetailPictureCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        
        observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: SKPHOTO_LOADING_DID_END_NOTIFICATION), object: nil, queue: OperationQueue.main, using: {[weak self] (noti) in
            
//            guard let photo = noti.object as? SKPhoto else {return}
//            let indexPath = IndexPath(item: photo.index, section: 0)
//
//            self?.collectionView.reloadItems(at: [indexPath])
            self?.collectionView.reloadData()
        })
        
    }
    
    deinit {
        guard let observer = observer else { return }
        NotificationCenter.default.removeObserver(observer)
    }
    
    
    /// 图片模型
    var pictureModel: GLPictureModel? {
        didSet{
            var arr = [SKPhoto]()
            pictureModel?.pictures.enumerated().forEach({ (index, value) in
                var photo = SKPhoto.photoWithImageURL(value)
                
                if let image = SKCache.sharedCache.imageForKey(value) {
                    photo = SKPhoto.photoWithImage(image)
                }
                
                if value.isEmpty == true {
                    photo = SKPhoto.photoWithImage(#imageLiteral(resourceName: "image_load_error"))
                } else {
                    photo.checkCache()
                    photo.index = index
                    photo.shouldCachePhotoURLImage = true
                }
                photo.loadUnderlyingImageAndNotify()
                
                arr.append(photo)
            })
            pictureArray = arr
            
            
            let count = (pictureModel?.pictures.count)!
            
            if count == 0 {
                collectionViewHeight.constant = 24
                collectionView.isHidden = true
            } else {
                let constant = CGFloat((Int(count-1)/3)+1) * 100.0 - 10
                collectionViewHeight.constant = constant
                collectionView.isHidden = false
            }
            
            
            collectionView.reloadData()
        }
    }
    
    
    // MARK - collectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureArray.count
    }
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let pictureCell = cell as? GLTaskDetailPictureCell else {
            return UICollectionViewCell()
        }
        
        pictureCell.imageView.image = pictureArray[indexPath.item].underlyingImage
        return pictureCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GLTaskDetailPictureCell else { return }
        
        guard let originImage = cell.imageView.image else { return } // some image for baseImage
        
        let browser = SKPhotoBrowser(originImage: originImage, photos: pictureArray, animatedFromView: cell)
        browser.initializePageIndex(indexPath.item)
        let vc = cell.viewController()
        vc?.present(browser, animated: true, completion: nil)
    }
    
}



/// 各个自模块控制器的父类控制器
class GLTaskDetailBaseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    open lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 8, y: 0, width: view.frame.size.width-16, height: view.frame.size.height), style: UITableViewStyle.grouped)
        
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "GLTaskDetailItemHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: GLTaskDetailItemHeaderId)
        
        tableView.register(UINib(nibName: "GLTaskDetailItemCell", bundle: nil), forCellReuseIdentifier: GLTaskDetailItemCellId)
        
        tableView.register(GLTaskDetailFormCell.self, forCellReuseIdentifier: GLTaskDetailFormCellId)
        
        tableView.register(UINib(nibName: "GLTaskDetailTableViewPictureCell", bundle: nil), forCellReuseIdentifier: GLTaskDetailTableViewPictureCellId)
        
        tableView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0)
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.separatorColor = .clear
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        tableView.bounces = false
        
        return tableView
    }()
    
    
    lazy var noAuthorityView: GLGPSnoAuthorityView = {
        let noView = Bundle.main.loadNibNamed("GLGPSnoAuthorityView", owner: nil, options: nil)?.first as! GLGPSnoAuthorityView
        noView.frame = tableView.bounds
        return noView
    }()
    
    var isLoadingFinish = false
    
    /// 重用标识符
    fileprivate let GLTaskDetailItemCellId = "GLTaskDetailItemCellId"
    fileprivate let GLTaskDetailItemHeaderId = "GLTaskDetailItemHeaderId"
    fileprivate let GLTaskDetailFormCellId = "GLTaskDetailFormCellId"
    fileprivate let GLTaskDetailTableViewPictureCellId = "GLTaskDetailTableViewPictureCellId"
    
    open var dataArray: [GLSectionModel] = [] {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.snp.remakeConstraints { (make) in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view).offset(1)
            make.bottom.equalTo(view)
        }
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewDidScroll(tableView)
        
    }
    
    
    
    func updateUI() {
        if dataArray.count < 1 && isLoadingFinish == true {
            noAuthorityView.frame = tableView.bounds
            tableView.addSubview(noAuthorityView)
        }
        tableView.reloadData()
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = dataArray[section]
        return sectionModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = dataArray[indexPath.section]
        let model = sectionModel.items[indexPath.row]
        
        if let itemModel = model as? GLItemModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GLTaskDetailItemCellId) as? GLTaskDetailItemCell else {
                return GLTaskDetailItemCell()
            }
            
            cell.itemModel = itemModel
            
            return cell
        }
        
        if let formModel = model as? GLFormModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GLTaskDetailFormCellId) as? GLTaskDetailFormCell else {
                return GLTaskDetailFormCell()
            }
            cell.formModel = formModel
            return cell
        }
        
        if let pictureModel = model as? GLPictureModel {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GLTaskDetailTableViewPictureCellId) as? GLTaskDetailTableViewPictureCell else {
                return GLTaskDetailTableViewPictureCell()
            }
            
            cell.pictureModel = pictureModel
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: GLTaskDetailItemHeaderId) as? GLTaskDetailItemHeader else {
            return nil
        }
        sectionHeader.sectionModel = dataArray[section]
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = dataArray[indexPath.section]
        let model = sectionModel.items[indexPath.row]
        if let model = model as? GLFormModel {
            return CGFloat((model.dataArray.count+1)) * GLTaskDetailFormCell.rowHeight + GLTaskDetailFormCell.margin
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == dataArray.count - 1 {
            return 0.01
        }
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let parentVc = parent as? GLTaskDetailGPSViewController else {
            return
        }
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY <= 0 {
            parentVc.topViewTopConstraint.constant = 0
        } else if contentOffsetY > 0 && contentOffsetY <= 65 {
            parentVc.topViewTopConstraint.constant = -contentOffsetY
        } else {
            parentVc.topViewTopConstraint.constant = -65
        }
    }
}



class GL基本信息ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "基本信息")
    }
    
    
}


class GL评估信息ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
   
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "评估信息")
    }
}

class GL风险控制ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "风险控制")
    }
}

class GL尽职调查ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "尽职调查")
    }
}

class GL合同签约ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "合同签约")
    }
}

class GL资料附件ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "资料附件")
    }
}

class GL费用及放款ViewController: GLTaskDetailBaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "费用及放款")
    }
}





/// 二期GPS 下户 抵押 审批 框架控制器
class GLTaskDetailGPSViewController: GLButtonBarPagerTabStripViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var typeButton: UIButton!
    
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var submitBtn: DesignableButton!
    
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
    /// 列表cell模型
    var model: GLWorkTableModel? {
        didSet {
            
        }
    }
    
    var detailGPSBigModel: GLGPSTaskDetailBigModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "任务详情"
        taskDetailTypeAndStatus()
        
        loadData()
    }
    
    func taskDetailTypeAndStatus() -> Void {
        titleLabel.text = model?.executionId
        subTitleLabel.text = model?.store_name
        
        switch model?.status {
        case GLWorkTableModel.StatusEnum.notDeal.rawValue: // 未完成
            if model?.statusType == GLWorkTableModel.TaskType.GPS {
                typeButton.setTitle("待装GPS", for: .normal)
                submitBtn.setTitle("安装GPS", for: .normal)
            } else if model?.statusType == GLWorkTableModel.TaskType.underHouse {
                typeButton.setTitle("待下户", for: .normal)
                submitBtn.setTitle("下户", for: .normal)
            } else if model?.statusType == GLWorkTableModel.TaskType.pledge {
                typeButton.setTitle("待抵质押", for: .normal)
                submitBtn.setTitle("抵质押办理", for: .normal)
            } else if model?.statusType == GLWorkTableModel.TaskType.approve {
                typeButton.setTitle("待审批", for: .normal)
                submitBtn.setTitle("审批", for: .normal)
            }
            break
        case GLWorkTableModel.StatusEnum.yetDeal.rawValue: // 已完成
            typeButton.backgroundColor = .white
            typeButton.setTitleColor(YiBlueColor, for: .normal)
            bottomViewBottomConstraint.constant = -64
            
            if model?.statusType == GLWorkTableModel.TaskType.approve { // 已经审批的
                typeButton.setTitle("已审批", for: .normal)
                if detailGPSBigModel == nil { return }
                var examinerModel: GLGPSTaskDetailBigModel.GLExaminerModel?
                for examinerM in detailGPSBigModel.examiner {
                    if examinerM.exam_name == GLUser.partyName {
                        examinerModel = examinerM
                        break
                    }
                }
                
                if let examinerModel = examinerModel {
                    if examinerModel.exam_status == "1" {
                        typeButton.setTitle("同意放款", for: .normal)
                        typeButton.backgroundColor = YiBlueColor
                        typeButton.setTitleColor(.white, for: .normal)
                    } else {
                        typeButton.setTitle("拒绝放款", for: .normal)
                        typeButton.backgroundColor = YiRedColor
                        typeButton.setTitleColor(.white, for: .normal)
                    }
                }
                
                
            }
            break
        default:
            return
        }
    }
    
    /// 基本信息数据
    var basicDataArray = [GLSectionModel]()
    
    /// 评估信息数据
    var estimateDataArray = [GLSectionModel]()
    
    /// 风险控制数据
    var riskControlDataArray = [GLSectionModel]()
    
    /// 尽职调查数据
    var investigateDataArray = [GLSectionModel]()
    
    /// 合同数据
    var pactDataArray = [GLSectionModel]()
    
    /// 附件数据
    var accessoryDataArray = [GLSectionModel]()
    
    /// 费用及放款
    var costDataArray = [GLSectionModel]()
    
    /// 加载数据 数据驱动
    func loadData() {
        
        view.showLoading()
        GLProvider.request(GLService.GPSDetail(partyId: GLUser.partyId!, l_number: (model?.executionId)!)) { [weak self] (result) in
            self?.view.hideLoading()
            if case let .success(respon) = result {
                let json = JSON(respon.data)
                if json["type"] == "S" {
                    print(json)
                    self?.detailGPSBigModel = GLGPSTaskDetailBigModel.deserialize(from: json.rawString(), designatedPath: "results")
                    
                    self?.taskDetailTypeAndStatus()
                    
                    if let detailGPSBigModel = self?.detailGPSBigModel {
                        print(detailGPSBigModel)
                        
                        self?.basicDataArray = GLModelConvert.basicData(model: detailGPSBigModel)
                        self?.updateBasicVcUI()
                        
                        self?.estimateDataArray = GLModelConvert.estimateData(model: detailGPSBigModel)
                        self?.updateEstimateVcUI()
                        
                        self?.riskControlDataArray = GLModelConvert.riskControlData(model: detailGPSBigModel)
                        self?.updateRiskControlVcUI()
                        
                        self?.investigateDataArray = GLModelConvert.investigateData(model: detailGPSBigModel)
                        self?.updateInvestigateVcUI()
                        
                        self?.pactDataArray = GLModelConvert.pactData(model: detailGPSBigModel)
                        self?.updatePactVcUI()
                        
                        self?.accessoryDataArray = GLModelConvert.accessoryData(model: detailGPSBigModel)
                        self?.updateAccessoryVcUI()
                        
                        self?.costDataArray = GLModelConvert.costData(model: detailGPSBigModel)
                        self?.updateCostVcUI()
                    }
                    
                }
            }
        }
        
        
    }
    
    /// 更新基本信息UI
    func updateBasicVcUI() {
        vc1.isLoadingFinish = true
        vc1.dataArray = basicDataArray
    }
    
    /// 更新评估信息UI
    func updateEstimateVcUI() {
        vc2.isLoadingFinish = true
        vc2.dataArray = estimateDataArray
    }
    
    
    /// 更新风险控制UI
    func updateRiskControlVcUI() {
        vc3.isLoadingFinish = true
        vc3.dataArray = riskControlDataArray
    }
    
    /// 更新尽职调查UI
    func updateInvestigateVcUI() {
        vc4.isLoadingFinish = true
        vc4.dataArray = investigateDataArray
    }
    
    func updatePactVcUI() {
        vc5.isLoadingFinish = true
        vc5.dataArray = pactDataArray
    }
    
    func updateAccessoryVcUI() {
        vc6.isLoadingFinish = true
        vc6.dataArray = accessoryDataArray
    }
    
    func updateCostVcUI() {
        vc7.isLoadingFinish = true
        vc7.dataArray = costDataArray
    }
    
    @IBAction func submitBtnClick(_ sender: DesignableButton) {
        
        if model?.statusType == GLWorkTableModel.TaskType.GPS {
            // 安装GPS
            guard let installGPSNaVc = UIStoryboard(name: "GLInstallGPS", bundle: nil).instantiateInitialViewController() as? GLNavigationController else { return }
            guard let vc = installGPSNaVc.topViewController as? GLInstallGPSViewController else { return }
            vc.model = model
            vc.submitSuccess = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: YiRefreshNotificationName, object: nil)
            }
            present(installGPSNaVc, animated: true, completion: nil)
            
        } else if model?.statusType == GLWorkTableModel.TaskType.underHouse {
            
            // 下户
            guard let underHouseNaVc = UIStoryboard(name: "GLUnderhouse", bundle: nil).instantiateInitialViewController() as? GLNavigationController else { return }
            
            guard let vc = underHouseNaVc.topViewController as? GLUnderhouseViewController else { return }
            vc.model = model
            vc.submitSuccess = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
                 NotificationCenter.default.post(name: YiRefreshNotificationName, object: nil)
            }
            present(underHouseNaVc, animated: true, completion: nil)
            
        } else if model?.statusType == GLWorkTableModel.TaskType.pledge {
            
            // 抵质押办理
            guard let pledgeNaVc = UIStoryboard(name: "GLPledge", bundle: nil).instantiateInitialViewController() as? GLNavigationController else { return }
            guard let vc = pledgeNaVc.topViewController as? GLPledgeViewController else { return }
            vc.model = model
            vc.submitSuccess = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
                 NotificationCenter.default.post(name: YiRefreshNotificationName, object: nil)
            }
            present(pledgeNaVc, animated: true, completion: nil)
        } else if model?.statusType == GLWorkTableModel.TaskType.approve {
            /// 显示信息视图
            let showMsgView = showSubmitMessageView()
            weak var weakShowMsgView = showMsgView
            showMsgView.submitClosure = { [weak self] (remarks) in
                
                var exam_status = ""
                
                if weakShowMsgView?.lastBtn == nil {
                    weakShowMsgView?.makeToast("请选择同意放款/拒绝放款")
                    return
                }
                
                if weakShowMsgView?.lastBtn == weakShowMsgView?.agreeBtn {
                    exam_status = "1"
                } else {
                    exam_status = "2"
                }
                
                
                
                let tabBarVc = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as? GLTabBarController
                GLProvider.request(GLService.submitApprove(partyId: GLUser.partyId!, processId: (self?.model?.processId)!, processTaskId: (self?.model?.processTaskId)!, l_number: (self?.model?.executionId)!, lend_apply_id: (self?.model?.description)!, exam_status: exam_status, remarks: remarks), completion: { (result) in
                    
                    if case let .success(respon) = result {
                        let json = JSON(respon.data)
                        if json["type"] == "S" {
                            tabBarVc?.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_success"), title: "提交成功")
                            NotificationCenter.default.post(name: YiRefreshNotificationName, object: nil)
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                                tabBarVc?.dismissCover(btn: nil)
                                self?.navigationController?.popViewController(animated: true)
                            })
                        } else {
                            tabBarVc?.showLoadingView(img: #imageLiteral(resourceName: "taskdetail_submit_failure"), title: "提交失败")
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                                tabBarVc?.dismissCover(btn: nil)
                                if json["code"] == "ERROR" {
                                    NotificationCenter.default.post(name: YiRefreshNotificationName, object: nil)
                                    self?.navigationController?.popViewController(animated: true)
                                }
                            })
                        }
                    }
                })
                
            }
            
        }
    }
    
    
    lazy var tabBarVc = tabBarController as! GLTabBarController
    lazy var submitMessageView: GLApproveView = {
        let accessoryView = Bundle.main.loadNibNamed("GLApproveView", owner: nil, options: nil)?.first as! GLApproveView
        let width = view.bounds.width
        accessoryView.frame.size.width = width
        accessoryView.frame.origin.x = 0
        
        return accessoryView
    }()
    
    func showSubmitMessageView() -> GLApproveView {
        let mask = tabBarVc.showMaskView()
        guard let maskView = mask else {
            return submitMessageView
        }
        submitMessageView.frame.origin.y = maskView.frame.size.height
        maskView.addSubview(submitMessageView)
        
        UIView.animate(withDuration: 0.25) {
            self.submitMessageView.frame.origin.y = maskView.frame.size.height - self.submitMessageView.frame.size.height
        }
        return submitMessageView
    }
    
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        
        return [vc1, vc2, vc3, vc4, vc5, vc6, vc7]
    }
    
    lazy var vc1 = { () -> GL基本信息ViewController in
        return GL基本信息ViewController()
    }()
    
    lazy var vc2 = { () -> GL评估信息ViewController in
        return GL评估信息ViewController()
    }()
    
    lazy var vc3 = { () -> GL风险控制ViewController in
        return GL风险控制ViewController()
    }()
    
    lazy var vc4 = { () -> GL尽职调查ViewController in
        return GL尽职调查ViewController()
    }()
    
    lazy var vc5 = { () -> GL合同签约ViewController in
        return GL合同签约ViewController()
    }()
    
    lazy var vc6 = { () -> GL资料附件ViewController in
        return GL资料附件ViewController()
    }()
    
    lazy var vc7 = { () -> GL费用及放款ViewController in
        return GL费用及放款ViewController()
    }()
    
}
