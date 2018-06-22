package com.fanyin.test.asm;


import org.springframework.asm.ClassWriter;
import org.springframework.asm.MethodVisitor;
import org.springframework.asm.Opcodes;

/**
 * @author 王艳兵
 * @date 2018/3/9 17:48
 */
public class AsmCreateTest {

    public static ClassWriter createClass(String className){
        ClassWriter writer = new ClassWriter(ClassWriter.COMPUTE_MAXS);
        writer.visit(Opcodes.V1_8,Opcodes.ACC_PUBLIC,className,null,"java/lang/Object",null);
        MethodVisitor methodVisitor = writer.visitMethod(Opcodes.ACC_PUBLIC, "<init>", "()V", null, null);
        methodVisitor.visitVarInsn(Opcodes.AALOAD,0);
        //
        methodVisitor.visitMethodInsn(Opcodes.INVOKESPECIAL,"java/lang/Object","<init>","()V",false);
        methodVisitor.visitInsn(Opcodes.RETURN);
        methodVisitor.visitMaxs(1,1);
        methodVisitor.visitEnd();
        return writer;
    }

    public static byte[] createMethod(String clasName,String message){
        ClassWriter cw = createClass(clasName.replace('.', '/'));
        //创建run方法
        //()V表示函数，无参数，无返回值
        MethodVisitor runMethod = cw.visitMethod(Opcodes.ACC_PUBLIC, "run", "()V", null, null);
        //先获取一个java.io.PrintStream对象
        runMethod.visitFieldInsn(Opcodes.GETSTATIC, "java/lang/System", "out", "Ljava/io/PrintStream;");
        //将int, float或String型常量值从常量池中推送至栈顶  (此处将message字符串从常量池中推送至栈顶[输出的内容])
        runMethod.visitLdcInsn(message);
        //执行println方法（执行的是参数为字符串，无返回值的println函数）
        runMethod.visitMethodInsn(Opcodes.INVOKEVIRTUAL, "java/io/PrintStream", "println", "(Ljava/lang/String;)V", false);
        runMethod.visitInsn(Opcodes.RETURN);
        runMethod.visitMaxs(1, 1);
        runMethod.visitEnd();
        return cw.toByteArray();
    }
    public static void main(String[] args) throws Exception{
        String className = "com.fanyin.test.asm.AsmTest";
        byte[] classData = createMethod(className, "This is my first ASM test");
        Class<?> clazz = new MyClassLoader().defineClassForName(className, classData);
        clazz.getMethods()[0].invoke(clazz.newInstance());
    }
}
