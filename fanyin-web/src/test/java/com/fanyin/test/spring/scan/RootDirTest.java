package com.fanyin.test.spring.scan;

/**
 * @author 王艳兵
 * @date 2018/3/9 15:01
 */
public class RootDirTest {
    public static void main(String[] args) {
        String Str = "WelcxsxometoTutorialspoint.com";


        System.out.print("Found Last Index :" );
        System.out.println(Str.lastIndexOf( 'o' ));

        System.out.print("Found Last Index :" );
        System.out.println(Str.lastIndexOf( 'o', 10 ));


        String path = "classpath*:com/fanyin/**/*.class";
        int prefixEnd = path.indexOf(":") + 1;
        int rootDirEnd = path.length();
        while (rootDirEnd > prefixEnd && path.substring(prefixEnd, rootDirEnd).contains("*") ) {
            rootDirEnd = path.lastIndexOf('/', rootDirEnd - 2) + 1  ;
            System.out.println(path.substring(0,rootDirEnd));
        }
        if (rootDirEnd == 0) {
            rootDirEnd = prefixEnd;
        }
        String substring = path.substring(0, rootDirEnd);
        System.out.println(substring);
    }
}
