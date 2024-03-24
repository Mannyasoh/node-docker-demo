function set_fields(tag, timestamp, record)
    record['host'] = record['log']['kubernetes']['host']
    record['log']['kubernetes']['host'] = nil
    record['pod_name'] = record['log']['kubernetes']['pod_name']
    record['log']['kubernetes']['pod_name'] = nil
    return 2, timestamp, record
end