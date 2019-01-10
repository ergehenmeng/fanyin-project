package com.fanyin.utils;


import com.fanyin.model.project.ProjectPlan;
import com.google.common.collect.Maps;

import java.math.BigDecimal;
import java.util.*;


/**
 * @author 二哥很猛
 * @date 2017/8/14 11:10:55
 */
public class ProjectUtil {

    /**
     * 期限单位:天
     */
    private static final int TYPE_DAY = 0;

    /**
     * 期限单位:月
     */
    private static final int TYPE_MONTH = 1;
    /**
     * 期限单位:年
     */
    private static final int TYPE_YEAR = 2;

    /**
     * 精度保留10位
     */
    private static final int SCALE = 10;

    /**
     * 0 不做处理
     */
    private static final double ZERO = 0D;

    /**
     * 等额本息计算总收益<br>
     * 默认投资期限类型为月 :月还款=（本金*月利息*（1+月利率）^投资期限）/（（1+月利率）^投资期限-1）
     * @param money  投资金额
     * @param period 投资期数 月
     * @param apr 收益 %;
     * @return divisor
     */
    public static double equalAmountOfInterest(double money,int period,double apr){
        return equalAmountOfInterest(money,period,apr,TYPE_MONTH);
    }

    /**
     * 等额本息计算总收益
     * @param money  投资金额
     * @param period 投资期数 月
     * @param apr 利率
     * @param type  期限类型:0:天 1:月 2:年
     * @return divisor
     */
    public static double equalAmountOfInterest(double money,int period,double apr,int type){
        if(money == ZERO || period == ZERO || apr == ZERO){
            return ZERO;
        }

        double monthApr = getMonthApr(apr,type);

        double monthMoney = getMonthMoney(monthApr,period,money);
        //剩余本金
        double residueMoney = money;
        //总利息
        double totalInterest = 0;

        for (int i = 1; i <= period; i++){
            //当期利息
            double interest = BigDecimalUtil.mul(residueMoney,monthApr);
            if(i < period){
                //剩余本金 = 原剩余本金-(月还款金额-月还款利息) = 原剩余本金-本期还款本金
                residueMoney = BigDecimalUtil.sub(residueMoney,BigDecimalUtil.sub(monthMoney,interest));
            }
            totalInterest = BigDecimalUtil.add(interest,totalInterest);
        }
        return BigDecimalUtil.round(totalInterest);
    }

    /**
     * 计算等额本息 :月还款=（本金*月利息*（1+月利率）^投资期限）/（（1+月利率）^投资期限-1）
     * @param monthApr 月利息
     * @param period 期数
     * @param money 金额
     * @return 月还款金额 保留两位小数
     */
    private static double getMonthMoney(double monthApr,int period,double money){
        if(monthApr == ZERO || period == ZERO || money == ZERO){
            return ZERO;
        }
        //公用的
        double common = Math.pow(BigDecimalUtil.add(1,monthApr,SCALE),period);
        //除数
        double divisor = BigDecimalUtil.mul(money,monthApr,common);
        //被除数
        double dividend = BigDecimalUtil.sub(common , 1,SCALE);
        //被除数为0 直接返回0
        if (dividend == 0){
            return 0D;
        }
        return BigDecimalUtil.round(BigDecimalUtil.div(divisor,dividend));
    }

    /**
     * 获取月利息
     * @param apr 年化利息
     * @param type 期限类型:0:天 1:月 2:年
     * @return 月利息
     */
    private static double getMonthApr(double apr,int type){
        if(apr == ZERO){
            return ZERO;
        }
        //转换为标准的利率
        apr = BigDecimalUtil.centToYuan(apr);
        if(TYPE_DAY == type){
            return BigDecimalUtil.div(apr,365);
        }
        if(TYPE_YEAR == type){
            return apr;
        }
        //月利息
        return BigDecimalUtil.div(apr,12);
    }

    /**
     * 按月付息 总收益
     * @param money 投标金额
     * @param period 投资期数
     * @param apr 利息 %
     * @param type   期限单位:0:天 1:月 2:年
     * @return 按月付息总收益
     */
    public static double monthlyInterest(double money,int period,double apr,int type){
        if(money == ZERO || period == ZERO || apr == ZERO){
            return ZERO;
        }
        double interest =  BigDecimalUtil.mul(getMonthApr(apr,type),money,period);
        return BigDecimalUtil.round(interest);
    }

    /**
     * 按月付息 总收益
     * @param money 投标金额
     * @param period 投资期数
     * @param apr 利息 %
     * @return 按月付息总收益
     */
    public static double monthlyInterest(double money,int period,double apr){
        return monthlyInterest(money,period,apr,TYPE_MONTH);
    }


    /**
     * 等额本息生成回款计划
     * @param periods 总期数
     * @param money 投标金额
     * @param apr 基础利息
     * @param platformApr 平台加息
     * @param couponApr 加息券
     * @return 回款列表
     */
    public static List<ProjectPlan> equalAmountRecoverList(int periods, double money, double apr, double platformApr, double couponApr){
        return equalAmountRecoverList(periods,money,apr,platformApr,couponApr,TYPE_MONTH);
    }

    /**
     * 等额本息生成回款计划,回款时间以当天开始进行计算
     * @param periods 总期数
     * @param money 投标金额
     * @param apr 基础利息
     * @param platformApr 平台加息
     * @param couponApr 加息券
     * @param type 期限类型:0:天 1:月 2:年
     * @return 回款列表
     */
    public static List<ProjectPlan> equalAmountRecoverList(int periods, double money, double apr, double platformApr, double couponApr, int type){
        Date start = DateUtil.getNow();
        //基础平台月利率
        double baseMonthApr = getMonthApr(apr,type);
        //平台加息月利率
        double platformMonthApr = getMonthApr(platformApr,type);
        //加息券月利率
        double couponMonthApr = getMonthApr(couponApr,type);
        //月还款金额
        double baseMonthMoney = getMonthMoney(baseMonthApr,periods,money);
        //剩余本金
        double residueMoney = money;
        List<ProjectPlan> list = new ArrayList<>();
        ProjectPlan plan;
        for (int i = 1; i <= periods; i++){
            plan = new ProjectPlan();

            //基础收益
            double baseInterest = BigDecimalUtil.round(BigDecimalUtil.mul(residueMoney,baseMonthApr));
            //平台加息收益
            double platformInterest = BigDecimalUtil.round(BigDecimalUtil.mul(residueMoney,platformMonthApr));
            //加息券收益
            double couponInterest = BigDecimalUtil.round(BigDecimalUtil.mul(residueMoney,couponMonthApr));
            //本金
            double capital;
            //最后一期
            if(i == periods ){
                capital = residueMoney;
            }else{
                // 本期还款本金
                capital = BigDecimalUtil.sub(baseMonthMoney,baseInterest);
            }
            //由于月还款金额四舍五入,在投标金额极小的时候,月还款金额会变大,因此每期还款本金可能会变大导致 最后一期或几期无剩余本金可还 因而出现负数
            residueMoney = BigDecimalUtil.sub(residueMoney,capital);
            if (residueMoney < 0){
                residueMoney = 0;
            }

            //回款时间依次延续
            plan.setDay(getRepaymentDate(start,i,type));
            plan.setMonth(DateUtil.formatMin(plan.getDay()));
            plan.setPeriods(periods);
            plan.setPeriod(i);
            plan.setCouponInterest(BigDecimal.valueOf(couponInterest));
            plan.setPlatformInterest(BigDecimal.valueOf(platformInterest));
            plan.setCapital(BigDecimal.valueOf(capital));
            plan.setBaseInterest(BigDecimal.valueOf(baseInterest));
            list.add(plan);
        }
        return list;
    }


    /**
     * 计算回款或还款时间
     * @param startTime 开始时间 默认当前日期
     * @param period 当前为第几期
     * @param periodUnit 期限单位
     * @return 回款日期
     */
    private static Date getRepaymentDate(Date startTime,int period,int periodUnit){
        if(periodUnit == TYPE_DAY){
            return DateUtil.addDays(startTime,period);
        }else if(periodUnit == TYPE_MONTH){
            return DateUtil.addMonths(startTime,period);
        }else if(periodUnit == TYPE_YEAR){
            return DateUtil.addYears(startTime,period);
        }
        return startTime;
    }

    /**
     * 按月付息生成回款信息列表
     * @param periods 总期数
     * @param money 投资金额
     * @param apr 基础利息
     * @param platformApr 平台加息
     * @param couponApr 个人加息券
     * @return 按月付息回款计划
     */
    public static List<ProjectPlan> monthlyRecoverList(int periods, double money, double apr, double platformApr, double couponApr){
        return monthlyRecoverList(periods,money,apr,platformApr,couponApr,TYPE_MONTH);
    }

    /**
     * 按月付息生成回款信息列表
     * @param periods 总期数
     * @param money 投资金额
     * @param apr 基础利息
     * @param platformApr 平台加息
     * @param couponApr 个人加息券
     * @param type 类型:0:按天计息 1:按月计息 2:按年计息
     * @return 按月付息回款计划
     */
    public static List<ProjectPlan> monthlyRecoverList(int periods, double money, double apr, double platformApr, double couponApr, int type){
        //基础平台利息
        double baseMonthApr = getMonthApr(apr,type);
        //平台加息
        double platformMonthApr = getMonthApr(platformApr,type);
        //加息券
        double couponMonthApr = getMonthApr(couponApr,type);

        //由于生成回款记录时,总收益计算不一定等于每期回款收益相加总额 (四舍五入导致的),因此 最后一期需要额外计算
        double baseTotal = monthlyInterest(money, periods, apr, type);
        double platformTotal = monthlyInterest(money, periods, platformApr, type);
        double couponTotal = monthlyInterest(money, periods, couponApr, type);
        Date start = DateUtil.getNow();
        List<ProjectPlan> list = new ArrayList<>();
        ProjectPlan plan;
        for(int i = 1; i <= periods; i++){
            plan = new ProjectPlan();

            plan.setDay(getRepaymentDate(start,i,type));
            plan.setMonth(DateUtil.formatMin(plan.getDay()));
            plan.setPeriod(i);
            plan.setPeriods(periods);

            //不回款本金
            if(i == periods){
                plan.setCapital(BigDecimal.valueOf(money));
                plan.setBaseInterest(BigDecimal.valueOf(baseTotal));
                plan.setCouponInterest(BigDecimal.valueOf(couponTotal));
                plan.setPlatformInterest(BigDecimal.valueOf(platformTotal));
            }else{
                double platformInterest = BigDecimalUtil.round(BigDecimalUtil.mul(platformMonthApr,money));
                double couponInterest = BigDecimalUtil.round(BigDecimalUtil.mul(couponMonthApr,money));
                double baseInterest = BigDecimalUtil.round(BigDecimalUtil.mul(baseMonthApr,money));

                plan.setCapital(BigDecimal.ZERO);
                plan.setBaseInterest(BigDecimal.valueOf(baseInterest));
                plan.setCouponInterest(BigDecimal.valueOf(couponInterest));
                plan.setPlatformInterest(BigDecimal.valueOf(platformInterest));

                baseTotal = BigDecimalUtil.sub(baseTotal,baseInterest);
                platformTotal = BigDecimalUtil.sub(platformTotal,platformInterest);
                couponTotal = BigDecimalUtil.sub(couponTotal,couponInterest);
            }
            list.add(plan);
        }
        return list;
    }


    /**
     * 按天计息 总收益计算
     * @param money 金额 分
     * @param periods 投资天数
     * @param apr 利息 %
     * @return 天总利息
     */
    public static double dailyInterest(double money,int periods,double apr){
        if(money == ZERO || periods == ZERO || apr == ZERO){
            return ZERO;
        }
        double interest =  BigDecimalUtil.mul(getMonthApr(apr,TYPE_DAY),money,periods);
        return BigDecimalUtil.round(interest);
    }

    /**
     * 按天计息 期限单位自动无效 默认一期
     * @param periods  期限(天)
     * @param money 金额 分
     * @param apr 基础利息
     * @param platformApr 平台奖励
     * @param couponApr 加息券奖励
     * @return 还款计划
     */
    public static List<ProjectPlan> dailyRecoverList(int periods, double money, double apr, double platformApr, double couponApr){
        double totalApr = BigDecimalUtil.add(BigDecimalUtil.add(apr, platformApr), couponApr);
        //总利息 = 平台加息+基础+加息券
        double interest = dailyInterest(money,periods,totalApr);
        //平台加息
        double platformInterest = dailyInterest(money,periods,platformApr);
        //加息券
        double couponInterest = dailyInterest(money,periods,couponApr);

        ProjectPlan projectPlan = new ProjectPlan();
        projectPlan.setPeriod(1);
        projectPlan.setPeriods(1);
        projectPlan.setBaseInterest(BigDecimal.valueOf(interest));
        projectPlan.setCouponInterest(BigDecimal.valueOf(couponInterest));
        projectPlan.setPlatformInterest(BigDecimal.valueOf(platformInterest));
        projectPlan.setDay(DateUtil.addDays(new Date(),periods));
        projectPlan.setMonth(DateUtil.formatMin(projectPlan.getDay()));
        projectPlan.setCapital(BigDecimal.valueOf(money));
        return Collections.singletonList(projectPlan);
    }

    /**
     * 根据回款计划生成还款计划
     * @param projectPlans 单个人的回款计划
     * @param paymentMap 还款计划
     */
    public static void repaymentList(List<ProjectPlan> projectPlans, Map<Integer,ProjectPlan> paymentMap){
        projectPlans.forEach(projectPlan -> {
            ProjectPlan plan = paymentMap.get(projectPlan.getPeriod());
            if(plan == null){
                ProjectPlan copy = BeanCopyUtil.copy(projectPlan, ProjectPlan.class);
                paymentMap.put(copy.getPeriod(),copy);
            }else{
                plan.setBaseInterest(plan.getBaseInterest().add(projectPlan.getBaseInterest()));
                plan.setCapital(plan.getCapital().add(projectPlan.getCapital()));
                plan.setCouponInterest(plan.getCouponInterest().add(projectPlan.getCouponInterest()));
                plan.setPlatformInterest(plan.getPlatformInterest().add(projectPlan.getPlatformInterest()));
            }
        });
    }



    public static void main(String[] args) {
        List<ProjectPlan> list = equalAmountRecoverList(3,100000,10,0,0);

        list.forEach(System.out::println);

        System.out.println(equalAmountOfInterest(100000,3,10));

        List<ProjectPlan> plans = monthlyRecoverList(3,100000,10,0,0);

        plans.forEach(System.out::println);

        Map<Integer,ProjectPlan> repaymentMap = Maps.newHashMap();
        repaymentList(list,repaymentMap);
        System.out.println("还款计划");
        repaymentMap.values().forEach(System.out::println);



        System.out.println(monthlyInterest(100000,3,10));

        List<ProjectPlan> plans1 = dailyRecoverList(15, 10000, 10, 2, 0);

        plans1.forEach(System.out::println);

        System.out.println(equalAmountOfInterest(10000,6,10,1));
        System.out.println(new ProjectPlan());
    }
 
}
