require("tsumBot.preset")

AUTO_DETECT_DEVICE_MODEL = true

HEART_LOADING_TIME = 60*60
OVER_TIME = 3*60

settings["manual"] = function ()
    SCREEN_RESOLUTION="768x1024";
    T = function (x,y) return 1024-y, x end;
    R = function (x,y) return y, 1024-x end;
end
objects["manual"] = function ()
    win_button_close = {
        newTsumObject("win_button_close", 382, 787, 15708680), -- higher
        newTsumObject("win_button_close", 383, 945, 16232968)  -- lower
    };
    win_button_mail = newTsumObject("win_button_mail", 613, 145, 14065209);
    win_button_matome = newTsumObject("win_button_matome", 538, 803, 6502441);
    win_button_ok = newTsumObject("win_button_ok", 527, 591, 16232968); -- combine 5 cases
    win_button_receipt = newTsumObject("win_button_receipt", 594, 281, 10846794);
    win_button_retry2 = newTsumObject("win_button_retry2", 526, 584, 6502441);
    win_heart2 = newTsumObject("win_heart2", 219, 313, 15154308);
    win_tsum_logo = newTsumObject("win_tsum_logo", 389, 559, 16767876);

    scroll = newScrollObject(0, 786/2, 252.4, 765.0);

    get_win_ranking_icon_line = function (self)
        local win_ranking_icon1_constraint = function (red, green, blue)
            return red > 239 and green > 211 and green < 231 and blue > 90 and blue < 123
        end
        return newLineObject({131, 765}, {131, 259}, 0, win_ranking_icon1_constraint)
    end

    get_win_Number_etc30_last_second_digit_line = function (self)
        local player_zero_score_constraint = function (red, green, blue)
            return red == 255 and green == 255 and blue == 255
        end
        return newLineObject({522, 765}, {522, 253}, 0, player_zero_score_constraint)
    end

    get_win_button_hearts_on_line = function (self)
        local win_button_hearts_on_constraint = function (red, green, blue)
            return red > 200 and green < 100
        end
        return newLineObject({617, 765}, {617, 253}, 50, win_button_hearts_on_constraint);
    end
end
