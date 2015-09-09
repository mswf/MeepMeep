
require "base/base"
require "application/logging"

--When logging 'nil' there's a fallback string that gets printed
Log.steb()
Log.bobn()
Log.tinas()

Log.steb("-")

createEnum("TestEnum", "One", "Two", "Three")
Log.steb(TestEnum)

Log.steb("-")
local test = TestEnum.One
Log.steb(test)
