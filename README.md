## Note: With the newest v3.2 update many options have changed. Be sure to check that everything is how you want it!

## Description
**HotLoot** is an autoloot filter designed to streamline the looting process. This AddOn will allow you to automatically loot various items related to professions and quests. 

## Issues
[Please post any issues here on GitHub](https://github.com/nmsmith22389/HotLoot/issues)

## Donations
There is now a donations button in the top right corner of the page. I decided to start accepting donations to help further HL and other addons. Thank you and thanks for using HL.

## Localization
I have started to localize HL so anyone who wants to contribute please go to
http://wow.curseforge.com/addons/hotloot/localization/

Credit will be made where due

**Only bother localizing things in the Base Namespace**

## Coming Soon

_If you have ideas for new features you would like to see implemented please open a ticket in [GitHub issues](https://github.com/nmsmith22389/HotLoot/issues) and we will do our best to implement them!_

## Know Issues
* Support for some addons that skin the loot window is yet to be added.
* Still adding more support for some items that **Blizzard** put in the wrong categories.

## Recent Changes
## v3.2.1
### Added
* Added TSM options for the value line in the loot monitor.
* Added a logo in options.
* Added Legion filters.
### Fixed
* Changed to a new logo.
* Changed the default options window size.
* Fixed some options formatting.

## v3.2
#### This is such a HUGE update that I couldn't list every single change but these are some of the big ones.
* ***The options have been changed a lot so they may not all transfer over. Make sure to double check them.***
### Added
* Added slash command to test the loot filter.
* Added a warning on first run to disable other auto looting options.
* Added an option to select which chat frame to output Announce and other info to.
* Added 2 fonts to use.
* Added option to disable auto looting when Master Loot is active. *(still loots gold and currency, this options will change as its use is evaluated and feedback is recieved)*
* Added new Toast options. *(appearance, delay, padding, font)*
### Fixed
* Value Threshold money inputs are pretty and better.
* Loot Monitor Anchor now saves its position.
* Loot Filters are more accurate.
* Switched to new custom Constants system for item typing.
* Loot Filters no longer depend on translations. *(should work in any language!)*
* Switched from themed toasts to completely custom appearance options.
* Loot Toasts now reuse frames instead of creating an infinite amount. *(greatly reduces memory usage)*
* Loot Toast timing, fading, and animations are **way** better.
* Switched to using LibAboutPanel.
* Code size reduced.
### Removed
* Removed Include and Exclude buttons until they can be better implemented. *(the actual lists still work)*
