local testlib = {}

local tests = 0
local failed = 0
local passed = 0

function log(info)
    print("[info]: "..info)
end

function log_error(error)
    print("--> [error]: "..error)
end

function testlib.init() 
    tests = 0
    failed = 0
    passed = 0
    print("")
    print("")
    print("-----Test starts-----")
end

function testlib.title(text)
    print("test: "..text)
    return body
end

function isArray(any) 
    if type(any) == "number" then return false end
    return #any ~= nil and any[1] ~= nil
end

function convertAnyToString(any)
    if any == nil then return "/nil" end
    if any == true then return "bool/true" end
    if any == false then return "bool/false" end

    if isArray(any) then 
        local str = ""
        for i=1, #any do 
            str = str..any[i]..","
        end
        return str
    end
    return ""..any
end

function deep_equals(a, b) 
    local result = true
    if #a ~= #b then 
        result = false
    else
        for i=1,#a do
            if a[i] ~= b[i] then 
                result = false
                break
            end
        end
    end
    return result
end

function testlib.assert_equal(a, b, description)
    if description == nil then description = "unset description" end
    tests = tests + 1
    
    local test_failed = false
    
    if a ~= b then
        if isArray(a) and isArray(b) then 
            test_failed = not deep_equals(a,b)
        else 
            test_failed = true
        end
    end

    if test_failed then 
        failed = failed + 1
        log_error(description.." failed -> "..convertAnyToString(a).." != "..convertAnyToString(b))
    else 
        passed = passed + 1
    end
end

function testlib.result()
    
    if failed > 0 then log_error(""..failed.."/"..passed.." tests failed!") else 
        log("test succeded: "..passed.."/"..tests.." passed")
    end
end

return testlib