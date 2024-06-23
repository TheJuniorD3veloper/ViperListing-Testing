//
//  TitleTableViewCell.swift
//  ScalableTableView
//
//  Created by TheJunirD3v on 05/06/24.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    var viewModel: TitleTableViewCellVM? {
        didSet{
            self.labelTitle.text = viewModel?.title
            self.idLabel.text = viewModel?.id
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showData(viewModel: TitleTableViewCellVM) {
        
        self.viewModel = viewModel
    }
    
}
extension TitleTableViewCell:CellIdentifiable {
    
}



