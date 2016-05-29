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

local label = {type=CONTROLLER_TYPE.LABEL, text="Choose you settings"}
local claimAll_at_start_switch = {type=CONTROLLER_TYPE.SWITCH, title="Claim all at start:", key="claimAll_at_start", value=0}
local controls = {label, claimAll_at_start_switch}
local enableRemember = true
dialog(controls, enableRemember)

if claimAll_at_start_switch.value == 1 then claimAll() end

while true do
    claimIndividually()
    scrollToTop()
    local START_TIME = os.time()
    if os.date("%a") == "Mon" then sendHearts(false) else sendHearts() end
    local END_TIME = os.time()
    claimIndividually()
    standBy((HEART_LOADING_TIME + OVER_TIME) - (END_TIME - START_TIME))
end