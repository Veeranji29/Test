//
//  ListTableViewCell.swift
//  TestApp
//
//  Created by Veera Diande on 20/11/19.
//  Copyright © 2019 Brandenburg. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblDesc: UILabel?
    @IBOutlet weak var pictureImageView: UIImageView?
    var item: List? {
        didSet {
            guard let item = item else {
                return
            }
            lblTitle?.text = item.title
            lblDesc?.text = item.desc
            pictureImageView?.image = UIImage(named: item.url ?? "")
        }
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView?.image = nil
    }
}
