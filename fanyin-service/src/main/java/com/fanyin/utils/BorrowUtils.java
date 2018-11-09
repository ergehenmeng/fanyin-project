package com.fanyin.utils;


import com.fanyin.dto.BorrowList;
import com.google.common.collect.Lists;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * @author 二哥很猛
 * @date 2017/8/14 11:10:55
 */
public class BorrowUtils {

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
     * 等额本息获取收益
     * @param money  投资金额
     * @param period 投资期数 月
     * @param apr 利率
     * @param type  期限类型:0:天 1:月 2:年
     * @return divisor
     */
    public static double fixedPaymentMortgage(double money,int period,double apr,int type){

        double monthApr = getMonthApr(apr,type);

        double monthMoney = getMonthMoney(monthApr,period,money);
        //剩余本金
        double residueMoney = money;
        //总利息
        double totalInterest = 0;

        for (int i = 1; i <= period; i++){
            //当期利息
            double interest = BigDecimalUtils.mul(residueMoney,monthApr);
            if(i < period){
                //剩余本金 = 原剩余本金-(月还款金额-月还款利息) = 原剩余本金-本期还款本金
                residueMoney = BigDecimalUtils.sub(residueMoney,BigDecimalUtils.sub(monthMoney,interest));
            }
            totalInterest = BigDecimalUtils.add(interest,totalInterest);
        }
        return BigDecimalUtils.round(totalInterest);
    }

    /**
     * 计算等额本息 :月还款=（本金*月利息*（1+月利率）^投资期限）/（（1+月利率）^投资期限-1）
     * @param monthApr 月利息
     * @param period 期数
     * @param money 金额
     * @return 月还款金额 保留两位小数
     */
    private static double getMonthMoney(double monthApr,int period,double money){
        //公用的
        double common = Math.pow(BigDecimalUtils.add(1,monthApr,SCALE),period);
        //除数
        double divisor = BigDecimalUtils.mul(money,monthApr,common);
        //被除数
        double dividend = BigDecimalUtils.sub(common , 1,SCALE);
        //被除数为0 直接返回0
        if (dividend == 0){
            return 0D;
        }
        return BigDecimalUtils.round(BigDecimalUtils.div(divisor,dividend));
    }

    /**
     * 等额本息获取收益默认投资期限类型为月 :月还款=（本金*月利息*（1+月利率）^投资期限）/（（1+月利率）^投资期限-1）
     * @param money  投资金额
     * @param period 投资期数 月
     * @param apr 收益 %;
     * @return divisor
     */
    public static double fixedPaymentMortgage(double money,int period,double apr){
        return fixedPaymentMortgage(money,period,apr,TYPE_MONTH);
    }
    /**
     * 获取月利息
     * @param apr 年化利息
     * @param type 期限类型:0:天 1:月 2:年
     * @return 月利息
     */
    private static double getMonthApr(double apr,int type){
        //转换为标准的利率
        apr = BigDecimalUtils.centToYuan(apr);
        if(TYPE_DAY == type){
            return BigDecimalUtils.div(apr,365);
        }
        if(TYPE_YEAR == type){
            return apr;
        }
        //月利息
        return BigDecimalUtils.div(apr,12);
    }


    /**
     * 按月付息 总收益
     * @param money 投标金额
     * @param period 投资期数
     * @param apr 利息 %
     * @param type   期限单位:0:天 1:月 2:年
     * @return
     */
    public static double perMonth(double money,int period,double apr,int type){
        double interest =  BigDecimalUtils.mul(getMonthApr(apr,type),money,period);
        return BigDecimalUtils.round(interest);
    }

    /**
     * 按月付息 总收益
     * @param money 投标金额
     * @param period 投资期数
     * @param apr 利息 %
     * @return
     */
    public static double perMonth(double money,int period,double apr){
        return perMonth(money,period,apr,TYPE_MONTH);

    }


    /**
     * 等额本息生成回款计划
     * @param periods 总期数
     * @param money 投标金额
     * @param apr 基础利息
     * @param platformApr 平台加息
     * @param couponApr 加息券
     * @return
     */
    public static List<BorrowList> collectionFixedPaymentMortgage(int periods, double money, double apr, double platformApr, double couponApr, Date start){
        return collectionFixedPaymentMortgage(periods,money,apr,platformApr,couponApr,start,TYPE_MONTH);
    }

    /**
     * 等额本息生成回款计划,回款时间以当天开始进行计算
     * @param periods 总期数
     * @param money 投标金额
     * @param apr 基础利息
     * @param platformApr 平台加息
     * @param couponApr 加息券
     * @param type 期限类型:0:天 1:月 2:年
     * @return
     */
    public static List<BorrowList> collectionFixedPaymentMortgage(int periods,double money,double apr,double platformApr,double couponApr,Date start,int type){
        //基础平台利息
        double baseMonthApr = getMonthApr(apr,type);
        //平台加息
        double platformMonthApr = getMonthApr(platformApr,type);
        //加息券
        double couponMonthApr = getMonthApr(couponApr,type);
        //月还款
        double baseMonthMoney = getMonthMoney(baseMonthApr,periods,money);
        //剩余本金
        double residueMoney = money;
        List<BorrowList> list = new ArrayList<>();
        BorrowList plan;
        for (int i = 1; i <= periods; i++){
            plan = new BorrowList();

            //基础收益
            double baseInterest = BigDecimalUtils.round(BigDecimalUtils.mul(residueMoney,baseMonthApr));
            //平台加息收益
            double platformInterest = BigDecimalUtils.round(BigDecimalUtils.mul(residueMoney,platformMonthApr));
            //加息券收益
            double couponInterest = BigDecimalUtils.round(BigDecimalUtils.mul(residueMoney,couponMonthApr));
            //本金
            double capital;
            //最后一期
            if(i == periods ){
                capital = residueMoney;
            }else{
                // 本期还款本金
                capital = BigDecimalUtils.sub(baseMonthMoney,baseInterest);
            }
            /**
             * 由于月还款金额四舍五入,在投标金额极小的时候,月还款金额会变大,
             * 因此每期还款本金可能会变大导致 最后一期或几期无剩余本金可还 因而出现负数
             */
            residueMoney = BigDecimalUtils.sub(residueMoney,capital);
            if (residueMoney < 0){
                residueMoney = 0;
            }

            //回款时间依次延续
            plan.setPreCollectionTime(getRepaymentDate(start,i,type));
            //预计回款月
            plan.setPreMonth(DateUtil.formatMin(plan.getPreCollectionTime()));
            plan.setPeriods(periods);
            //期数
            plan.setPeriod(i);
            //当期抵用券奖励
            plan.setPreCouponInterest(BigDecimal.valueOf(couponInterest));
            //当期平台加息奖励
            plan.setPrePlatformInterest(BigDecimal.valueOf(platformInterest));
            //当期回款本金
            plan.setPreCapital(BigDecimal.valueOf(capital));
            //当期总利息:基础利息+加息券利息+平台奖励利息
            double totalInterest = BigDecimalUtils.add(BigDecimalUtils.add(baseInterest,platformInterest),couponInterest);
            plan.setPreInterest(BigDecimal.valueOf(totalInterest));

            list.add(plan);
        }
        return list;
    }


    /**
     * 计算回款或还款时间
     * @param startTime 开始时间 默认当前日期
     * @param period 当前为第几期
     * @param periodUnit 期限单位
     * @return
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
     * @return
     */
    public static List<BorrowList> collectionPerMonth(int periods,double money,double apr,double platformApr,double couponApr,Date start){
        return collectionPerMonth(periods,money,apr,platformApr,couponApr,start,TYPE_MONTH);
    }

    /**
     * 按月付息生成回款信息列表
     * @param periods 总期数
     * @param money 投资金额
     * @param apr 基础利息
     * @param platformApr 平台加息
     * @param couponApr 个人加息券
     * @param start  生成还款计划的开始时间
     * @param type 类型:0:按天计息 1:按月计息 2:按年计息
     * @return
     */
    public static List<BorrowList> collectionPerMonth(int periods,double money,double apr,double platformApr,double couponApr,Date start,int type){
        //基础平台利息
        double baseMonthApr = getMonthApr(apr,type);
        //平台加息
        double platformMonthApr = getMonthApr(platformApr,type);
        //加息券
        double couponMonthApr = getMonthApr(couponApr,type);

        /**
         * 由于生成回款记录时,总收益计算不一定等于每期回款收益相加总额 (四舍五入导致的)
         * 因此 最后一期需要额外计算
         */
        double baseTotal = perMonth(money, periods, apr, type);
        double platformTotal = perMonth(money, periods, platformApr, type);
        double couponTotal = perMonth(money, periods, couponApr, type);

        List<BorrowList> list = new ArrayList<>();
        BorrowList plan;
        for(int i = 1; i <= periods; i++){
            plan = new BorrowList();
            //最后一期回本金
            if(i == periods){
                plan.setPreCapital(BigDecimal.valueOf(money));
                plan.setPrePlatformInterest(BigDecimal.valueOf(platformTotal));
                plan.setPreCouponInterest(BigDecimal.valueOf(couponTotal));
                plan.setPreCollectionTime(getRepaymentDate(start,i,type));
                //预计回款月
                plan.setPreMonth(DateUtil.formatMin(plan.getPreCollectionTime()));
                double totalInterest = BigDecimalUtils.add(BigDecimalUtils.add(baseTotal,platformTotal),couponTotal);
                plan.setPreInterest(BigDecimal.valueOf(totalInterest));
                plan.setPeriod(i);
                plan.setPeriods(periods);
                list.add(plan);
            }else{
                //不回款本金
                plan.setPreCapital(BigDecimal.ZERO);
                double platformInterest = BigDecimalUtils.round(BigDecimalUtils.mul(platformMonthApr,money));
                double couponInterest = BigDecimalUtils.round(BigDecimalUtils.mul(couponMonthApr,money));
                double baseInterest = BigDecimalUtils.round(BigDecimalUtils.mul(baseMonthApr,money));
                plan.setPrePlatformInterest(BigDecimal.valueOf(platformInterest));
                plan.setPreCouponInterest(BigDecimal.valueOf(couponInterest));
                plan.setPreCollectionTime(getRepaymentDate(start,i,type));
                //预计回款月
                plan.setPreMonth(DateUtil.formatMin(plan.getPreCollectionTime()));
                double totalInterest = BigDecimalUtils.add(BigDecimalUtils.add(baseInterest,platformInterest),couponInterest);

                plan.setPreInterest(BigDecimal.valueOf(totalInterest));
                plan.setPeriod(i);
                plan.setPeriods(periods);

                baseTotal = BigDecimalUtils.sub(baseTotal,baseInterest);
                platformTotal = BigDecimalUtils.sub(platformTotal,platformInterest);
                couponTotal = BigDecimalUtils.sub(couponTotal,couponInterest);

                list.add(plan);
            }
        }
        return list;
    }


    /**
     * 按天计息 总收益计算
     * @param money 金额 分
     * @param periods 投资天数
     * @param apr 利息 %
     * @return
     */
    public static double preDaily(double money,int periods,double apr){
        double interest =  BigDecimalUtils.mul(getMonthApr(apr,TYPE_DAY),money,periods);
        return BigDecimalUtils.round(interest);
    }

    /**
     * 按天计息 期限单位自动无效 默认一期
     * @param periods  期限(天)
     * @param money 金额 分
     * @param apr 基础利息
     * @param platformApr 平台奖励
     * @param couponApr 加息券奖励
     * @return
     */
    public static List<BorrowList> collectionPreDaily(int periods,double money,double apr,double platformApr,double couponApr){
        double totalApr = BigDecimalUtils.add(BigDecimalUtils.add(apr, platformApr), couponApr);
        //总利息 = 平台加息+基础+加息券
        double interest = preDaily(money,periods,totalApr);
        //平台加息
        double platformInterest = preDaily(money,periods,platformApr);
        //加息券
        double couponInterest = preDaily(money,periods,couponApr);

        BorrowList borrowList = new BorrowList();
        borrowList.setPeriod(1);
        borrowList.setPeriods(1);
        borrowList.setPreInterest(BigDecimal.valueOf(interest));
        borrowList.setPreCouponInterest(BigDecimal.valueOf(couponInterest));
        borrowList.setPrePlatformInterest(BigDecimal.valueOf(platformInterest));
        borrowList.setPreCollectionTime(DateUtil.addDays(new Date(),periods));
        borrowList.setPreMonth(DateUtil.formatMin(borrowList.getPreCollectionTime()));
        borrowList.setPreCapital(BigDecimal.valueOf(money));

        return Lists.newArrayList(borrowList);
    }




    public static void main(String[] args) {
        /*List<BorrowList> list = collectionFixedPaymentMortgage(3,100000,10,0,0,new Date());
        list.forEach(borrowPlan -> System.out.println(borrowPlan));
        System.out.println(fixedPaymentMortgage(100000,3,10));;

        List<BorrowList> plans = collectionPerMonth(3,100000,10,0,0,new Date());
        plans.forEach(borrowPlan -> System.out.println(borrowPlan));

        System.out.println(perMonth(100000,3,10));;

        List<BorrowList> plans1 = collectionPreDaily(15, 10000, 10, 2, 0);
        plans1.forEach(borrowPlan -> System.out.println(borrowPlan));*/
        System.out.println(fixedPaymentMortgage(10000,6,10,1));
    }
 
}
