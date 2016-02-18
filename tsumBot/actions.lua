require("tsumBot.classes")

if AUTO_DETECT_DEVICE_MODEL then
    DEVICE_MODEL = io.popen("uname -m"):read()
    objects[DEVICE_MODEL]();
else
    objects["manual"]();
end

function claimAll()
    win_button_mail:
        wait():
        usleep(0.5*s):
        tap(win_button_matome, {win_button_retry2}):
        usleep(0.2*s):
        tap(win_button_ok):
        usleep(0.5*s):
        tap(win_button_close[1], {win_button_retry2}):
        usleep(0.1*s):
        tap(win_button_matome, {win_button_retry2});

    win_button_close[2]:
        wait():
        tap();
        
    usleep(0.1*s);
end

function claimIndividually()

    local _continue = true;
    local _dirty = false;

    while _continue do
        
        _dirty = false;
    
        win_button_mail:
            wait():
            usleep(0.5*s):
            tap(win_button_matome, {win_button_retry2}):
            usleep(0.5*s);
            
        while win_heart2.detected() do
        
            _dirty = true;
        
            win_button_receipt:
                wait():
                tap(win_button_ok):
                usleep(0.3*s):
                tap(win_tsum_logo, {win_button_retry2}):
                usleep(0.1*s):
                tap(win_button_close[2]):
                usleep(0.2*s);
        end
        
        if not _dirty then
            _continue = false;
        end
        
        win_button_close[2]:
            wait():
            tap();
            
        usleep(0.1*s);
    end
end

function scrollToTop()
    while not next(get_win_ranking_icon_line():getTsumObjects()) do
        scroll:toPreviousPage();
    end
    scroll:toPreviousPage();
    usleep(2*s); -- s -> 2*s     1 second not able to capture the hearts sometimes. 
end

function sendHearts()
    while next(get_win_Number_etc30_last_second_digit_line():getTsumObjects()) do
        for index, win_button_heart_on in pairs(get_win_button_hearts_on_line():getTsumObjects()) do
            win_button_heart_on:
                tap(win_button_ok, {win_button_close[1], win_button_heart_on}):
                -- usleep(0.4*s):
                tap(win_tsum_logo, {win_button_retry2, win_button_ok}):
                usleep(0.1*s):
                tap();

            usleep(0.1*s);
        end
        scroll:toNextPage();
        usleep(0.1*s); -- prevent too fast to proceed next loops
    end
end

function standBy(duration)
    duration = duration > 0 and duration or 0;
    for i = 0, duration do usleep(s) end
end
