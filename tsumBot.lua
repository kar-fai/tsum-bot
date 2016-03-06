require("tsumBot.actions")

--------------------------
-- List of Functions
--------------------------
-- claimAll()
-- claimIndividually()
-- scrollToTop()
-- scrollToBottom()
-- sendHearts()
-- standBy(duration)

while true do
    claimAll()
    scrollToTop()
    local START_TIME = os.time()
    sendHearts()
    local END_TIME = os.time()
    claimAll()
    standBy((HEART_LOADING_TIME + OVER_TIME) - (END_TIME - START_TIME))
end
