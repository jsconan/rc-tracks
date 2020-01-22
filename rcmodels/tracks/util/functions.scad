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
 * Defines some functions.
 *
 * @author jsconan
 * @version 0.1.0
 */

/**
 * Ajust a height with respect to the target layer height
 * @param Number height
 * @returns Number
 */
function adjustToLayer(height) = roundBy(height, printResolution);

/**
 * Ajust a width with respect to the target nozzle size
 * @param Number width
 * @returns Number
 */
function adjustToNozzle(width) = roundBy(width, nozzle);
