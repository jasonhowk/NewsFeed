//
//  MasterTableViewCell.swift
//  News Feed
//
//  Created by Jason Howk on 8/8/18.
//  Copyright © 2018 Rude Tie, LLC. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
    
    private var heroImageView: UIImageView!
    private var sourceLabel: UILabel!
    private var titleLabel: UILabel!
    
    var article:Article? {
        didSet {
            //heroImageView.image
            sourceLabel.text = article?.source.name
            titleLabel.text = article?.title
            
            setNeedsLayout()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sourceLabel = UILabel()
        sourceLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 0
        heroImageView = UIImageView(image: #imageLiteral(resourceName: "Placeholder2"))
        heroImageView.clipsToBounds = true
        heroImageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(sourceLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(heroImageView)

        // Constraints
        let marginsGuide = contentView.layoutMarginsGuide
        
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let constraints:[NSLayoutConstraint] = [
            heroImageView.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 8.0),
            heroImageView.heightAnchor.constraint(equalToConstant: 300),
            heroImageView.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            heroImageView.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor),
            sourceLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 8.0),
            sourceLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 8.0),
            titleLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor, constant: -8.0)
        ]
        NSLayoutConstraint.activate(constraints)
        
        
        
//        heroImageView.translatesAutoresizingMaskIntoConstraints = false
//        heroImageView.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 8.0).isActive = true
//        heroImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        heroImageView.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
//        heroImageView.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor).isActive = true
//
//        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
//        sourceLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 8.0).isActive = true
//        sourceLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
//
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 8.0).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor, constant: -8.0).isActive = true
        
        // DEBUG
        // contentView.backgroundColor = .gray
        // sourceLabel.backgroundColor = .red
        // titleLabel.backgroundColor = .blue
        heroImageView.backgroundColor = .green
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        
        // Do nothing.  We want the cell to be selectable without the UI changes as it will immediately
        // invoke a transition.
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    

}
