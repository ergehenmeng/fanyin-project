package com.fanyin.test.xml.dom;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;
import java.io.File;

/**
 * @author 王艳兵
 * @date 2019/3/28 13:53
 */
public class DomTest {
    public static void main(String[] args)throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new File("C:\\Users\\fanyin\\Desktop\\mybatis.xml"));
        XPathFactory instance = XPathFactory.newInstance();
        XPath xPath = instance.newXPath();
        XPathExpression expression = xPath.compile("/invebtory/book");
        NodeList evaluate = (NodeList) expression.evaluate(document, XPathConstants.NODESET);
        int length = evaluate.getLength();
        for (int i = 0;i < length;i++){
            System.out.println(evaluate.item(i).getNodeValue());
        }
        int sum = 0;
        int x = 24600;
        for(int i=0;i<12 ;i++){
            x+=1200;
            sum += x;
        }
        System.out.println(sum);


    }
}
