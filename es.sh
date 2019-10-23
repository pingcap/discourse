docker run --rm --name es -p 9200:9200 -p 9300:9300 -v $(pwd)/data:/usr/share/elasticsearch/data peterzhang/elasticsearch-analysis-ik
