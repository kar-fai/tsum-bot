s = 1000000
ms = 100000





settings = {}
objects = {}










settings["iPad2,1"] = function ()
    SCREEN_RESOLUTION = "768x1024"
    T = function (x,y) return 1024-y, x end
    R = function (x,y) return y, 1024-x end
end
objects["iPad2,1"] = function ()
    win_button_close = {
        newTsumObject("win_button_close", 382, 787, 15708680),
        newTsumObject("win_button_close", 383, 945, 16232968)
    }
    win_button_mail = newTsumObject("win_button_mail", 613, 145, 14065209)
    win_button_matome = newTsumObject("win_button_matome", 538, 803, 6502441)
    win_button_ok = newTsumObject("win_button_ok", 527, 591, 16232968)
    win_button_receipt = newTsumObject("win_button_receipt", 594, 281, 10846794)
    win_button_retry2 = newTsumObject("win_button_retry2", 526, 584, 6502441)
    win_heart2 = newTsumObject("win_heart2", 219, 313, 15154308)
    win_tsum_logo = newTsumObject("win_tsum_logo", 389, 559, 16767876)

    scroll = newScrollObject(0, 786/2, 252.4, 765.0)

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
        return newLineObject({617, 765}, {617, 253}, 50, win_button_hearts_on_constraint)
    end

    get_win_plus_on_line = function (self)
        local win_plus_on_constraint = function (red, green, blue)
            return red > 151 and green > 100 and blue < 73
        end
        return newLineObject({180, 765}, {180, 253}, 0, win_plus_on_constraint)
    end
	
    get_win_Number_etc24_last_digit_line = function (self)
        local player_ranking_above_99_constraint = function (red, green, blue)
            return red == 255 and green == 255 and blue == 255
        end
        return newLineObject({166, 765}, {166, 253}, 0, player_ranking_above_99_constraint)
    end

    get_first_message_line = function (self)
        return newLineObject({133, 246}, {399, 246}, nil, nil)
    end

    screenshot_first_message = function (checksum)
        screenshot ("images/"..tostring(checksum)..".bmp", {700,133,86,267})
    end
end










settings["iPad5,3"] = function ()
    SCREEN_RESOLUTION = "1536x2048"
    T = function (x,y) return x, y end
    R = function (x,y) return x, y end
end
objects["iPad5,3"] = function ()
    win_button_close = {
        newTsumObject("win_button_close", 767, 1579, 16231944),
        newTsumObject("win_button_close", 767, 1899, 16230920)
    }
    win_button_mail = newTsumObject("win_button_mail", 1236, 295, 16237369)
    win_button_matome = newTsumObject("win_button_matome", 1047, 1604, 15708688)
    win_button_ok = newTsumObject("win_button_ok", 1055, 1186, 15707664)
     win_button_receipt = newTsumObject("win_button_receipt", 594, 281, 10846794)
    win_button_retry2 = newTsumObject("win_button_retry2", 1047, 1175, 16232968)
     win_heart2 = newTsumObject("win_heart2", 219, 313, 15154308)
    win_tsum_logo = newTsumObject("win_tsum_logo", 778, 1161, 16252804)

    scroll = newScrollObject(0, 1536/2, 504.1, 1530.0)

    get_win_ranking_icon_line = function (self)
        local win_ranking_icon1_constraint = function (red, green, blue)
            return red > 239 and green > 211 and green < 231 and blue > 90 and blue < 123
        end
        return newLineObject({2*131, 2*765}, {2*131, 2*259}, 0, win_ranking_icon1_constraint)
    end

    get_win_Number_etc30_last_second_digit_line = function (self)
        local player_zero_score_constraint = function (red, green, blue)
            return red == 255 and green == 255 and blue == 255
        end
        return newLineObject({2*522, 2*765}, {2*522, 2*253}, 0, player_zero_score_constraint)
    end

    get_win_button_hearts_on_line = function (self)
        local win_button_hearts_on_constraint = function (red, green, blue)
            return red > 200 and green < 100
        end
        return newLineObject({2*617, 2*765}, {2*617, 2*253}, 50, win_button_hearts_on_constraint)
    end
end
