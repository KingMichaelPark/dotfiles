function GH(author_package)
    return "https://github.com/" .. author_package
end

function CB(author_package)
    return "https://codeberg.org/" .. author_package
end

return { gh = GH, cb = CB }
