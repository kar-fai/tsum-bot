require("tsumBot.classes")

if AUTO_DETECT_DEVICE_MODEL then
    DEVICE_MODEL = io.popen("uname -m"):read()
    objects[DEVICE_MODEL]()
else
    objects["manual"]()
end

function claimAll()
    win_button_mail:
        wait():
        usleep(0.5*s):
        tap(win_button_matome, {win_button_retry2, win_button_mail}):
        usleep(0.2*s):
        tap(win_button_ok, {win_button_matome}):
        usleep(0.5*s):
        tap(win_button_close[1], {win_button_retry2, win_button_ok}):
        usleep(0.1*s):
        tap(win_button_matome, {win_button_retry2, win_button_close[1]})

    win_button_close[2]:
        wait():
        tap()

    usleep(0.1*s)
end

function claimIndividually()

    local _continue = true
    local _dirty = false

    local file = io.open(rootDir().."www/data.csv", "a")

    while _continue do

        _dirty = false

        win_button_mail:
            wait():
            tap(win_button_matome, {win_button_retry2, win_button_mail}):
            usleep(0.5*s)

        while win_heart2.detected() do

            _dirty = true

            ---------------------------------------------------------------------
            lineOfPixels = {}
            for y = 133, 399 do table.insert(lineOfPixels, {778, y}) end
            lineOfColors = getColors(lineOfPixels)
            checksum = 0
            for i, v in pairs(lineOfColors) do checksum = checksum + v end
            screenshot ("images/"..tostring(checksum)..".bmp", {700,133,86,267});
            file:write(tostring(checksum)..",")
            ---------------------------------------------------------------------

            win_button_receipt:
                wait():
                tap(win_button_ok, {win_button_receipt}):
                tap(win_tsum_logo, {win_button_retry2, win_button_ok}):
                usleep(0.1*s):
                tap()

            usleep(0.1*s)
        end

        if not _dirty then _continue = false end

        win_button_close[2]:
            wait():
            tap()

        usleep(0.1*s)
    end

    file:close()

end

function isTop() return next(get_win_ranking_icon_line():getTsumObjects()) end
function isBottom() return next(get_win_plus_on_line():getTsumObjects()) end
function isZeroScore() return not next(get_win_Number_etc30_last_second_digit_line():getTsumObjects()) end
function isAbove100() return next(get_win_Number_etc24_last_digit_line():getTsumObjects()) end
function getHeartsArray() return pairs(get_win_button_hearts_on_line():getTsumObjects()) end

function scrollToTop()
    while not isTop() do
        if isAbove100() then
            scroll:toPreviousPage()
        else
            scroll:toPreviousPage(0.5)
        end
    end
    scroll:toPreviousPage()
    usleep(3*s) -- minumum 3 seconds to capture the hearts
end

function scrollToBottom()
    while not isBottom() do
        scroll:toNextPage()
    end
    scroll:toNextPage()
end

function sendHeartsOnCurrentPage()
    for index, win_button_heart_on in getHeartsArray() do
        win_button_heart_on:
            tap(win_button_ok, {win_button_close[1], win_button_heart_on}):
            tap(win_tsum_logo, {win_button_retry2, win_button_ok}):
            usleep(0.1*s):
            tap()

        usleep(0.1*s)
    end
end

function sendHearts(isStopAtZero)
    if isStopAtZero == nil then isStopAtZero = true end
    local START_TIME, END_TIME = os.time(), os.time()
    while not isBottom() do
        if isStopAtZero then
            if isZeroScore() then break end
        end
        sendHeartsOnCurrentPage()
        scroll:toNextPage()
        usleep(0.1*s) -- some delay to ensure function capture the hearts correctly
        END_TIME = os.time()
        if (END_TIME - START_TIME) > CLAIM_TIME then
            claimIndividually()
            START_TIME = os.time()
            usleep(s)
        end
    end
    if isBottom() then sendHeartsOnCurrentPage() end
end

function standBy(duration)
    duration = duration > 0 and duration or 0
    local START_TIME, END_TIME = os.time(), os.time()
    for i = 0, duration do
        END_TIME = os.time()
        if (END_TIME - START_TIME) > CLAIM_TIME then
            claimIndividually()
            START_TIME = os.time()
        end
        usleep(s)
    end
end