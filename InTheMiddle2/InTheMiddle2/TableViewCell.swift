import UIKit

class TableViewCell: UITableViewCell {
    
//    let imgRestaurant = UIImageView()
    let labRestaurant = UILabel()
    let labAddress = UILabel()
//    let labRating = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        imgRestaurant.translatesAutoresizingMaskIntoConstraints = false
        labRestaurant.translatesAutoresizingMaskIntoConstraints = false
        labAddress.translatesAutoresizingMaskIntoConstraints = false
//        labRating.translatesAutoresizingMaskIntoConstraints = false
        
//        contentView.addSubview(imgRestaurant)
        contentView.addSubview(labRestaurant)
        contentView.addSubview(labAddress)
//        contentView.addSubview(labRating)
        
        let viewsDict = [
//            "image" : imgRestaurant,
            "name" : labRestaurant,
            "address" : labAddress,
//            "rating" : labRating,
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[name]-[address]-|", options: [], metrics: nil, views: viewsDict))
        
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(10)]", options: [], metrics: nil, views: viewsDict))
        
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[rating]-|", options: [], metrics: nil, views: viewsDict))
        
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[name]-[image(10)]-|", options: [], metrics: nil, views: viewsDict))
        
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[address]-[rating]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

