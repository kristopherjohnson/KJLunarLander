//
//  GridLayout.swift
//  KJLunarLander
//
//  Copyright © 2017 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Specifies constraints for a column in a layout function.
enum ColumnLayout {
    /// Left-justified column.
    case left(width: CGFloat)

    /// Right-justified column.
    case right(width: CGFloat)
}

/// Positions a set of SKLabelNodes in a grid.
///
/// Sets the `position` and `horizontalAlignmentMode` properties
/// of each `SKLabelNode`.
///
/// - parameter left: X coordinate at which first-column elements will be positioned.
/// - parameter top: Y coordinate at which first-row elements will be positioned.
/// - parameter horizontalPadding: Space between rows.
/// - parameter verticalPadding: Space between columns.
/// - parameter rowHeight: Height of each row.
/// - parameter columnLayouts: Specification of column constraints.
/// - parameter rows: Array of rows, ordered from top to bottom, each of which is an array of nodes ordered from left to right.
///
/// - returns: Size of grid.
func layoutGrid(left: CGFloat,
                top: CGFloat,
                horizontalPadding: CGFloat,
                verticalPadding: CGFloat,
                rowHeight: CGFloat,
                columnLayouts: [ColumnLayout],
                rows: [[SKLabelNode]])
    -> CGSize
{
    var size = CGSize()

    var rowTop = top

    var isFirstRow = true

    for row in rows {
        if isFirstRow {
            isFirstRow = false
        }
        else {
            size.height += verticalPadding
            rowTop -= verticalPadding
        }

        let rowWidth = layoutRow(left: left,
                                 y: rowTop,
                                 horizontalPadding: horizontalPadding,
                                 rowHeight: rowHeight,
                                 columnLayouts: columnLayouts,
                                 nodes: row)
        size.width = max(size.width, rowWidth)
        size.height += rowHeight
        rowTop -= rowHeight
    }

    return size
}

/// Positions a set of SKLabelNodes in a row from left to right.
///
/// Sets the `position` and `horizontalAlignmentMode` properties
/// of each `SKLabelNode`.
///
/// - parameter left: X coordinate at which first-column element will be positioned.
/// - parameter y: Y coordinate at which elements will be positioned.
/// - parameter horizontalPadding: Space between rows.
/// - parameter rowHeight: Height of each row.
/// - parameter columnLayouts: Specification of column constraints.
/// - parameter nodes: Array of SKLabelNodes ordered from left to right.
///
/// - returns: Width of laid-out elements.
func layoutRow(left: CGFloat,
               y: CGFloat,
               horizontalPadding: CGFloat,
               rowHeight: CGFloat,
               columnLayouts: [ColumnLayout],
               nodes: [SKLabelNode])
    -> CGFloat
{
    assert(columnLayouts.count >= nodes.count,
           "columnLayouts must have at least as many elements as nodes")

    var totalWidth = CGFloat(0.0)

    var columnLeft = left

    var isFirstColumn = true

    for i in 0..<nodes.count {
        if isFirstColumn {
            isFirstColumn = false
        }
        else {
            columnLeft += horizontalPadding
            totalWidth += horizontalPadding
        }

        let node = nodes[i]
        let columnLayout = columnLayouts[i]

        node.position.y = y

        switch columnLayout {

        case .left(let width):
            node.horizontalAlignmentMode = .left
            node.position.x = columnLeft
            columnLeft += width
            totalWidth += width

        case .right(let width):
            node.horizontalAlignmentMode = .right
            columnLeft += width
            node.position.x = columnLeft
            totalWidth += width
        }
    }

    return totalWidth
}
