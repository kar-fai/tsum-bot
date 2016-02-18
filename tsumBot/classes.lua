require("tsumBot.settings")

if AUTO_DETECT_DEVICE_MODEL then
    DEVICE_MODEL = io.popen("uname -m"):read()
    settings[DEVICE_MODEL]()
else
    settings["manual"]()
end

function newTsumObject(name, x, y, color)
    
    local instanceVariables = {
        name = name,
        x = x,
        y = y,
        color = color
    }

    local _getName = function (self) return instanceVariables.name end

    local _getCoordinate = function (self) return instanceVariables.x, instanceVariables.y end
    
    local _getColor = function (self) return instanceVariables.color end

    local _detected = function (self) return getColor(T(instanceVariables.x, instanceVariables.y))==instanceVariables.color end

    local _wait = function (self, blockingObjects)
        while getColor(T(instanceVariables.x, instanceVariables.y))~=instanceVariables.color do
            for index, blockingObject in pairs(blockingObjects or {}) do
                if blockingObject.detected() then
                    blockingObject.tap()
                end
            end
            usleep(0.1*s)
        end
        if not blockingObjects then return self end
    end
    
    local _usleep = function (self, time)
        usleep(time)
        return self
    end
    
    local _tap = function (self, expectedObjectAfterTap, blockingObjects)
        tap(instanceVariables.x, instanceVariables.y)
        if expectedObjectAfterTap then
            expectedObjectAfterTap:wait(blockingObjects)
            return expectedObjectAfterTap
        end
    end

    return {
        getName = _getName,
        getCoordinate = _getCoordinate,
        getColor = _getColor,
        detected = _detected,
        wait = _wait,
        usleep = _usleep,
        tap = _tap
    }
end

function newLineObject(A, B, gap, constraint)

    local function lineType (A, B)
        if     A[1]==B[1] and A[2]==B[2] then return 'undefined'
        elseif A[1]==B[1] and A[2]~=B[2] then return 'vertical'
        elseif A[1]~=B[1] and A[2]==B[2] then return 'horizontal'
        elseif A[1]~=B[1] and A[2]~=B[2] then return 'oblique'
        end
    end

    local function validateCoordinate(A, B)
        if A and B and type(A[1])=='number' and type(A[2])=='number' and type(B[1])=='number' and type(B[2])=='number' then
            return lineType(A, B)=='vertical' or lineType(A, B)=='horizontal'
        else
            return false
        end
    end
    
    local function pointSort(A, B)
        local cases = {
            vertical   = function () if A[2] > B[2] then A, B = B, A end end,
            horizontal = function () if A[1] > B[1] then A, B = B, A end end
        }
        cases[lineType(A, B)]()
        return A, B
    end

    local function createLine(A, B)
        local lineOfPixels = {}
        local cases = {
            vertical   = function () for y = A[2], B[2] do table.insert(lineOfPixels, {A[1], y}) end end,
            horizontal = function () for x = A[1], B[1] do table.insert(lineOfPixels, {x, A[2]}) end end
        }
        cases[lineType(A, B)]()
        return lineOfPixels
    end

    local function getInterval(A, B, lineOfColors)
        local cases = {
            vertical   = function () return A[1], A[2], B[2] end,
            horizontal = function () return A[2], A[1], B[1] end
        }

        local constant, globalMin, globalMax = cases[lineType(A, B)]()
        
        local intervals = {}
        local lowerBound = -1
        local upperBound = -1

        for index, color in pairs(lineOfColors) do
            local red, green, blue = intToRgb(color)
            if constraint(red, green, blue) then
                if lowerBound < 0 then
                    lowerBound = globalMin + index - 1
                    upperBound = globalMin + index - 1
                else
                    upperBound = globalMin + index - 1
                end
            else
                if not (lowerBound < 0) then 
                    table.insert(intervals, {lowerBound, upperBound})
                    lowerBound = -1
                    upperBound = -1
                end
            end
        end
        return intervals
    end

    local function getMergeIntervals(intervals, gap)
        local mergedIntervals = {}
        for index, interval in pairs(intervals) do
            local nextIndex = next(intervals, index)
            if nextIndex then
                if intervals[nextIndex][1] - interval[2] < gap then
                    intervals[nextIndex][1] = interval[1]
                else
                    table.insert(mergedIntervals, {interval[1], interval[2]})
                end
            else
                table.insert(mergedIntervals, {interval[1], interval[2]})
            end
        end
        return mergedIntervals
    end

    local function getCoordinates(mergedIntervals, A, B)

        local means = {}
        for index, interval in pairs(mergedIntervals) do
            local mean = math.floor( (interval[1] + interval[2]) / 2 )
            table.insert(means, mean)
        end

        local coordinates = {}
        local insert = {
            vertical   = function () for index, mean in pairs(means) do table.insert(coordinates, {R(A[1], mean)}) end end,
            horizontal = function () for index, mean in pairs(means) do table.insert(coordinates, {R(mean, A[2])}) end end
        }
        local sort = {
            vertical   = function () table.sort(coordinates, function(coordinateA, coordinateB) return coordinateA[2] < coordinateB[2] end) end,
            horizontal = function () table.sort(coordinates, function(coordinateA, coordinateB) return coordinateA[1] < coordinateB[1] end) end
        }
        insert[lineType(A, B)]()
        sort[lineType({R(A[1], A[2])}, {R(B[1], B[2])})]()
        return coordinates
    end

    if not validateCoordinate(A, B) then return end
    
    local instanceVariables = {
        A = {T(A[1], A[2])},
        B = {T(B[1], B[2])},
        gap = gap,
        constraint = constraint
    }

    instanceVariables.A, instanceVariables.B = pointSort(instanceVariables.A, instanceVariables.B)
    local lineOfPixels = createLine(instanceVariables.A, instanceVariables.B)
    local lineOfColors = getColors(lineOfPixels)
    local intervals = getInterval(instanceVariables.A, instanceVariables.B, lineOfColors)
    local mergedIntervals = getMergeIntervals(intervals, instanceVariables.gap)
    local coordinates = getCoordinates(mergedIntervals, instanceVariables.A, instanceVariables.B)
    
    local _getTsumObjects = function (self) 
        local tsumObjects = {}
        for index, coordinate in pairs(coordinates) do
            table.insert(tsumObjects, newTsumObject("", coordinate[1], coordinate[2], getColor(T(coordinate[1], coordinate[2]))))
        end
        return tsumObjects
    end
    
    return {
        getTsumObjects = _getTsumObjects 
    }
end


function newScrollObject(id, x_mid, y_top, y_bottom)
    
    local instanceVariables = {
        id = id,
        x_mid = x_mid,
        y_top = y_top,
        y_bottom = y_bottom
    }
    
    local _scroll = function (self, speed, y_start, y_end)
        -- Legacy scroll function
        --[[
        touchDown(instanceVariables.id, instanceVariables.x_mid, y_start)
        usleep(speed*ms)
        touchMove(instanceVariables.id, instanceVariables.x_mid, y_end)
        usleep(speed*ms)
        touchMove(instanceVariables.id, instanceVariables.x_mid-1, y_end)
        usleep(speed*ms)
        touchUp(instanceVariables.id, instanceVariables.x_mid, y_end)
        usleep(speed*ms)
        ]]--
        touchDown(instanceVariables.id, instanceVariables.x_mid, y_start)
        usleep(speed*ms)
        touchMove(instanceVariables.id, instanceVariables.x_mid, y_end)
        usleep(speed*ms)
        touchMove(instanceVariables.id, instanceVariables.x_mid-1, y_end)
        usleep(speed*ms)

        touchDown(instanceVariables.id, instanceVariables.x_mid-1, y_end)
        usleep(speed*ms)
        touchMove(instanceVariables.id, instanceVariables.x_mid-2, y_end)
        usleep(speed*ms)

        touchUp(instanceVariables.id, instanceVariables.x_mid-2, y_end)
        usleep(speed*ms)
    end
    
    local _toNextPage = function (self, speed)
        local speed = speed or 0.1 -- [Warning] speed == 0.01 will cause reboot
        _scroll(self, speed, instanceVariables.y_bottom, instanceVariables.y_top)
    end

    local _toPreviousPage = function (self, speed)
        local speed = speed or 0.05 -- [Warning] speed == 0.01 will cause reboot
        _scroll(self, speed, instanceVariables.y_top + 1, instanceVariables.y_bottom)
    end
    
    return {
        toNextPage = _toNextPage,
        toPreviousPage = _toPreviousPage
    }
end
