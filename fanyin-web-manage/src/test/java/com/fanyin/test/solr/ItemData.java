package com.fanyin.test.solr;

import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrInputDocument;
import org.junit.Before;
import org.junit.Test;

import java.util.List;
import java.util.Map;

/**
 * @author 二哥很猛
 * @date 2018/12/10 10:29
 */

public class ItemData {

    private HttpSolrClient httpSolrClient;

    @Before
    public void before(){
        httpSolrClient = new HttpSolrClient.Builder("http://localhost:8888/solr/my_core").withConnectionTimeout(30000).withSocketTimeout(30000).build();
    }

    @Test
    public void addApi(){

    }

    @Test
    public void addData()throws Exception{
        Solr solr = new Solr();
        solr.setId("199");
        solr.setName("大哥很猛");
        httpSolrClient.addBean(solr);
        httpSolrClient.commit();
    }


    @Test
    public void deleteData()throws Exception{
        //httpSolrClient.deleteById("1");
        httpSolrClient.deleteByQuery("name:三哥");
        httpSolrClient.commit();
    }

    /**
     * 通过document方式添加
     */
    @Test
    public void addDocument()throws Exception{
        SolrInputDocument document = new SolrInputDocument();
        document.addField("id","10080");
        document.addField("name","中国移动");
        httpSolrClient.add(document);
        httpSolrClient.commit();
    }

    @Test
    public void query()throws Exception{
        SolrQuery query = new SolrQuery();
        query.setQuery("name:哥");
        query.setSort("id",SolrQuery.ORDER.desc);
        query.setStart(0);
        query.setRows(2);
        query.setHighlight(true);
        query.addHighlightField("name");
        query.setHighlightSimplePre("<em>");
        query.setHighlightSimplePost("</em>");
        QueryResponse response = httpSolrClient.query(query);
        List<Solr> beans = response.getBeans(Solr.class);
        Map<String, Map<String, List<String>>> highlighting = response.getHighlighting();
        for (Map.Entry<String,Map<String,List<String>>> entry : highlighting.entrySet()){
            for(Solr solr : beans){
                if(!entry.getKey().equals(solr.getId())){
                    continue;
                }
                solr.setName(entry.getValue().get("name").toString());
                break;
            }
        }
        for (Solr bean : beans) {
            System.out.println(bean);
        }
    }

}
