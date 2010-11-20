# index the presentation in a locally running solr
curl 'http://localhost:8983/solr/update/extract?literal.id=solr.odp&literal.keywords=java&literal.keywords=solr' -F "file=@solr.odp"
curl 'http://localhost:8983/solr/update' -F stream.body=' <commit/>'
