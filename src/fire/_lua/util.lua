_hx_insert_tag_value = function(table, tag, value)
    table:insert({tag = tag,value = value})
end

_hx_length = function(table)
    return #table;
end

_hx_table_push = function(table, item)
    table[#table + 1]=item;
end

_hx_table_clear = function(table)
    for k in pai (table) do
        table [k] = nil
    end
end