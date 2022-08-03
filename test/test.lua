t = require("lib/testlib")
c = require("tested_code")

local test = {}

function test.run()
    t.assert_equal(c.sort({4,3,2,1}),{1,2,3,4},"test sort")
    t.assert_equal(c.wrap_int(0, 0, 2, 1), 1, "test wrap_int 1")
    t.assert_equal(c.wrap_int(2, 0, 2, 1), 0, "test wrap_int 2")
    t.assert_equal(c.wrap_int(0, 0, 2, -1), 2, "test wrap_int 3")
    t.assert_equal(c.wrap_int(0, 0, 2, -3), 2, "test wrap_int 4")
    t.assert_equal(c.abs(5), 5, "test abs positive")
    t.assert_equal(c.abs(-5), 5, "test abs positive")
end

return test
