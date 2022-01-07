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
 * A race track system for 1/24 to 1/32 scale RC cars.
 *
 * Defines arch related track parts.
 *
 * @author jsconan
 */

/**
 * Gets the length of an arch tower.
 * @param Number length - The length of a track element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number wall - The thickness of the clip outline.
 * @returns Number
 */
function getArchTowerLength(length, base, wall) =
    getBarrierHolderHeight(base, wall + printTolerance) +
    length / 2
;

/**
 * Gets the length of an arch tower with a male connector.
 * @param Number length - The length of a track element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number wall - The thickness of the clip outline.
 * @returns Number
 */
function getArchTowerLengthMale(length, base, wall) =
    getArchTowerLength(
        length = length,
        base = base,
        wall = wall
    ) + getBarrierLinkLength(base)
;

/**
 * Gets the width of an arch tower.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number wall - The thickness of the clip outline.
 * @returns Number
 */
function getArchTowerWidth(base, wall) =
    getBarrierHolderWidth(base, wall + printTolerance)
;

/**
 * Draws the shape of an arch tower that will clamp a barrier border.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number wall - The thickness of the outline.
 */
module archTower(length, thickness, base, wall) {
    thickness = thickness + printTolerance;
    holderHeight = getBarrierHolderHeight(base);
    clipHeight = getBarrierHolderHeight(base, wall + printTolerance);
    indent = getBarrierStripIndent(base) + printResolution;
    length = length / 2;

    translateX(-clipHeight / 2) {
        translateX(length / 2) {
            rotateZ(-90) {
                difference() {
                    clip(
                        wall = wall,
                        height = holderHeight,
                        base = base,
                        thickness = thickness,
                        distance = printTolerance
                    );
                    translate([0, wall / 2, holderHeight - indent]) {
                        box([thickness, wall * 2, indent * 2]);
                    }
                }
            }
        }
        carveBarrierNotch(length=length, thickness=thickness, base=base, notches=1) {
            extrudeStraightProfile(length=length) {
                barrierHolderProfile(
                    base = base,
                    thickness = thickness
                );
            }
        }
    }
}

/**
 * Draws the shape of a male arch tower that will clamp a barrier border.
 * @param Number length - The length of a track element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number wall - The thickness of the outline.
 */
module archTowerMale(length, thickness, base, wall) {
    linkHeight = getBarrierHolderLinkHeight(base);
    archTowerLength = getArchTowerLength(
        length = length,
        base = base,
        wall = wall
    );

    straightLinkMale(length=archTowerLength, linkHeight=linkHeight, base=base) {
        archTower(
            length = length,
            thickness = thickness,
            base = base,
            wall = wall
        );
    }
}

/**
 * Draws the shape of a female arch tower that will clamp a barrier border.
 * @param Number length - The length of a track element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number wall - The thickness of the outline.
 */
module archTowerFemale(length, thickness, base, wall) {
    linkHeight = getBarrierHolderLinkHeight(base);
    archTowerLength = getArchTowerLength(
        length = length,
        base = base,
        wall = wall
    );

    rotateZ(180) {
        straightLinkFemale(length=archTowerLength, linkHeight=linkHeight, base=base) {
            rotateZ(180) {
                archTower(
                    length = length,
                    thickness = thickness,
                    base = base,
                    wall = wall
                );
            }
        }
    }
}
