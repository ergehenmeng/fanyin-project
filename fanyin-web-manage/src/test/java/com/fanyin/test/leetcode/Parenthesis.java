package com.fanyin.test.leetcode;

import com.fanyin.test.leetcode.assist.ListNode;
import com.fanyin.test.leetcode.assist.TreeNode;
import org.assertj.core.util.Lists;

import java.util.*;

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

    /**
     * 树是否镜像相同
     * @param root
     * @return
     */
    public static boolean isSymmetric(TreeNode root) {
        return root == null || isLeftSameRight(root.left,root.right);
    }

    private static boolean isLeftSameRight(TreeNode left,TreeNode right){
        return (left == null || right == null) ? left == right : (left.val == right.val && isLeftSameRight(left.left,right.right) && isLeftSameRight(left.right,right.left));
    }

    /**
     * 数的最大深度
     * @param root
     * @return
     */
    public static int maxDepth(TreeNode root) {
        return depth(root);
    }
    private static int depth(TreeNode depth){
        if(depth == null){
            return 0;
        }
        return Math.max(depth(depth.left),depth(depth.right)) + 1;
    }

    /**
     *
     * @param depth
     * @param height
     * @return
     */
    private static int depth2(TreeNode depth,int height){
        if(depth == null){
            return height;
        }
        return Math.max(depth2(depth.left,height + 1),depth2(depth.right,height + 1));
    }


    /**
     * 将数的同一级的书放入数组中
     * @param root
     * @return
     */
    private static List<List<Integer>> levelOrderBottom(TreeNode root) {
        List<List<Integer>> integerList = new ArrayList<>();
        if(root == null){
            return integerList;
        }
        dfs(root,integerList,0);
        return integerList;
    }

    /**
     *     3
     *    / \
     *   9  20
     *     /  \
     *    15   7
     * @param root
     * @param list
     * @param depth
     */
    private static void dfs(TreeNode root,List<List<Integer>> list,int depth){
        if(root == null){
            return;
        }
        if(list.size()  == depth){
            List<Integer> integerList = new ArrayList<>();
            integerList.add(root.val);
            list.add(0,integerList);
        }else{
            list.get(list.size() - 1 - depth).add(root.val);
        }
        dfs(root.left,list,depth + 1);
        dfs(root.right,list, depth +1);
    }

    /**
     * 数组转BST二叉树 左右节点不能超过一深度
     * @param nums
     * @return
     */
    public static TreeNode sortedArrayToBST(int[] nums) {
        return helper(nums, 0, nums.length-1);
    }

    private static TreeNode helper(int[] nums,int left,int right){
        if(left > right){
            return null;
        }
        int mid = (left + right + 1) / 2 ;
        TreeNode root = new TreeNode(nums[mid]);
        root.left =  helper(nums,left,mid - 1);
        root.right = helper(nums,mid + 1,right);
        return root;
    }

    /**
     * 是否为平衡二叉树
     * @param root
     * @return
     */
    public static boolean isBalanced(TreeNode root) {
        return height(root) >= 0;
    }

    /**
     * [1,2,2,3,3,null,null,4,4]
     *      1
     *    2   2
     *  3  3
     *4  4
     * @param root
     * @return
     */
    public static int height(TreeNode root){
        if(root == null){
            return 0;
        }
        int lh = height(root.left);
        int rh = height(root.right);
        if(lh == -1 || rh == -1 || Math.abs(lh - rh) > 1){
            return -1;
        }
        return Math.max(lh,rh) + 1;
    }

    public static int minDepth(TreeNode root) {
        return minDepth(root,0);
    }
    public static int minDepth(TreeNode root,int minDepth){
        if(root == null){
            return minDepth;
        }

        minDepth = Math.min(minDepth(root.left,minDepth),minDepth);
        minDepth = Math.min(minDepth(root.right,minDepth),minDepth);
        return minDepth;
    }

    public static boolean hasPathSum(TreeNode root, int sum) {
        if(root == null){
            return false;
        }
        int sub = sum - root.val;
        if(root.left == null && root.right == null && sub == 0){
            return true;
        }
        boolean leftFlag = hasPathSum(root.left,sub);
        boolean rightFlag = hasPathSum(root.right,sub);
        return leftFlag || rightFlag;
    }

    public static List<List<Integer>> generate(int numRows) {
        List<List<Integer>> listList = new ArrayList<>();
        List<Integer> list;
        for (int i = 1 ;i <= numRows;i++){
            if(i == 1){
                list = new ArrayList<>();
                list.add(1);
                listList.add(list);
                continue;
            }
            if(i == 2){
                list = new ArrayList<>();
                list.add(1);
                list.add(1);
                listList.add(list);
                continue;
            }
            list = new ArrayList<>();
            List<Integer> integerList = listList.get(i - 2);
            setValue(integerList,list,i);
            listList.add(list);
        }
        return listList;
    }

    private static void setValue(List<Integer> beforeList,List<Integer> nowList,int size){
        for (int i = 0 ;i < size; i++){
            if(i == 0 || i == size - 1){
                nowList.add(1);
                continue;
            }
            int first = beforeList.get(i);
            int second = beforeList.get(i -1 );
            nowList.add(first + second);
        }
    }

    /**
     * 股票最大价格
     * @param prices
     * @return
     */
    public int maxProfit(int[] prices) {
        int max = 0;
        for (int i = 0 ; i < prices.length;i++){
            for (int j = i + 1; j < prices.length;j++){
                max = Math.max(prices[j] - prices[i],max) ;
            }
        }
        return Math.max(max,0);
    }

    public int maxProfit2(int[] prices) {
        //买入价格
        int minPrice = Integer.MAX_VALUE;
        //利润
        int maxProfit = 0;

        for(int i=0;i < prices.length;i++){
            if(prices[i] < minPrice){
                minPrice = prices[i];
            }else if(prices[i] - minPrice > maxProfit){
                maxProfit = prices[i] - minPrice;
            }
        }
        return maxProfit;
    }

    public int maxProfit3(int[] prices) {
        int max = 0;
        for (int i = 0, j = 1; j < prices.length; j++) {
            if (prices[j] < prices[i]) {
                i = j;
            } else {
                max = Math.max(max, prices[j] - prices[i]);
            }
        }
        return max;
    }
    public int singleNumber(int[] nums) {

        int x = 0;
        for (int a : nums) {
            x = x ^ a;
        }
        return x;
    }

    public static void main(String[] args) {

        System.out.println("帕斯卡三角形");
        List<List<Integer>> generate = generate(5);
        for (List<Integer> list : generate){
            for (int i : list){
                System.out.print(i + ", " );
            }
            System.out.println("");
        }

        System.out.println("数的同行列表");
        TreeNode root = new TreeNode(3);
        TreeNode left = new TreeNode(9);
        TreeNode right = new TreeNode(20);
        TreeNode ll = new TreeNode(15);
        TreeNode rr = new TreeNode(7);
        root.left = left;
        root.right =right;
        right.left = ll;
        right.right = rr;
        levelOrderBottom(root);
        System.out.println("是否平衡");
        TreeNode first = new TreeNode(1);
        TreeNode a = new TreeNode(2);
        TreeNode b = new TreeNode(2);
        TreeNode c = new TreeNode(3);
        TreeNode d = new TreeNode(3);
        TreeNode e = new TreeNode(4);
        TreeNode f = new TreeNode(4);
        TreeNode g = new TreeNode(4);
        TreeNode h = new TreeNode(4);
        first.left = a; first.right = b;
        a.left = c; a.right = d;
        c.left = e;c.right = f;
        b.right = g;
        g.right = h;
        boolean balanced = isBalanced(first);
        System.out.println(balanced);

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
