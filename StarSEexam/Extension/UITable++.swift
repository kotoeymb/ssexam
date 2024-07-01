//
//  UITable++.swift
//  StarSEexam
//
//  Created by Toe Wai Aung on 01/07/2024.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(from type: T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func getCell<T: UITableViewCell>(from type: T.Type, at indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func registerSectionHeader<T: UITableViewHeaderFooterView>(from type: T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
    
    func getSectionHeader<T: UITableViewHeaderFooterView>(from type: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T
    }
}

extension UICollectionView {
    
    func registerItem<T: UICollectionViewCell>(from type: T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func getItem<T: UICollectionViewCell>(from type: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
}
