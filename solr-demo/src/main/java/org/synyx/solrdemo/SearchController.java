package org.synyx.solrdemo;

import java.util.List;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.response.FacetField;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller()
public class SearchController {

    private SolrServer solrServer;

    public SearchController(SolrServer solrServer) {
        this.solrServer = solrServer;
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String search(@RequestParam(value = "query", required = false) String query,
            @RequestParam(value = "keyword", required = false) List<String> keywords,
            Model model) throws SolrServerException {

        if (query != null && !query.isEmpty()) {
            // construct solr query using query string
            SolrQuery params = new SolrQuery(query);


            if (keywords != null) {
                for (String keyword : keywords) {
                    params.addFilterQuery(String.format("keywords:%s", keyword));
                }
            }
            // Send query to Solr
            QueryResponse response = solrServer.query(params);
            FacetField facet = response.getFacetField("keywords");

            model.addAttribute("results", response.getResults());
            model.addAttribute("facetValues", facet.getValues());
            model.addAttribute("highlighting", response.getHighlighting());
        }
        return "search";
    }
}
