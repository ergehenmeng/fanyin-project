package com.fanyin.test.solr;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;
import org.apache.solr.client.solrj.beans.Field;

import java.io.Serializable;

/**
 * @author 二哥很猛
 * @date 2018/12/10 13:44
 */
@JsonIgnoreProperties(ignoreUnknown = true)
@Data
public class Solr implements Serializable {
    private static final long serialVersionUID = -3365062486387243352L;

    @Field("id")
    private String id;

    @Field("name")
    private String name;

    public Solr() {
    }
}
