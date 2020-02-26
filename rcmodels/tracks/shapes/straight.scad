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
 * Defines the straight track parts.
 *
 * @author jsconan
 */

/**
 * Draws the shape of a barrier body.
 * @param Number length - The length of the track element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number [notches] - The number of notches.
 */
module barrierBody(length, height, thickness, base, notches = 1) {
    count = notches + 1;
    interval = length / notches;

    difference() {
        box(
            size = [length, height, thickness],
            center = true
        );
        repeatMirror(interval=[0, height, 0], axis=[0, 1, 0], center=true) {
            barrierNotch(
                thickness = thickness * 2,
                base = base,
                distance = printTolerance,
                interval = interval,
                count = count,
                center = true
            );
        }
    }
}

/**
 * Adds the male link to a straight element.
 * @param Number length - The length of the element.
 * @param Number linkHeight - The height of the link.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module straightLinkMale(length, linkHeight, base) {
    translateX(-length / 2) {
        barrierLink(
            height = linkHeight - printResolution,
            base = base
        );
    }
    children();
}

/**
 * Adds the female link to a straight element.
 * @param Number length - The length of the element.
 * @param Number linkHeight - The height of the link.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module straightLinkFemale(length, linkHeight, base) {
    difference() {
        children();
        translate([length / 2, 0, -1]) {
            barrierLink(
                height = linkHeight + printResolution + 1,
                base = base,
                distance = printTolerance
            );
        }
    }
}

/**
 * Adds the links to a straight element.
 * @param Number length - The length of the element.
 * @param Number linkHeight - The height of the link.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module straightLinks(length, linkHeight, base) {
    straightLinkMale(length=length, linkHeight=linkHeight, base=base) {
        straightLinkFemale(length=length, linkHeight=linkHeight, base=base) {
            children();
        }
    }
}

/**
 * Extrudes the profile on the expected linear length.
 * @param Number length - The length of the element.
 * @param Number|Vector [scale] - Scales the 2D shape by this value over the height of the extrusion.
 */
module extrudeStraightProfile(length, scale=1) {
    rotate([90, 0, 90]) {
        negativeExtrude(height=length, center=true, scale=scale) {
            children();
        }
    }
}

/**
 * Draws the main shape of a straight barrier holder.
 * @param Number length - The length of the element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module straightBarrierMain(length, thickness, base) {
    linkHeight = getBarrierHolderLinkHeight(base);

    straightLinks(length=length, linkHeight=linkHeight, base=base) {
        extrudeStraightProfile(length=length) {
            barrierHolderProfile(
                base = base,
                thickness = thickness
            );
        }
    }
}

/**
 * Draws the shape of a straight unibody barrier.
 * @param Number length - The length of the element.
 * @param Number height - The height of the barrier.
 * @param Number thickness - The thickness of the barrier body for a barrier holder.
 * @param Number base - The base unit value used to design the barrier holder.
 */
module straightBarrierUnibody(length, height, thickness, base) {
    linkHeight = getBarrierUnibodyLinkHeight(height, base);

    straightLinks(length=length, linkHeight=linkHeight, base=base) {
        extrudeStraightProfile(length=length) {
            barrierUnibodyProfile(
                height = height,
                base = base,
                thickness = thickness + printTolerance
            );
        }
    }
}

/**
 * Draws the barrier holder for a straight track element.
 * @param Number length - The length of the element.
 * @param Number thickness - The thickness of the barrier body.
 * @param Number base - The base unit value used to design the barrier holder.
 * @param Number ratio - The ratio to apply on the length
 */
module straightBarrierHolder(length, thickness, base, ratio = 1) {
    thickness = thickness + printTolerance;
    length = length * ratio;
    notches = ratio * 2;

    carveBarrierNotch(length=length, thickness=thickness, base=base, notches=notches) {
        straightBarrierMain(
            length = length,
            thickness = thickness,
            base = base
        );
    }
}
