--[[
	Author: https://github.com/Fernando-A-Rocha

	shared.lua

	/!\ UNLESS YOU KNOW WHAT YOU ARE DOING, NO NEED TO CHANGE THIS FILE /!\
]]

thisRes = getThisResource()
resName = getResourceName(thisRes)

_outputDebugString = outputDebugString
function outputDebugString(text, mode, r,g,b)
	if not ENABLE_DEBUG_MESSAGES then return end
	if not CHAT_DEBUG_MESSAGES then
		_outputDebugString(text, mode, r,g,b)
	else

		if not mode then mode = 3 end

		if mode == 1 then
			r,g,b = 255,25,25
		elseif mode == 2 then
			r,g,b = 255,194,14
		elseif mode == 3 then
			r,g,b = 25,255,25
		end

		if not r then r = 255 end
		if not g then g = 255 end
		if not b then b = 255 end

		if isElement(localPlayer) then
			outputChatBox(text, r,g,b)
		else
			outputChatBox("((server)) "..text, root, r,g,b)
		end
	end
end

function getBaseModel(element) -- [Exported]
	return (getElementData(element, baseDataName) or getElementModel(element))
end

function getBaseModelDataName()
	return baseDataName
end

function getDataNameFromType(elementType) -- [Exported]
	if not elementType then return end
	return dataNames[elementType]
end

local pedIds = {1, 2, 7, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 66, 67, 68, 69, 70, 71, 72, 73, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312}
local vehicleIds = {400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611}
local function isDefaultObjectID(id)
	if id < 321 or id > 18630 then
		return false
	end
	local skippedObjectIds = {374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,524,525,526,527,528,529,530,531,532,533,534,535,536,537,538,539,540,541,542,543,544,545,546,547,548,549,550,551,552,553,554,555,556,557,558,559,560,561,562,563,564,565,566,567,568,569,570,571,572,573,574,575,576,577,578,579,580,581,582,583,584,585,586,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605,606,607,608,609,610,611,612,613,614,11682,11683,11684,11685,11686,11687,11688,11689,11690,11691,11692,11693,11694,11695,11696,11697,11698,11699,11700,11701,11702,11703,11704,11705,11706,11707,11708,11709,11710,11711,11712,11713,11714,11715,11716,11717,11718,11719,11720,11721,11722,11723,11724,11725,11726,11727,11728,11729,11730,11731,11732,11733,11734,11735,11736,11737,11738,11739,11740,11741,11742,11743,11744,11745,11746,11747,11748,11749,11750,11751,11752,11753,11754,11755,11756,11757,11758,11759,11760,11761,11762,11763,11764,11765,11766,11767,11768,11769,11770,11771,11772,11773,11774,11775,11776,11777,11778,11779,11780,11781,11782,11783,11784,11785,11786,11787,11788,11789,11790,11791,11792,11793,11794,11795,11796,11797,11798,11799,11800,11801,11802,11803,11804,11805,11806,11807,11808,11809,11810,11811,11812,11813,11814,11815,11816,11817,11818,11819,11820,11821,11822,11823,11824,11825,11826,11827,11828,11829,11830,11831,11832,11833,11834,11835,11836,11837,11838,11839,11840,11841,11842,11843,11844,11845,11846,11847,11848,11849,11850,11851,11852,11853,11854,11855,11856,11857,11858,11859,11860,11861,11862,11863,11864,11865,11866,11867,11868,11869,11870,11871,11872,11873,11874,11875,11876,11877,11878,11879,11880,11881,11882,11883,11884,11885,11886,11887,11888,11889,11890,11891,11892,11893,11894,11895,11896,11897,11898,11899,11900,11901,11902,11903,11904,11905,11906,11907,11908,11909,11910,11911,11912,11913,11914,11915,11916,11917,11918,11919,11920,11921,11922,11923,11924,11925,11926,11927,11928,11929,11930,11931,11932,11933,11934,11935,11936,11937,11938,11939,11940,11941,11942,11943,11944,11945,11946,11947,11948,11949,11950,11951,11952,11953,11954,11955,11956,11957,11958,11959,11960,11961,11962,11963,11964,11965,11966,11967,11968,11969,11970,11971,11972,11973,11974,11975,11976,11977,11978,11979,11980,11981,11982,11983,11984,11985,11986,11987,11988,11989,11990,11991,11992,11993,11994,11995,11996,11997,11998,11999,12000,12001,12002,12003,12004,12005,12006,12007,12008,12009,12010,12011,12012,12013,12014,12015,12016,12017,12018,12019,12020,12021,12022,12023,12024,12025,12026,12027,12028,12029,12030,12031,12032,12033,12034,12035,12036,12037,12038,12039,12040,12041,12042,12043,12044,12045,12046,12047,12048,12049,12050,12051,12052,12053,12054,12055,12056,12057,12058,12059,12060,12061,12062,12063,12064,12065,12066,12067,12068,12069,12070,12071,12072,12073,12074,12075,12076,12077,12078,12079,12080,12081,12082,12083,12084,12085,12086,12087,12088,12089,12090,12091,12092,12093,12094,12095,12096,12097,12098,12099,12100,12101,12102,12103,12104,12105,12106,12107,12108,12109,12110,12111,12112,12113,12114,12115,12116,12117,12118,12119,12120,12121,12122,12123,12124,12125,12126,12127,12128,12129,12130,12131,12132,12133,12134,12135,12136,12137,12138,12139,12140,12141,12142,12143,12144,12145,12146,12147,12148,12149,12150,12151,12152,12153,12154,12155,12156,12157,12158,12159,12160,12161,12162,12163,12164,12165,12166,12167,12168,12169,12170,12171,12172,12173,12174,12175,12176,12177,12178,12179,12180,12181,12182,12183,12184,12185,12186,12187,12188,12189,12190,12191,12192,12193,12194,12195,12196,12197,12198,12199,12200,12201,12202,12203,12204,12205,12206,12207,12208,12209,12210,12211,12212,12213,12214,12215,12216,12217,12218,12219,12220,12221,12222,12223,12224,12225,12226,12227,12228,12229,12230,12231,12232,12233,12234,12235,12236,12237,12238,12239,12240,12241,12242,12243,12244,12245,12246,12247,12248,12249,12250,12251,12252,12253,12254,12255,12256,12257,12258,12259,12260,12261,12262,12263,12264,12265,12266,12267,12268,12269,12270,12271,12272,12273,12274,12275,12276,12277,12278,12279,12280,12281,12282,12283,12284,12285,12286,12287,12288,12289,12290,12291,12292,12293,12294,12295,12296,12297,12298,12299,12300,12301,12302,12303,12304,12305,12306,12307,12308,12309,12310,12311,12312,12313,12314,12315,12316,12317,12318,12319,12320,12321,12322,12323,12324,12325,12326,12327,12328,12329,12330,12331,12332,12333,12334,12335,12336,12337,12338,12339,12340,12341,12342,12343,12344,12345,12346,12347,12348,12349,12350,12351,12352,12353,12354,12355,12356,12357,12358,12359,12360,12361,12362,12363,12364,12365,12366,12367,12368,12369,12370,12371,12372,12373,12374,12375,12376,12377,12378,12379,12380,12381,12382,12383,12384,12385,12386,12387,12388,12389,12390,12391,12392,12393,12394,12395,12396,12397,12398,12399,12400,12401,12402,12403,12404,12405,12406,12407,12408,12409,12410,12411,12412,12413,12414,12415,12416,12417,12418,12419,12420,12421,12422,12423,12424,12425,12426,12427,12428,12429,12430,12431,12432,12433,12434,12435,12436,12437,12438,12439,12440,12441,12442,12443,12444,12445,12446,12447,12448,12449,12450,12451,12452,12453,12454,12455,12456,12457,12458,12459,12460,12461,12462,12463,12464,12465,12466,12467,12468,12469,12470,12471,12472,12473,12474,12475,12476,12477,12478,12479,12480,12481,12482,12483,12484,12485,12486,12487,12488,12489,12490,12491,12492,12493,12494,12495,12496,12497,12498,12499,12500,12501,12502,12503,12504,12505,12506,12507,12508,12509,12510,12511,12512,12513,12514,12515,12516,12517,12518,12519,12520,12521,12522,12523,12524,12525,12526,12527,12528,12529,12530,12531,12532,12533,12534,12535,12536,12537,12538,12539,12540,12541,12542,12543,12544,12545,12546,12547,12548,12549,12550,12551,12552,12553,12554,12555,12556,12557,12558,12559,12560,12561,12562,12563,12564,12565,12566,12567,12568,12569,12570,12571,12572,12573,12574,12575,12576,12577,12578,12579,12580,12581,12582,12583,12584,12585,12586,12587,12588,12589,12590,12591,12592,12593,12594,12595,12596,12597,12598,12599,12600,12601,12602,12603,12604,12605,12606,12607,12608,12609,12610,12611,12612,12613,12614,12615,12616,12617,12618,12619,12620,12621,12622,12623,12624,12625,12626,12627,12628,12629,12630,12631,12632,12633,12634,12635,12636,12637,12638,12639,12640,12641,12642,12643,12644,12645,12646,12647,12648,12649,12650,12651,12652,12653,12654,12655,12656,12657,12658,12659,12660,12661,12662,12663,12664,12665,12666,12667,12668,12669,12670,12671,12672,12673,12674,12675,12676,12677,12678,12679,12680,12681,12682,12683,12684,12685,12686,12687,12688,12689,12690,12691,12692,12693,12694,12695,12696,12697,12698,12699,12700,12701,12702,12703,12704,12705,12706,12707,12708,12709,12710,12711,12712,12713,12714,12715,12716,12717,12718,12719,12720,12721,12722,12723,12724,12725,12726,12727,12728,12729,12730,12731,12732,12733,12734,12735,12736,12737,12738,12739,12740,12741,12742,12743,12744,12745,12746,12747,12748,12749,12750,12751,12752,12753,12754,12755,12756,12757,12758,12759,12760,12761,12762,12763,12764,12765,12766,12767,12768,12769,12770,12771,12772,12773,12774,12775,12776,12777,12778,12779,12780,12781,12782,12783,12784,12785,12786,12787,12788,12789,12790,12791,12792,12793,12794,12795,12796,12797,12798,12799}
	for _, i in ipairs(skippedObjectIds) do
		if i == id then
			return false
		end
	end
	return true
end

function isDefaultID(elementType, id) -- [Exported]
	id = tonumber(id)
	if not id then return end

	if not elementType then -- check all IDs
		for k,id2 in pairs(pedIds) do
			if id2 == id then
				return true
			end
		end
		for k,id2 in pairs(vehicleIds) do
			if id2 == id then
				return true
			end
		end
		return isDefaultObjectID(id)
	else
		if elementType == "ped" or elementType == "player" then
			for k,id2 in pairs(pedIds) do
				if id2 == id then
					return true
				end
			end
		elseif elementType == "object" then
			return isDefaultObjectID(id)
		elseif elementType == "vehicle" then
			for k,id2 in pairs(vehicleIds) do
				if id2 == id then
					return true
				end
			end
		end
	end
	return false
end

function getActualModPaths(folder, id)
	local path = folder

	local lastchar = string.sub(folder, -1)
	if lastchar ~= "/" then
		path = folder.."/" -- / is missing but I'm nice
	end
	path = path..id

	return {
		txd = path..".txd",
		dff = path..".dff",
		col = path..".col",
	}
end

function isCustomModID(id) -- [Exported]

	local mod, elementType = getModDataFromID(id)
	if not mod then
		return false
	end
	return true, mod, elementType
end

function isRightModType(et, modEt)

	if et == modEt then
		return true
	end

	if (et == "player" or et == "ped") and (modEt == "player" or modEt == "ped") then
		return true
	end
	if (et == "pickup" or et == "object") and (modEt == "pickup" or modEt == "object") then
		return true
	end
	
	return false
end

function isElementTypeSupported(et)
	local found
	for type,_ in pairs(dataNames) do
		if et == type then
			found = true
			break
		end
	end

	if not found then
		return false, "added "..et.." mods are not yet supported"
	end
	return true
end

function verifySetModelArguments(element, elementType, id)
	if not isElement(element) then
		return false, "Invalid element passed"
	end

	local et = getElementType(element)

	local sup,reason = isElementTypeSupported(et)
	if not sup then
		return false, reason
	end

	if not tonumber(id) then
		return false, "Non-number ID passed"
	end
	return true
end

function table.size ( tab )
    local length = 0
    
    for _ in pairs ( tab ) do
        length = length + 1
    end
    
    return length
end

function isCustomVehicle( theVehicle )	
	if not isElement(theVehicle) then return false end
		
	local et = getElementType(theVehicle)
	if et ~= "vehicle" then return false end

	local dataName = dataNames[et]
	local id = tonumber(getElementData(theVehicle, dataName))
	if not id then
		-- not a custom vehicle
		return false
	end

	return true
end

function setElementModelRefreshed(element, currModel, newModel)
	-- element types: player, ped, vehicle, object
	if currModel ~= newModel then
		return setElementModel(element, newModel)
	end
			
	local elementType = getElementType(element)
	local diffModel
	if elementType == "player" or elementType == "ped" then
		diffModel = 0
	elseif elementType == "vehicle" then
		diffModel = 400
	elseif elementType == "object" then
		diffModel = 1337
	end
	if diffModel == currModel then
		diffModel = diffModel + 1
	end

	return setElementModel(element, diffModel) and setElementModel(element, newModel)
end

--[[
	Useful function: checks if any given ID is valid
	by doing the appropriate checks

	Three possible return values:
		- "INVALID_MODEL": invalid model ID
		- "WRONG_MOD": the mod is not for the element type
		- baseModel, isCustom, dataName, baseDataName: model ID ok for element type
]]
-- [Exported]
function checkModelID(id, elementType)
	assert(tonumber(id), "Non-number ID passed")
	assert((elementType == "ped" or elementType == "player" or elementType == "object" or elementType == "vehicle" or elementType == "pickup"),
		"Invalid element type passed: "..tostring(elementType))
	local dataName = dataNames[elementType]
	assert(dataName, "No data name for element type: "..tostring(elementType))

	if elementType == "pickup" then
		elementType = "object"
	end

	local baseModel
	local isCustom, mod, modType = isCustomModID(id)
	if isCustom then
		if not isRightModType(elementType, modType) then
			return "WRONG_MOD"
		end
		baseModel = mod.base_id
	elseif isDefaultID(elementType, id) then
		baseModel = id
	else
		return "INVALID_MODEL"
	end

	return baseModel, isCustom, dataName, baseDataName
end
