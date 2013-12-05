
class Gamepad

    KEYMAP:
        LEFT: 37
        UP: 38
        RIGHT: 39
        DOWN: 40
        BUTTON_A: 88
        BUTTON_B: 90
        SELECT: 32
        START: 13

    BUTTONS:
        BUTTON_A: 0                   #Face (main) buttons
        BUTTON_B: 1                   
        SELECT: 2
        START: 3
    ###
        LEFT_SHOULDER: 4            #Top shoulder buttons
        RIGHT_SHOULDER: 5
        LEFT_SHOULDER_BOTTOM: 6     #Bottom shoulder buttons
        RIGHT_SHOULDER_BOTTOM: 7
        SELECT: 8
        START: 9
        LEFT_ANALOGUE_STICK: 10     #Analogue sticks (if depressible)
        RIGHT_ANALOGUE_STICK: 11
        PAD_TOP: 12                 #Directional (discrete) pad
        PAD_BOTTOM: 13
        PAD_LEFT: 14
        PAD_RIGHT: 15
    ###

    AXES:
        LEFT_ANALOGUE_HOR: 0
        LEFT_ANALOGUE_VERT: 1
    ###
        RIGHT_ANALOGUE_HOR: 2
        RIGHT_ANALOGUE_VERT: 3
    ###

    ANALOGUE_BUTTON_THRESHOLD: 0.5
    AXIS_THRESHOLD: 0.75
    prevTimestamp: 0

    isSupported: () ->
        gamepadSupportAvailable = (navigator.webkitGetGamepads or navigator.webkitGamepads)

    start: () ->
        @place = document.getElementById('output')
        if @isSupported() 
            @place.innerHTML = @place.innerHTML + '<br>SUPP!'
            @startPolling()
        else
            @place.innerHTML = 'GAMEPAD NOT SUPPORTED'

    startPolling: () ->
        if not @ticking
            @ticking = true
            @tick()

    stopPolling: () ->
        @ticking = false

    scheduleNextTick: () ->
        if @ticking
            if window.requestAnimationFrame then window.requestAnimationFrame(@tick)
            else if window.mozRequestAnimationFrame then window.mozRequestAnimationFrame(@tick)
            else if window.webkitRequestAnimationFrame then window.webkitRequestAnimationFrame(@tick)

    pollStatus: () ->

        @place.innerHTML = 'CHECKING FOR GAMEPAD'
        if navigator.webkitGetGamepads()
            gamepad = navigator.webkitGetGamepads()[0]
            if gamepad
                @place.innerHTML = 'GAMEPAD CONNECTED'
                if gamepad.timestamp != @prevTimestamp
                    @prevTimestamps = gamepad.timestamp
                    @detectDeviceEvent(gamepad)
        return true

    tick: () =>
        @pollStatus()
        @scheduleNextTick()

    isButtonPressed: (pad, buttonId) ->
        return (pad.buttons[buttonId] and (pad.buttons[buttonId] > @ANALOGUE_BUTTON_THRESHOLD))
    
    isStickMoved: (pad, axisId, negativeDirection) ->
        if (typeof pad.axes[axisId] == 'undefined')
            return false
        if negativeDirection
            return (pad.axes[axisId] < -@AXIS_THRESHOLD)
        return (pad.axes[axisId] > @AXIS_THRESHOLD)

    detectDeviceEvent: (pad) ->
        for buttonName, buttonId of @BUTTONS
            if @isButtonPressed(pad, buttonId) then @fireEvent buttonName
        for axisName, axisId of @AXES
            if @isStickMoved(pad, axisId)
                if axisId == 0 then @fireEvent 'RIGHT'
                else @fireEvent 'DOWN'

            else if @isStickMoved(pad, axisId, true)
                if axisId == 0 then @fireEvent 'LEFT'
                else @fireEvent 'UP'

    fireEvent: (eventName) ->

        console.log eventName

        if eventName of @KEYMAP
            evt = $.Event 'keydown',
                keyCode: @KEYMAP[eventName]
            console.log evt
            $("#testarea").trigger(evt)



gp = new Gamepad

gp.start()

window.addEventListener('keydown', (e) ->
    console.log e
)
