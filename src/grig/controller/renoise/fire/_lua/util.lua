_hx_insert_tag_value = function(table, tag, value)
    table:insert({tag = tag,value = value})
end

_hx_length = function(table)
    return #table;
end