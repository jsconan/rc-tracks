/**
 * @license
 * GPLv3 License
 *
 * Copyright (c) 2020-2022 Jean-Sebastien CONAN
 *
 * This file is part of jsconan/rc-tracks.
 *
 * jsconan/rc-tracks is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * jsconan/rc-tracks is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with jsconan/rc-tracks. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * A race track system for RC cars of various scales.
 *
 * Defines shared operators.
 *
 * @author jsconan
 */

/**
 * Extrudes the profile on the expected linear length.
 * @param Number length - The length of the element.
 */
module extrudeStraightProfile(length) {
    rotate([RIGHT, 0, RIGHT]) {
        linear_extrude(height=length, center=true, convexity=10) {
            children();
        }
    }
}

/**
 * Extrudes the profile on the expected circle path.
 * @param Number radius - The radius of the curve.
 * @param Number angle - The extrusion angle.
 */
module extrudeCurvedProfile(radius, angle) {
    rotate_extrude(angle=angle, convexity=10) {
        translateX(radius) {
            children();
        }
    }
}

/**
 * Adjusts the position on the print plat to either print as it or to flip upside down the model.
 * @param Boolean flip - Flip upside down the element.
 */
module flipElement(flip=false) {
    rotate(flip ? [180, 0, 180] : [0, 0, 0]) {
        children();
    }
}

/**
 * Repeats and place a shape on a grid with respect to the expected quantity.
 * @param Number length - The length of the shape.
 * @param Number width - The width of the shape.
 * @param Number [quantity] - The number of shapes to place.
 * @param Number [line] - The expected number of shapes per line.
 */
module placeElements(length, width, quantity=1, line=undef) {
    length = getPrintInterval(length);
    width = getPrintInterval(width);
    quantity = getMaxQuantity(length, width, quantity);
    repeatGrid(
        count = quantity,
        intervalX = xAxis3D(length),
        intervalY = yAxis3D(width),
        line = getMaxLine(length, width, quantity, line),
        center = true
    ) {
        children();
    }
}
