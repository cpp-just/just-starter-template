local function dir_exists(path)
    local file = io.open(path, "r")
    if file then
        local ok, err, code = file:read(1)
        file:close()

        if code == 21 then
            return true
        end
    end
    return false
end

function get_lib_dirs()
    local lib_paths = {}
    local p = io.popen('[ -d packages ] && ls -1 packages')
    for folder in p:lines() do
        local lib_path = "packages/" .. folder .. "/lib"
        if dir_exists(lib_path) then
            table.insert(lib_paths, lib_path)
        end
    end
    p:close()
    return lib_paths
end

function get_links()
    local files = {}
    for _, lib_path in ipairs(get_lib_dirs()) do
        local p = io.popen('ls -1 ' .. lib_path)
        for file in p:lines() do
            local filename = file:match("lib(.+)%..+")
            table.insert(files, filename)
        end
        p:close()
    end
    return files
end

function get_include_dirs()
    local include_paths = { "../src" }
    local p = io.popen('[ -d packages ] && ls -1 packages')
    for folder in p:lines() do
        local include_path = "packages/" .. folder .. "/include"
        if dir_exists(include_path) then
            table.insert(include_paths, include_path)
        end
    end
    p:close()
    return include_paths
end

return {
    get_lib_dirs = get_lib_dirs,
    get_links = get_links,
    get_include_dirs = get_include_dirs
}
