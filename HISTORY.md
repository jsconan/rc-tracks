# rc-tracks history

## [Version 1.1.0](https://github.com/jsconan/rc-tracks/releases/tag/1.1.0)

**For the 1/64 scale variant.**

Add a low-level config option to render large-curve tiles full size instead of a split in halves, and add parts for both modes.
Add larger curves with ratios 3 and 4.

Move config options that were low-level to the constants.
Also, refactor the way curves are placed, unify the way sets of elements are built, and improve naming consistency.
Rework a bit the animated pictures.

## [Version 1.0.0](https://github.com/jsconan/rc-tracks/releases/tag/1.0.0)

Add a variant of the race track system for 1/64 to 1/76 scale RC cars.

![scale 64](https://github.com/jsconan/rc-tracks/raw/2635fe50cdf437d53924655f017a9943ff9a0d68/doc/rctrack-64.jpg)

This variant can be fully printed, barriers and ground included. It still comes with a modular approach, each element being able to be printed separately. Full tiles can also be printed all at once (barriers + ground).

Regarding the changes impacting the whole project:

-   The structure and the config have been unified, common config is available at the top level.
-   The script files also got unified, with support added for post-processing scripts.
-   Readme files are provided with details for each variant.

## [Version 0.5.0](https://github.com/jsconan/rc-tracks/releases/tag/0.5.0)

Finalize the extract of the race track system for 1/24 to 1/32 scale RC cars from the repository [jsconan/things](https://github.com/jsconan/things).

-   Fix a typo in some comments.
-   Use the shared internal shape `linkProfile` instead of redefining it in `barrierLinkProfile`.
-   Add a default printer config for the slicer.
-   Add a slicer script.

---

Notes:

-   Import from the repository [jsconan/things](https://github.com/jsconan/things)
-   Extract of the pull request https://github.com/jsconan/things/pull/59

## [Version 0.4.2](https://github.com/jsconan/rc-tracks/releases/tag/0.4.2)

Fixed design of the race track system for 1/24 to 1/32 scale RC cars.

-   Fix the length of the special barrier body related to a U-turn compensation barrier.

---

Notes:

-   Import from the repository [jsconan/things](https://github.com/jsconan/things)
-   Extract of the pull request https://github.com/jsconan/things/pull/49

## [Version 0.4.1](https://github.com/jsconan/rc-tracks/releases/tag/0.4.1)

Fixed design of the race track system for 1/24 to 1/32 scale RC cars.

-   Fix a computation issue on the number of notches for the straight barrier holders (when the length is a multiple of the normal size)
-   Improve the design of the U-turn barrier holders by adding a pocket to prevent round edges on the slot near the tower
-   Dispatch the "special" shapes into more appropriate files (arch and connector)

---

Notes:

-   Import from the repository [jsconan/things](https://github.com/jsconan/things)
-   Extract of the pull request https://github.com/jsconan/things/pull/48

## [Version 0.4.0](https://github.com/jsconan/rc-tracks/releases/tag/0.4.0)

Improved design of the race track system for 1/24 to 1/32 scale RC cars.

-   Encapsulate the shapes into final modules
-   Add sizing functions
-   Add more printer constraints (size of the printer's plate)
-   Add print plates for sets of elements
-   The file structure has been updated.
-   Add a special barrier connector to link barrier holders to unibody barriers (straight version only)
-   The render script has been reworked, adding more options

---

Notes:

-   Import from the repository [jsconan/things](https://github.com/jsconan/things)
-   Extract of the pull request https://github.com/jsconan/things/pull/47

## [Version 0.3.0](https://github.com/jsconan/rc-tracks/releases/tag/0.3.0)

Improved design of the race track system for 1/24 to 1/32 scale RC cars.

-   The file structure has been updated.
-   A new kind of barrier has been added, defining a unibody variant: each track element is built from a single piece instead of 3.
-   The render script has been reworked, adding more options
-   The track can now have curves that are not directly related to the width lanes
-   Add wavy flags in the set of accessories

---

Notes:

-   Import from the repository [jsconan/things](https://github.com/jsconan/things)
-   Extract of the pull request https://github.com/jsconan/things/pull/46

## [Version 0.2.0](https://github.com/jsconan/rc-tracks/releases/tag/0.2.0)

Improved design of the race track system for 1/24 to 1/32 scale RC cars.

-   The file structure has been updated.
-   The link between parts has been reworked for a better track cohesion.
-   The profiles have been redesigned.
-   A distinction is made between the inner and outer curves and the parts can be resized to a multiple of the main length.
-   Added shapes:
    -   Straight track chunks: simple and double length
    -   Curved track chunks: inner, outer, small, short, U-turn
    -   Special track chunks: arch to constraint the track width between two sides, U-turn compensation
    -   Track samples to draw a model of the track (default scaled to 1/10)
    -   Track accessories: led-clip, mast, flag

---

Notes:

-   Import from the repository [jsconan/things](https://github.com/jsconan/things)
-   Extract of the pull request https://github.com/jsconan/things/pull/40

## [Version 0.1.0](https://github.com/jsconan/rc-tracks/releases/tag/0.1.0)

Design a race track system for 1/24 to 1/32 scale RC cars.

---

Notes:

-   Import from the repository [jsconan/things](https://github.com/jsconan/things)
-   Extract of the pull request https://github.com/jsconan/things/pull/37
