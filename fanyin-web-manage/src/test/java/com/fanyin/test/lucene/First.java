package com.fanyin.test.lucene;


import org.apache.commons.io.FileUtils;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import java.io.File;
import java.nio.file.Path;

/**
 * @author 二哥很猛
 * @date 2018/12/10 15:33
 */
public class First {
    public static void main(String[] args) throws Exception{
        File file = new File("D:\\lucene");
        Path path = file.toPath();
        Directory directory = FSDirectory.open(path);
        Analyzer analyzer = new StandardAnalyzer();
        IndexWriterConfig config = new IndexWriterConfig(analyzer);
        File source = new File("D:\\tuodaoGit\\financeBank\\src\\main\\java\\com\\tuodao\\admin\\account\\service\\impl");
        File[] files = source.listFiles();
        try (IndexWriter writer = new IndexWriter(directory,config);){
            if(files != null){
                for (File f : files){
                    Document  document = new Document();
                    String fileName = f.getName();
                    Field fileNameField = new TextField("fileName",fileName,Field.Store.YES);
                    long size = FileUtils.sizeOf(f);
                    Field sizeField = new DoubleDocValuesField("size",size);
                    String filePath = f.getPath();
                    Field pathField = new StoredField("path",filePath);
                    String fileContent = FileUtils.readFileToString(f,"utf-8");
                    Field fileContentField = new TextField("fileContent",fileContent,Field.Store.YES);
                    document.add(fileNameField);
                    document.add(sizeField);
                    document.add(pathField);
                    document.add(fileContentField);
                    writer.addDocument(document);
                }
            }
        }

        DirectoryReader reader = DirectoryReader.open(directory);
        IndexSearcher searcher = new IndexSearcher(reader);

        Query query = new FieldValueQuery("fileContent");
        TopDocs search = searcher.search(query, 10);
        System.out.println("共匹配:" + search.totalHits);

        ScoreDoc[] scoreDocs = search.scoreDocs;
        for (ScoreDoc doc : scoreDocs){
            int docId = doc.doc;
            Document document = reader.document(docId);
            System.out.println("fileName:" + document.get("fileName"));
            System.out.println("fileContent:" + document.get("fileContent"));
            System.out.println("Score:" + doc.score);
        }
    }
}
