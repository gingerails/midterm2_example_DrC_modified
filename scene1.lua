

local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")




function scene:create(event)
	local sceneGroup = self.view
	local function onSwitchPress(event)
	end
	local radioGroup = display.newGroup()
	local caseRadio = widget.newSwitch(
		{
			id = "caseRadio",
			x = display.contentCenterX,
			y = display.contentCenterY - 50,
			style = "radio",
			initialSwitchState = true,
			onEvent = onSwitchPress

		}
	)
	radioGroup:insert(caseRadio)

	--text for caseRadio
	local caseRadioText = display.newText(
		{
			text = "Cases",
			x = display.contentCenterX - 100,
			y = display.contentCenterY - 50
		}
	)

	local deathRadio = widget.newSwitch(
		{
			id = "deathRadio",
			x = display.contentCenterX,
			y = display.contentCenterY + 50,
			style = "radio",
			initialSwitchState = false,
			onEvent = onSwitchPress

		}
	)
	radioGroup:insert(deathRadio)

	--text for deathRadio
	local deathRadioText = display.newText(
		{
			text = "Deaths",
			x = display.contentCenterX - 100,
			y = display.contentCenterY + 50
		}
	)
	
	local function scene2ButtonFunction(event)
		composer.setVariable("radioValue", caseRadio.isOn) --true if cases is selected, false if deaths is selected
		print(composer.getVariable("radioValue", caseRadio.isOn))
		
		composer.gotoScene("scene2", {effect = "fade", time = 400, params={radioValue = caseRadio.isOn }})
	end

	local scene2Button = widget.newButton({
		x = display.contentWidth - 200,
		y = 100,
		width = 200,
		height = 100,
		label = "Scene 2",
		onEvent = scene2ButtonFunction,
		fillColor = {default = {1, 0, 0}, over = {1, 0 , 0}}
	})

	sceneGroup:insert(caseRadio)
	sceneGroup:insert(caseRadioText)
	sceneGroup:insert(deathRadio)
	sceneGroup:insert(deathRadioText)
	sceneGroup:insert(scene2Button)
end

function scene:show(event)
end

function scene:hide(event)
end

function scene:destroy(event)
end
	
scene:addEventListener("create",scene)
scene:addEventListener("show",scene)
scene:addEventListener("hide",scene)
scene:addEventListener("destroy",scene)

return scene