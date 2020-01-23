
/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/things.
 *
 * jsconan/things is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/things is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/things. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A 1/24 RC track system.
 *
 * Work in progress.
 *
 * @author jsconan
 * @version 0.1.0
 */

// Import the project's setup.
include <../util/setup.scad>

// Sets the minimum facet angle and size using the defined render mode.
applyMode(mode=renderMode) {
    // test the bottom border profile
    *borderBottomProfile(
        slotWidth = getSlotWidth(),
        slotDepth = borderSlotDepth,
        edge = borderBottomEdge
    );
    // test the top border profile
    *borderTopProfile(
        slotWidth = getSlotWidth(),
        slotDepth = borderSlotDepth,
        edge = borderTopEdge
    );
    // test the border tooth profile
    borderToothProfile(
        slotDepth = borderSlotDepth,
        edge = borderBottomEdge,
        direction = -1,
        negative = true
    );
    borderToothProfile(
        slotDepth = borderSlotDepth,
        edge = borderBottomEdge,
        direction = 1,
        negative = true
    );
}
