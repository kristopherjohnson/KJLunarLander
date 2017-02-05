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
/// - parameter left: Leftmost coordinate at which elements will be positioned.
/// - parameter top: Topmost coordinate at which elements will be positioned.
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

    var rowY = top

    var isFirstRow = true

    for row in rows {
        if isFirstRow {
            isFirstRow = false
        }
        else {
            rowY -= verticalPadding
            size.height += verticalPadding
        }

        let rowSize = layoutRow(left: left,
                                top: rowY,
                                horizontalPadding: horizontalPadding,
                                rowHeight: rowHeight,
                                columnLayouts: columnLayouts,
                                nodes: row)
        size.width = max(size.width, rowSize.width)
        size.height += rowSize.height
        rowY -= rowSize.height
    }

    return size
}

/// Positions a set of SKLabelNodes in a row from left to right.
///
/// - parameter left: Leftmost coordinate at which elements will be positioned.
/// - parameter top: Topmost coordinate at which elements will be positioned.
/// - parameter horizontalPadding: Space between rows.
/// - parameter rowHeight: Height of each row.
/// - parameter columnLayouts: Specification of column constraints.
/// - parameter nodes: Array of SKLabelNodes ordered from left to right.
///
/// - returns: Size of row.
func layoutRow(left: CGFloat,
               top: CGFloat,
               horizontalPadding: CGFloat,
               rowHeight: CGFloat,
               columnLayouts: [ColumnLayout],
               nodes: [SKLabelNode])
    -> CGSize
{
    assert(columnLayouts.count >= nodes.count, "columnLayouts must have at least as many elements as nodes")

    var size = CGSize(width: 0, height: rowHeight)

    var columnLeft = left

    var isFirstColumn = true

    for i in 0..<nodes.count {
        if isFirstColumn {
            columnLeft += horizontalPadding
            isFirstColumn = false
        }
        else {
            columnLeft += horizontalPadding
            size.width += horizontalPadding
        }

        let node = nodes[i]
        let columnLayout = columnLayouts[i]

        node.position.y = top

        switch columnLayout {

        case .left(let width):
            node.horizontalAlignmentMode = .left
            node.position.x = columnLeft
            columnLeft += width
            size.width += width

        case .right(let width):
            node.horizontalAlignmentMode = .right
            columnLeft += width
            node.position.x = columnLeft
            size.width += width
        }
    }

    return size
}
