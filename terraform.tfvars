nginx_external_port = {
    dev = [3000, 3001, 3002]
    qa  = [4000, 4001, 4002]
    prod = [81, 82, 83]
}

grafana_external_port = {
    dev = 3001
    qa  = 3000
    prod = 3000
}

redis_external_port = {
    dev = 6380
    qa  = 6379
    prod = 6379
}

postgre_external_port = {
    dev = 5432
    qa  = 5432
    prod = 5432
}