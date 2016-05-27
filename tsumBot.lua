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

claimAll()

while true do
    claimIndividually()
    scrollToTop()
    local START_TIME = os.time()
    if os.date("%a") == "Mon" then sendHearts(false) else sendHearts() end
    local END_TIME = os.time()
    claimIndividually()
    standBy((HEART_LOADING_TIME + OVER_TIME) - (END_TIME - START_TIME))
end
