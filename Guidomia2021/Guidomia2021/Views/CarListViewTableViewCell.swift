//
//  CarListViewTableViewCell.swift
//  Guidomia2021
//
//  Created by Parth Thakkar on 2023-04-05.
//

import UIKit

class CarListViewTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var vwImgCar: UIImageView!
    @IBOutlet weak var lblCarName: UILabel!
    @IBOutlet weak var lblCarPrice: UILabel!
    @IBOutlet weak var vwRating: JStarRatingView!
    @IBOutlet weak var lblPros: UILabel!
    @IBOutlet weak var lblCons: UILabel!
    @IBOutlet weak var vwMoreInfo: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: CarsList, isExpanded: Bool) {
        vwImgCar.image = UIImage(named: item.carImage)
        lblCarName.text = item.model
        lblCarPrice.text = String.formatPoints(num: item.customerPrice)
        vwRating.rating = Float(item.rating)
        if isExpanded {
            vwMoreInfo.isHidden = false
            lblPros.attributedText = formattedStringFromArray(inputArr: item.prosList.filter {$0 != ""})
            lblCons.attributedText = formattedStringFromArray(inputArr: item.consList.filter {$0 != ""})
        } else {
            vwMoreInfo.isHidden = true
            lblPros.attributedText = formattedStringFromArray(inputArr: item.prosList.filter {$0 != ""})
            lblCons.attributedText = formattedStringFromArray(inputArr: item.consList.filter {$0 != ""})
        }
        
    }

    func formattedStringFromArray(inputArr: [String]) -> NSAttributedString {
        let bullet = "• "
        var formattedStringArray = [String]()
        formattedStringArray = inputArr.map { bullet + $0 }
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = UIFont.boldSystemFont(ofSize: 14.0)
        attributes[.foregroundColor] = UIColor.black
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle

        let string = formattedStringArray.joined(separator: "\n")
        return NSAttributedString(string: string, attributes: attributes)
    }
}

extension String {
    static func formatPoints(num: Float) -> String {
        let convertedNum = String(num / 1000.0)
        var convertedNumString = String(describing: convertedNum)
        if num > 1000 && num < 1000000 {
            convertedNumString = String(describing: convertedNum.appending("k"))
        } else if num > 1000000 {
            convertedNumString = String(describing: convertedNum.appending("m"))
        }

        return convertedNumString
    }
}
