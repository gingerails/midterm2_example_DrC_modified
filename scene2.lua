

local composer = require("composer")
local scene = composer.newScene()
local csv = require("csv")
local mapper = require("map")
local widget = require("widget")
local filePath = system.pathForFile("new_covid_al.csv")
local ballGroup = display.newGroup()
local _caseBallGroup = display.newGroup()
local _deathBallGroup = display.newGroup()
local dataFile = csv.open(filePath, {separator = ',', header = true })
local zipTable = {}
local zipSliderText
local zipSlider
composer.setVariable("zipValue", 100)

function scene:create(event)
	local sceneGroup = self.view
	
	sceneGroup:insert(ballGroup)
	
	local bg = display.newImage("al_map.png", display.contentCenterX, display.contentCenterY)
	bg.xScale = display.contentWidth / bg.width
	bg.yScale = display.contentHeight / bg.height
	sceneGroup:insert(bg)
	
		for record in dataFile:lines() do
			local ball = display.newCircle(record.x, record.y, map(record.case, 882, 114709, 5, 20))
			ball:setFillColor(1, 1, 0, 0.6)
			ball.isVisible = false
			table.insert(_caseBallGroup, ball)
			table.insert(zipTable, record.zip)
			sceneGroup:insert(ball)
		end
	
	
		for record in dataFile:lines() do
			local ball = display.newCircle(record.x, record.y, map(record.death, 27, 1924, 5, 20))
			ball:setFillColor(1, 0, 0, 0.6)
			ball.isVisible = false
			table.insert(_deathBallGroup, ball)
			table.insert(zipTable, record.zip)
			sceneGroup:insert(ball)
		end

		sceneGroup:insert(_caseBallGroup)
		sceneGroup:insert(_deathBallGroup)



	zipSliderText = display.newText({
		x = 100,
		y = display.contentHeight - 150,
		text = map(composer.getVariable("zipValue"), 0, 100, 35004, 36925)
	})
	local function zipListener(event)
		composer.setVariable("zipValue", event.value)
	end

	zipSlider = widget.newSlider({
		x = display.contentCenterX,
		y = display.contentHeight - 150,
		width = 500,
		height = 200,
		value = composer.getVariable("zipValue"),
		listener = zipListener
	})

	sceneGroup:insert(zipSlider)
	sceneGroup:insert(zipSliderText)

	local function doubleTapFunction(event)
		if (event.numTaps >= 2) then
			composer.gotoScene("scene1", {effect = "fade", time = 400})
		end
	end


	Runtime:addEventListener("tap", doubleTapFunction)


end

function scene:show(event)

	local sceneGroup = self.view
   local phase = event.phase
   local params = event.params


	if ( phase == "will" ) then

		if(params.radioValue) then
			ballGroup = _caseBallGroup;
			for index, ball in ipairs(ballGroup) do
					ball.isVisible = true;
			end
			for index, ball in ipairs(_deathBallGroup) do
					ball.isVisible = false;
			end
		else 
			ballGroup = _deathBallGroup;
			for index, ball in ipairs(ballGroup) do
					ball.isVisible = true;
			end
			for index, ball in ipairs(_caseBallGroup) do
					ball.isVisible = false;	
			end
		end

	
   elseif ( phase == "did" ) then
   
      	local function update()
				for index, ball in ipairs(ballGroup) do
					if (tonumber(zipTable[index]) > (map(composer.getVariable("zipValue"), 0, 100, 35004, 36925))) then
						ball.isVisible = false
					else
						ball.isVisible = true
					end
				end
				zipSliderText.text = map(composer.getVariable("zipValue"), 0, 100, 35004, 36925)
			end
			timer.performWithDelay(16.777, update, 0)


   end
end

function scene:hide(event)


	local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then

  	elseif ( phase == "did" ) then


   end


end

function scene:destroy(event)
	--check this
	display.remove(ballGroup)
	ballGroup = nil
end


scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)
return scene


