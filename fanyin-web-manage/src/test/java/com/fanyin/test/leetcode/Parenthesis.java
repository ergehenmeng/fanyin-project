package com.fanyin.test.leetcode;

import com.fanyin.test.leetcode.assist.ListNode;
import com.fanyin.test.leetcode.assist.TreeNode;
import org.assertj.core.util.Lists;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author 王艳兵
 * @date 2018/10/29 18:13
 */
public class Parenthesis {



    private static List<String> generateParenthesis(int n) {
        List<String> list = Lists.newArrayList();
        parser(list,"",0,0,n);
        return list;
    }

    private static void  parser(List<String> list,String str,int open,int close,int max){
        if(str.length() == max * 2){
            list.add(str);
            return ;
        }
        if(open < max){
            parser(list,str + "(" ,open + 1 ,close,max);
        }
        if(close < open){
            parser(list,str + ")" ,open ,close + 1,max);
        }
    }

    /**
     * 三个数等于零
     * Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.
     * @param nums
     * @return
     */
    private static List<List<Integer>> threeSum(int[] nums) {
        Arrays.sort(nums);
        List<List<Integer>> lists = new ArrayList<>();
        int length = nums.length;
        for(int i = 0;i < length - 2 ; i++){
            if(i != 0 && nums[i] == nums[i-1]) {
                continue;
            }
            int left = i + 1;
            int right = length -1;
            int now = - nums[i];
            while (left < right){
                int total = nums[left] + nums[right];
                if(total == now){
                    lists.add(Arrays.asList(nums[left],nums[i],nums[right]));
                    while (left < right  && nums[left] == nums[left + 1]){
                        //过滤重复
                        left ++;
                    }
                    while (left < right  && nums[right] == nums[right - 1]){
                        //过滤重复
                        right--;
                    }
                    left++ ;
                    right --;
                }else if(total < now){
                    //now负的太大
                    left ++;
                }else{
                    //now负的太小
                    right -- ;
                }
            }
        }
        return lists;
    }


    /**
     * Input: ["flower","flow","flight"]
     * Output: "fl"
     * Write a function to find the longest common prefix string amongst an array of strings.
     * If there is no common prefix, return an empty string "".
     * @param strs
     * @return
     */
    public String longestCommonPrefix(String[] strs) {
        if(strs.length == 1){
            return strs[0];
        }
        return "";
    }


    private static String longestCommonPrefix1(String[] strs) {
        if (strs.length == 0) return "";
        String prefix = strs[0];
        for (int i = 1; i < strs.length; i++){
            while(strs[i].indexOf(prefix) != 0){
                prefix = prefix.substring(0,prefix.length()-1);
            }
            if("".equals(prefix)){
                return prefix;
            }
        }
        return prefix;
    }

    private static ListNode mergeTwoLists(ListNode first, ListNode second) {
        ListNode head = first.val <= second.val ? first : second;
        ListNode current = head;
        if (first == head) {
            first = first.next;
        } else {
            second = second.next;
        }

        while (first != null || second != null){
            if(first == null){
                current.next = second;
                break;
            }
            if(second == null){
                current.next = first;
                break;
            }
            if (first.val < second.val){
                current.next = first;
                first = first.next;
            }else{
                current.next = second;
                second = second.next;
            }
            current  = current.next;
        }
        return head;
    }

    public ListNode mergeTwoLists2(ListNode l1, ListNode l2) {
        ListNode head = new ListNode(0);

        ListNode p = head;
        ListNode list1 = l1;
        ListNode list2 = l2;
        while(list1 != null && list2 != null){

            if(list1.val <= list2.val){
                p.next = list1;
                list1 = list1.next;
            }else{
                p.next = list2;
                list2 = list2.next;
            }
            p = p.next;
        }
        if(list1 != null){
            p.next = list1;
        }
        if(list2 != null){
            p.next = list2;
        }

        return head.next;

    }

    /**
     * 0,0,1,1,1,2,2,3,3,4,5,6,7,7,8,8去除重复
     * @param nums
     * @return
     */
    private static int removeDuplicates(int[] nums) {
        int s = 1;
        for (int j = 1;j < nums.length ;j ++){
            if(nums[j] != nums[j-1]){
                nums[s] = nums[j];
                s++;
            }
        }
        return s;
    }

    /**
     * -2,1,-3,4,-1,2,1,-5,4,最大值的子列总和 =6
     * @param nums
     * @return
     */
    private static int maxSubArray(int[] nums) {

        if (nums.length == 1) return nums[0];
        int currentMax = nums[0];
        int resultMax = nums[0];
        for (int i = 1; i < nums.length; i++) {
            currentMax = Math.max(nums[i], nums[i] + currentMax);
            resultMax = (currentMax > resultMax) ? currentMax : resultMax;
        }
        return resultMax;
    }

    /**
     * 数组最后一位加一 10的话进位
     * @param digits
     * @return
     */
    public static int[] plusOne(int[] digits) {

        int n = digits.length;
        for(int i=n-1; i>=0; i--) {
            if(digits[i] < 9) {
                digits[i]++;
                return digits;
            }

            digits[i] = 0;
        }

        int[] newNumber = new int [n+1];
        newNumber[0] = 1;

        return newNumber;
    }

    private static String addBinary(String a, String b) {
        int alength = a.length() - 1;
        int blength = b.length() - 1;
        int carry = 0;
        StringBuilder builder = new StringBuilder();
        while (alength >= 0 || blength >= 0){
            carry /= 2 ;
            if(alength >= 0){
                carry += a.charAt(alength--) - '0';
            }
            if(blength >= 0){
                carry += b.charAt(blength--) - '0';
            }
            builder.append(carry % 2);
        }
        if(carry > 1){
            builder.append(1);
        }
        return builder.reverse().toString();
    }

    public static int mySqrt(int x) {
        if(x < 1) return 0;
        int low = 1;
        int high = x;
        while(low <= high){
            //1--------4--------8
            int mid = (high - low) / 2 + low;
            if(x / mid == mid){
                return mid;
            }
            if(x / mid > mid){
                low = mid + 1;
            }
            if(x / mid < mid){
                high = mid - 1;
            }
        }
        return high;
    }

    /**
     * 爬楼梯的方法数 斐波那契数列
     * @param n
     * @return
     */
    public static int climbStairs(int n) {
        if (n == 1) {
            return 1;
        }
        int first = 1;
        int second = 2;
        for (int i = 3; i <= n; i++) {
            int third = first + second;
            first = second;
            second = third;
        }
        return second;
    }

    /**
     * 链表中删除重复数据
     * @param head
     * @return
     */
    public static ListNode deleteDuplicates(ListNode head) {
        if(head == null || head.next == null){
            return head;
        }
        ListNode header = new ListNode(head.val);
        ListNode headerNext = header;
        ListNode current = head.next;

        while (current != null){
            if(headerNext.val == current.val){
                current = current.next;
                continue;
            }
            headerNext =  headerNext.next = new ListNode(current.val);
            current = current.next;
        }
        return header;
    }

    /**
     * 链表中删除重复数据
     * @param head
     * @return
     */
    public static ListNode deleteDuplicates2(ListNode head) {

        ListNode cur = head;
        while(cur != null){
            while(cur.next != null && cur.val==cur.next.val ){
                cur.next=cur.next.next;
            }
            cur=cur.next;
        }
        return head;
    }


    /**
     * 两个树是否值是否一样
     * @param p
     * @param q
     * @return
     */
    public static boolean isSameTree(TreeNode p, TreeNode q) {
        return (p == null || q == null) ? p == q : (p.val == q.val && isSameTree(p.left , q.left) && isSameTree(p.right,q.right));
    }

    public static boolean isSymmetric(TreeNode root) {

        return isLeftSameRight(root.left,root.right);
    }

    private static boolean isLeftSameRight(TreeNode left,TreeNode right){
        if(left == null && right == null){
            return true;
        }
        if(left == null || right == null){
            return false;
        }
        if(left.val == right.val){
            return isLeftSameRight(left.left,right.right) && isLeftSameRight(left.right,right.left);
        }

        return false;
    }

    public static void main(String[] args) {



        System.out.println("爬楼梯:");
        System.out.println(climbStairs(6));

        System.out.println("字符串二进制加减");
        System.out.println(addBinary("1010","1011"));

        System.out.println(mySqrt(8));

        List<String> stringList = generateParenthesis(5);
        for (String str : stringList){
            System.out.println(str);
        }
        int[] sums = {14,9,14,-9,-6,-10,2,6,-11,-5,12,-6,6,-6,-9,-1,-14,7,-9,13,8,9,9,10,8,5,-10,-11,-9,-4,-15,-10,-10,-15,-12,-9,12};
        int[] sums2 = {-1,0,1,2,-1,-4};
        List<List<Integer>> lists = threeSum(sums2);
        for (List<Integer> list : lists){
            list.forEach(integer -> System.out.print(integer + ","));
            System.out.println("");
        }
        System.out.println(longestCommonPrefix1(new String[]{"flower","flow","flight"}));

        ListNode node = new ListNode(1);
        ListNode node1 = new ListNode(2);
        ListNode node2 = new ListNode(2);
        ListNode node3 = new ListNode(7);
        ListNode node4 = new ListNode(7);
        ListNode node9 = new ListNode(8);
        ListNode node10 = new ListNode(9);
        ListNode node11 = new ListNode(9);
        node.next = node1;
        node1.next = node2;
        node2.next = node3;
        node3.next = node4;
        node4.next = node9;
        node9.next = node10;
        node10.next = node11;

        ListNode nodes = new ListNode(3);
        ListNode node5 = new ListNode(5);
        ListNode node6 = new ListNode(8);
        ListNode node7 = new ListNode(9);
        ListNode node8 = new ListNode(12);
        nodes.next = node5;
        node5.next = node6;
        node6.next = node7;
        node7.next = node8;

        ListNode listNode = mergeTwoLists(node, nodes);
        while (listNode != null){
            System.out.println(listNode.val);
            listNode = listNode.next;
        }

        System.out.println(removeDuplicates(new int[]{0,0,1,1,1,2,2,3,3,4,5,6,7,7,8,8}));;
        System.out.println("最大值列");
        System.out.println(maxSubArray(new int[]{-2,1,-3,4,-1,2,1,-5,4}));

        System.out.println("最后一位加一");
        int[] ints = plusOne(new int[]{1, 8, 3, 9});
        for (int i : ints){
            System.out.print(i + ",");
        }

        System.out.println("去除重复");
        System.out.println(deleteDuplicates2(node));
    }

}
