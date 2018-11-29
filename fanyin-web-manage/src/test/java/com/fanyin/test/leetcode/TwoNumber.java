package com.fanyin.test.leetcode;

import com.fanyin.test.leetcode.assist.ListNode;

/**
 * @author 二哥很猛
 * @date 2018/9/25 13:52
 */
public class TwoNumber {

    public ListNode addTwoNumbers(ListNode a1, ListNode a2) {
        ListNode result = new ListNode(0);
        ListNode b1 = a1,b2 = a2,current = result;
        int carry = 0;
        while (b1 != null || b2 != null){
            int x = b1 != null ? b1.val : 0;
            int y = b2 != null ? b2.val : 0;
            //carry用来判断是否进位
            int sum = carry + x + y;
            carry = sum / 10;
            current.next = new ListNode(sum % 10);
            current = current.next;
            if(b1 != null){
                b1 = b1.next;
            }
            if(b2 != null){
                b2  = b2.next;
            }
        }
        //进位了
        if( carry > 0){
            current.next = new ListNode(carry);
        }
        return result.next;
    }

    public ListNode addTwoNumbers2(ListNode a1, ListNode a2) {
        ListNode result = new ListNode(0);
        ListNode b1 = a1,b2 = a2,current = result;
        while (b1 != null || b2 != null){
            int x = b1 != null ? b1.val:0;
            int y = b2 != null ? b2.val:0;
            int sum = x + y;
            int z = sum / 10;

            current.next = new ListNode(sum % 10);
            current = current.next;

            if(z > 0){
                if(b1 != null){
                    setVal(b1,z);
                }else{
                    setVal(b2,z);
                }
            }
            if(b1 != null){
                b1 = b1.next;
            }
            if(b2 != null){
                b2 = b2.next;
            }
        }
        return result.next;
    }

    private void setVal(ListNode b1,int z){
        ListNode nextB1 = b1.next;
        if(nextB1 == null){
            b1.next = new ListNode(z);
        }else{
            nextB1.val = nextB1.val + z;
        }
    }

    public static void main(String[] args) {
        TwoNumber number = new TwoNumber();
        ListNode a1 = new ListNode(2);
        ListNode a2 = new ListNode(4);
        ListNode a3 = new ListNode(3);
        a1.next = a2;
        a2.next = a3;


        ListNode b1 = new ListNode(5);
        ListNode b2 = new ListNode(6);
        ListNode b3 = new ListNode(4);
        b1.next = b2;
        b2.next = b3;

        ListNode listNode = number.addTwoNumbers2(a1, b1);
        ListNode print = listNode;
        while (print != null){
            System.out.println(print.val);
            print = print.next;
        }
    }

}
