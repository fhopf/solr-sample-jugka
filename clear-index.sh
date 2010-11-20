curl 'http://localhost:8983/solr/update?commit=true' -F stream.body=' <delete><query>*:*</query></delete>'
