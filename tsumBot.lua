require("tsumBot.actions")

--------------------------
-- List of Functions
--------------------------
-- claimAll()
-- claimIndividually()
-- scrollToTop()
-- scrollToBottom()
-- sendHeartsOnCurrentPage()
-- sendHearts(isStopAtZero)
-- standBy(duration)

while true do
    claimAll()
    scrollToTop()
    local START_TIME = os.time()
    if os.date("%a") == "Mon" then sendHearts(false) else sendHearts() end
    local END_TIME = os.time()
    claimAll()
    standBy((HEART_LOADING_TIME + OVER_TIME) - (END_TIME - START_TIME))
end