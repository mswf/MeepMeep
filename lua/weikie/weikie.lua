Weikie = class(Weikie, function(self)
	Log.waka("hello, initializer?");
end)

--private var
local koekje = 1;
--global var
yaya = 2;
--
--Weikie.qwe;

--public function
function Weikie:Asd()
	Log.waka(koekje);
	koekje = koekje + 1;
end

function Weikie:Qwe()
	local a, c, b = Weikie.GetStuff();
	Log.waka(a);
	Log.waka(b);
	Log.waka(c);
end

function Weikie:GetStuff()
	local a = 1;
	local b = 2;
	local c = 3;

	return a, b, c;
end

--private function DOES NOT EXIST, DEAL WITH IT
