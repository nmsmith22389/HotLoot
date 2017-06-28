# CHANGELOG
## v3.2.1
### Added
* Added a logo in the options!
* Added `Shift+Right Click` on a loot toast to add it to the exclude list.
* Added an option in the **Item Quality** filters to only consider equipment.
* Added TSM options for the value line in the loot monitor. *(show min buyout etc.)*
* Added a logo in options.
* Added Legion filters.
### Fixed
* Loot toasts should now not show if an item can't be looted. *(still a wip)*
* Changed minimap icon to match new logo.
* Changed the default options window size.
* Fixed some options formatting.
* Fixed an error with money formatting.
* Locale update.

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

## v3.1.1
### Fixed
* Fixed `itemSubType` nil error

## v3.1.0
### Added
* Added `Font Color` option.
* Added RealUI support.
* Added a `+` sign on the include button.
* Added support for *some* proffesion items not in the proffesion type. *(currently only leatherworking but more to come)*

### Fixed
* Tried to fix `Exclude Button` but it's still broken :(
* Locale updated.
* Interface bump.
* **Greatly** improved the `Test Monitor` function. *(now it uses a random item from your backpack)*
* Misc error fixes.

### Removed
* Removed glow and shine animations.


## v3.0.7
### Fixed
Fixed Add to Exclude List

### Removed
Removed Old Changelog


## v3.0.6
### Fixed
* Fixed Skinning Mode
* Fixed Profession Filters


## v3.0.5
### Fixed
* Fixed Item Debug Bug


## v3.0.4
### Fixed
* Interface Bump
* Cleaned Up Skinning Mode Code
* Changed Skinning Mode to Use a Table Instead
* Fixed Threshold Val Getting NIL


## v3.0.3
### New
* Added Settings Transfer Function
* Added Artifact and Heirloom Options
* Added Better Confirm Dialog to Skinning Mode
* Added Caught From Var for Debugging
* Added New Debug Functions
* Added Enable/Disable All Filters Buttons
* Added Testing Section to About

### Fixed
* Localization Update
* Fixed Include/Exclude Button Textures
* Localization Strings Renamed
* Made Anchor Bar Pretty

### Removed
* Removed Timeless Isle from Filter
* Removed Extras Section and MoH Filter
* Removed Extraneous Files
* Removed Left Over Functions
* Removed Right Click Tooltip on Minimap


## v3.0.0
* Updated for v7.0.x
* Removed old Timeless Isle Section
* Fixed some bugs
