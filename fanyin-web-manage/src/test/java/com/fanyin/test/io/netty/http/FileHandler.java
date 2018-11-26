package com.fanyin.test.io.netty.http;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.*;
import io.netty.handler.codec.http.*;
import io.netty.handler.codec.rtsp.RtspHeaderNames;
import io.netty.handler.stream.ChunkedFile;
import io.netty.util.CharsetUtil;

import javax.activation.MimetypesFileTypeMap;
import java.io.File;
import java.io.RandomAccessFile;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.regex.Pattern;

/**
 * @author 二哥很猛
 * @date 2018/7/19 14:07
 */
public class FileHandler extends SimpleChannelInboundHandler<FullHttpRequest> {

    private final String url;

    public FileHandler(String url){
        this.url = url;
    }

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, FullHttpRequest request) throws Exception {
        if (!request.decoderResult().isSuccess()){
            sendError(ctx, HttpResponseStatus.BAD_REQUEST);
            return ;
        }
        if(request.method() != HttpMethod.GET){
            sendError(ctx, HttpResponseStatus.METHOD_NOT_ALLOWED);
            return ;
        }
        String uri = request.uri();
        String path = formatUri(uri);
        if(path == null){
            sendError(ctx, HttpResponseStatus.FORBIDDEN);
            return ;
        }
        File file = new File(path);
        if(file.isHidden() || !file.exists()){
            sendError(ctx,HttpResponseStatus.NOT_FOUND);
            return;
        }
        if(file.isDirectory()){
            sendListing(ctx,file,uri);
            return;
        }
        if(!file.isFile()){
            sendError(ctx,HttpResponseStatus.FORBIDDEN);
            return;
        }
        RandomAccessFile randomAccessFile;
        try {
            randomAccessFile = new RandomAccessFile(file,"r");
        }catch (Exception e){
            sendError(ctx,HttpResponseStatus.NOT_FOUND);
            return;
        }
        long length = randomAccessFile.length();
        HttpResponse response = new DefaultHttpResponse(HttpVersion.HTTP_1_1,HttpResponseStatus.OK);
        response.headers().set(HttpHeaderNames.CONTENT_LENGTH,length);
        MimetypesFileTypeMap map = new MimetypesFileTypeMap();
        response.headers().set(HttpHeaderNames.CONTENT_TYPE,map.getContentType(file));
        if (HttpUtil.isKeepAlive(request)){
            response.headers().set(HttpHeaderNames.CONNECTION, HttpHeaderValues.KEEP_ALIVE);
        }
        ctx.write(response);
        ChannelFuture future = ctx.write(new ChunkedFile(randomAccessFile, 0, length, 8192), ctx.newProgressivePromise());
        future.addListener(new ChannelProgressiveFutureListener() {
            @Override
            public void operationProgressed(ChannelProgressiveFuture future, long progress, long total) throws Exception {
                if (total < 0){
                    System.out.println("progress :" + progress);
                }else{
                    System.out.println("total:" + total);
                }
            }

            @Override
            public void operationComplete(ChannelProgressiveFuture future) throws Exception {

            }
        });

        ChannelFuture lastChannelFuture = ctx.writeAndFlush(LastHttpContent.EMPTY_LAST_CONTENT);

        if(HttpUtil.isKeepAlive(request)){
            lastChannelFuture.addListener(ChannelFutureListener.CLOSE);
        }
        ctx.executor();
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
        if(ctx.channel().isActive()){
           sendError(ctx,HttpResponseStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private void sendRedirect(ChannelHandlerContext ctx, String s) {
        FullHttpResponse response = new DefaultFullHttpResponse(HttpVersion.HTTP_1_1,HttpResponseStatus.FOUND);
        response.headers().set(RtspHeaderNames.CONTENT_LOCATION,s);
        ctx.writeAndFlush(response).addListener(ChannelFutureListener.CLOSE);
    }

    private void sendListing(ChannelHandlerContext ctx, File file,String uri) {
        FullHttpResponse response = new DefaultFullHttpResponse(HttpVersion.HTTP_1_1,HttpResponseStatus.OK);
        response.headers().set(RtspHeaderNames.CONTENT_TYPE,"text/html;charset=utf-8");
        StringBuilder builder = new StringBuilder();
        builder.append("<!DOCTYPE html>\r\n");
        builder.append("<html><head><title>");
        builder.append(file.getPath());
        builder.append("目录:");
        builder.append("</title></head><body>\r\n");
        builder.append("<h3>");
        builder.append(file.getPath());
        builder.append("目录:");
        builder.append("</h3>\r\n");
        builder.append("<ul>");
        builder.append("<li>链接:<a href=\"../\">  .. </a></li>\r\n");
        File[] files = file.listFiles();
        if(files != null){
            for (File f :files){
                if(f.isHidden() || !f.canRead()){
                    continue;
                }
                String name = f.getName();
                builder.append("<li>链接:<a href=\"");
                builder.append(uri);
                builder.append(File.separator);
                builder.append(name);
                builder.append("\" > ");
                builder.append(name);
                builder.append("</a></li>\r\n");
            }
            builder.append("</ul></body></html>\r\n");
        }
        ByteBuf byteBuf = Unpooled.copiedBuffer(builder, CharsetUtil.UTF_8);
        response.content().writeBytes(byteBuf);
        byteBuf.release();
        ctx.writeAndFlush(response).addListener(ChannelFutureListener.CLOSE);
    }

    private void sendError(ChannelHandlerContext context,HttpResponseStatus method){
        FullHttpResponse response = new DefaultFullHttpResponse(
                HttpVersion.HTTP_1_1,
                method,
                Unpooled.copiedBuffer("Failure: " + method.toString() + "\r\n" ,CharsetUtil.UTF_8)
        );
        response.headers().set(RtspHeaderNames.CONTENT_TYPE,"text/plain;charset=utf-8");

        context.writeAndFlush(response).addListener(ChannelFutureListener.CLOSE);
    }

    private static final Pattern PATTERN = Pattern.compile(".*[<>&\"].*");

    private String formatUri(String uri){
        try {
            uri = URLDecoder.decode(uri,"UTF-8");
        } catch (UnsupportedEncodingException e) {
            try {
                uri = URLDecoder.decode(uri,"ISO-8859-1");
            } catch (UnsupportedEncodingException e1) {
                throw new RuntimeException(e);
            }
        }

        if(!uri.startsWith("/")){
            return null;
        }
        uri = uri.replaceAll("//", File.separator);
        if(uri.contains(File.separator + ".")
                || uri.contains("." + File.separator)
                || uri.startsWith(".")
                || uri.endsWith(".")
                || PATTERN.matcher(uri).matches()){
            return null;
        }
        return System.getProperty("operator.dir") + url + uri;
    }
}
