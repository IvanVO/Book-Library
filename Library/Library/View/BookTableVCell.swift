//
//  BookTableVCell.swift
//  Library
//
//  Created by Ivan Villanueva on 25/02/21.
//

import UIKit

class BookTableVCell: UITableViewCell, BookTVCellProtocol {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
