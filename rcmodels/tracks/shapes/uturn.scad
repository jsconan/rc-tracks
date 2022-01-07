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
 * Defines the U-turn track parts.
 *
 * @author jsconan
 */

/**
 * Gets the length of the final shape for a U-turn curve.
 * @param Number length - The length of a track element.
 * @param Number width - The width of a track element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the U-turn.
 * @returns Number
 */
function getUTurnBarrierLength(length, width, base, gap) =
    getStraightBarrierLength(length, base, .5) + width + gap / 2
;

/**
 * Gets the width of the final shape for a U-turn curve.
 * @param Number width - The width of a track element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the U-turn.
 * @returns Number
 */
function getUTurnBarrierWidth(width, base, gap) = gap + width * 2;

/**
 * Gets the length of a U-turn compensation barrier.
 * @param Number width - The width of a track element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the U-turn.
 * @returns Number
 */
function getUTurnCompensationBarrierLength(width, base, gap) =
    width + gap + getBarrierLinkLength(base)
;

/**
 * Gets the length of a U-turn compensation barrier body.
 * @param Number length - The length of a track element.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the U-turn.
 * @returns Number
 */
function getUTurnCompensationBarrierBodyLength(length, base, gap) =
    length + getBarrierHolderWidth(base) + gap
;

/**
 * Draws the shape of a barrier border for a U-Turn.
 * @param Number length - The length of a track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the U-turn.
 * @param Number right - Is it the right or the left part of the track element that is added first?
 */
module uTurnBarrierHolder(length, height, thickness, base, gap, right = false) {
    thickness = thickness + printTolerance;
    holderHeight = getBarrierHolderHeight(base);
    linkHeight = getBarrierHolderLinkHeight(base);
    towerWidth = nozzleAligned(thickness + minWidth);
    towerHeight = getBarrierBodyInnerHeight(height, base) / 2;
    interval = (getBarrierHolderWidth(base) + gap) / 2;
    indent = getBarrierStripIndent(base) + printResolution;
    dir = right ? -1 : 1;
    length = length / 2;

    translate([-interval, interval * dir, 0]) {
        carveBarrierNotch(length=length, thickness=thickness, base=base, notches=1) {
            straightLinkMale(length=length, linkHeight=linkHeight, base=base) {
                extrudeStraightProfile(length=length) {
                    barrierHolderProfile(
                        base = base,
                        thickness = thickness
                    );
                }
            }
        }
    }
    translate([-interval, -interval * dir, 0]) {
        rotateZ(180) {
            carveBarrierNotch(length=length, thickness=thickness, base=base, notches=1) {
                straightLinkFemale(length=length, linkHeight=linkHeight, base=base) {
                    extrudeStraightProfile(length=length) {
                        barrierHolderProfile(
                            base = base,
                            thickness = thickness
                        );
                    }
                }
            }
        }
    }
    translateX(length / 2 - interval) {
        rotateZ(270) {
            difference() {
                extrudeCurvedProfile(radius=interval, angle=180) {
                    barrierHolderProfile(
                        base = base,
                        thickness = thickness
                    );
                    translate([-thickness / 2, holderHeight + towerHeight / 2]) {
                        rectangle([towerWidth, towerHeight]);
                    }
                }
                repeat(count=2, intervalX=interval * 2, center=true) {
                    translateZ(holderHeight - indent) {
                        box([thickness, thickness, indent]);
                    }
                }
            }
        }
    }
}

/**
 * Draws the shape of a unibody barrier for a U-Turn.
 * @param Number length - The length of a track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body for a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the U-turn.
 * @param Number right - Is it the right or the left part of the track element that is added first?
 */
module uTurnBarrierUnibody(length, height, thickness, base, gap, right = false) {
    thickness = thickness + printTolerance;
    linkHeight = getBarrierUnibodyLinkHeight(height, base);
    interval = (getBarrierUnibodyWidth(base) + gap) / 2;
    dir = right ? -1 : 1;
    length = length / 2;

    translate([-interval, interval * dir, 0]) {
        straightLinkMale(length=length, linkHeight=linkHeight, base=base) {
            extrudeStraightProfile(length=length) {
                barrierUnibodyProfile(
                    height = height,
                    base = base,
                    thickness = thickness
                );
            }
        }
    }
    translate([-interval, -interval * dir, 0]) {
        rotateZ(180) {
            straightLinkFemale(length=length, linkHeight=linkHeight, base=base) {
                extrudeStraightProfile(length=length) {
                    barrierUnibodyProfile(
                        height = height,
                        base = base,
                        thickness = thickness
                    );
                }
            }
        }
    }
    translateX(length / 2 - interval) {
        rotateZ(270) {
            extrudeCurvedProfile(radius=interval, angle=180) {
                barrierUnibodyProfile(
                    height = height,
                    base = base,
                    thickness = thickness
                );
            }
        }
    }
}

/**
 * Draws the shape of a barrier border for a U-Turn.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the U-turn.
 */
module uTurnCompensationBarrierHolder(thickness, base, gap) {
    length = getBarrierHolderWidth(base) + gap;
    indent = getBarrierStripIndent(base);
    height = getBarrierHolderHeight(base) - indent;
    thickness = thickness + printTolerance;

    difference() {
        straightBarrierMain(
            length = length,
            thickness = thickness,
            base = base
        );
        translateZ(height) {
            box([length + 2, thickness, indent * 2]);
        }
    }
}

/**
 * Draws the shape of a barrier border for a U-Turn.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the U-turn.
 */
module uTurnCompensationBarrierUnibody(height, thickness, base, gap) {
    length = getBarrierUnibodyWidth(base) + gap;

    straightBarrierUnibody(
        length = length,
        height = height,
        thickness = thickness,
        base = base
    );
}

/**
 * Draws the shape of a body for a U-turn compensation barrier.
 * @param Number length - The length of the track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number gap - The distance between the two side of the U-turn.
 */
module uTurnCompensationBarrierBody(length, height, thickness, base, gap) {
    stripHeight = getBarrierStripHeight(base) - getBarrierStripIndent(base);
    compensation = getBarrierHolderWidth(base) + gap;
    compensedLength = length + compensation;
    interval = length / 2;

    difference() {
        box(
            size = [compensedLength, height, thickness],
            center = true
        );
        repeatMirror(interval=[0, height, 0], axis=[0, 1, 0], center=true) {
            repeatMirror() {
                translateX((compensedLength - interval) / 2) {
                    barrierNotch(
                        thickness = thickness * 2,
                        base = base,
                        distance = printTolerance,
                        interval = interval,
                        count = 2,
                        center = true
                    );
                }
            }
            box(
                size = [compensation, stripHeight * 2, thickness + 1],
                center = true
            );
        }
    }
}
