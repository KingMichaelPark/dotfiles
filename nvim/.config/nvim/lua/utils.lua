local l = function(additional_chars)
    local word = "<leader>" .. additional_chars
    return word
end

local o = function(options, desc)
    options["desc"] = desc
    return options
end

return { l = l, o = o }
