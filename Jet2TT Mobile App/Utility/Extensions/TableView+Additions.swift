//
//  TableView+Additions.swift
//  RajeshSampleProject
//
//  Created by RajeshDeshmukh on 26/04/20.
//  Copyright © 2020 Yogita Bansode. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    /// This method registers an array of UITableViewCell subclasses types for resusing.
    /// The reuse id would be the same as string version of Class type.
    ///
    /// - Parameter clsArray: Array of UITableViewCell subclasses types
    func register(cells clsArray: [UITableViewCell.Type]) {
        for cls in clsArray {
            register(cellClass: cls)
        }
    }
    /// Templated method to registers UITableViewCell subclass type for resusing
    ///
    /// - Parameter cls: An UICollectionViewCell subclass type for resusing
    func register<T>(cellClass cls: T.Type) {
        let nibName = String(describing: cls)
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }

    /// Templated method to dequeue reusable cell, based on provided Type
    ///
    /// - Parameters:
    ///   - cls: Class type
    ///   - indexPath: Index path for dequeue
    /// - Returns: A reusable cell subclass of UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(cellClass cls: T.Type, for indexPath: IndexPath) -> T {
        let nibName = String(describing: cls)
        return dequeueReusableCell(withIdentifier: nibName, for: indexPath) as? T ?? T()
    }

    /// Templated method to dequeue reusable cell, based on provided Type
    ///
    /// - Parameters:
    ///   - cls: Class type
    /// - Returns: A reusable cell subclass of UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(cellClass cls: T.Type) -> T {
        let nibName = String(describing: cls)
        return dequeueReusableCell(withIdentifier: nibName) as? T  ?? T()
    }

    var cells: [UITableViewCell] {
        return (0..<self.numberOfSections).indices.map { (sectionIndex: Int) -> [UITableViewCell] in
            return (0..<self.numberOfRows(inSection: sectionIndex)).indices.compactMap { (rowIndex: Int) -> UITableViewCell? in
                return self.cellForRow(at: IndexPath(row: rowIndex, section: sectionIndex))
            }
            }.flatMap {$0}
    }
}

extension UITableView {

    /// Check if cell at the specific section and row is visible
    /// - Parameters:
    /// - section: an Int reprenseting a UITableView section
    /// - row: and Int representing a UITableView row
    /// - Returns: True if cell at section and row is visible, False otherwise
    func isCellVisible(section: Int, row: Int) -> Bool {
        guard let indexes = self.indexPathsForVisibleRows else {
            return false
        }
        return indexes.contains {$0.section == section && $0.row == row }
    }

}

extension UITableView {
    /// This method will used for set the height of table view's header using autolayout
    func layoutCompressedTableHeaderView() {

        guard let headerView = self.tableHeaderView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([headerView.widthAnchor.constraint(equalToConstant: headerView.bounds.size.width)])
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()

        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        self.tableHeaderView = headerView
    }
}
extension UITableView {
    /// Reload table animation completion handler
    /// - Parameter completion: completion handler
    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: { self.reloadData()}, completion: { (_:Bool) in completion()})
    }
}
