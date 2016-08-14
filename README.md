# Tsum Bot

This script aims to give convenience to those who want to send hearts automatically.

## Requirements on mobile device

* iOS device : iPad 2 WiFi, iPad Air 2 WiFi
* install AutoTouch (latest)

## Features of this script

* High scrolling speed
* Handle internet disconnection
* Stop sending hearts when 4 players have zero scores in a row but will send hearts to all players on Monday.
* Track quantity of hearts sent from each player.

<br/>
<img src="http://i1128.photobucket.com/albums/m497/EuclidPro/tsum-bot/sample-tsum-report.jpg" width="300">
<br/>
_Sample Tsum report screenshot_

## Getting Started Guide

For iOS device

* put the Lua script under /var/mobile/Library/AutoTouch/Scripts/
* start TsumTsum game
* run the Lua script

To generate Tsum report

* Navigate to /var/mobile/Library/AutoTouch/Scripts/www using iFile or Filza (Cydia application)
* Run TsumReport.lua which is just an agent to run the init.sh
* Use in-built Web Viewer to view index.html

## Code Flow

preset > settings > classes > objects > actions > tsumBot

## Future Works

* include more iOS devices
* include Android devices
* Switch to Xmodgames because it is free
